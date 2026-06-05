"""
WebSocket Consumer - 设备端

连接流程：
  Qt WebView 载入 https://machineXXX.gush.cdgushai.com/console/?machine_id=X&secret=Y
  → 页面 JS 打开 wss://同上/ws/device/?machine_id=X&secret=Y
  → DeviceConsumer.connect 校验 secret 是否与 Machine.comm_secret 匹配
  → 加入 group "device_<machine_id>"
  → 周期性收发：
      ↓ 服务器下发：{"cmd":"motor_run","id":N,"num":1}（来自后台 send_command）
      ↑ 设备上报：
          {"cmd":"heartbeat","signal":85,"network":"4G"}
          {"cmd":"motor_done","id":N,"state":0,"fault":0}
          {"cmd":"fault","channel":"A0","code":"E03","message":"电机过流"}
"""
import json
import logging
from urllib.parse import parse_qs

from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncJsonWebsocketConsumer
from django.utils import timezone

logger = logging.getLogger("apps.devices.consumers")


def _group_name(machine_id: str) -> str:
    return f"device_{machine_id}"


class DeviceConsumer(AsyncJsonWebsocketConsumer):
    """设备 WebSocket。一条连接 = 一台机器。"""

    async def connect(self):
        # 解析 query string
        qs = parse_qs(self.scope["query_string"].decode())
        machine_id = (qs.get("machine_id") or [""])[0]
        secret = (qs.get("secret") or [""])[0]

        if not machine_id or not secret:
            await self.close(code=4001)  # 缺参数
            return

        machine = await self._authenticate(machine_id, secret)
        if machine is None:
            logger.warning("WS auth failed: machine_id=%s", machine_id)
            await self.close(code=4003)  # 鉴权失败
            return

        self.machine_id = machine_id
        self.machine_pk = machine["pk"]
        self.group = _group_name(machine_id)
        await self.channel_layer.group_add(self.group, self.channel_name)
        await self.accept()
        await self._mark_online()
        logger.info("Device WS connected: %s", machine_id)
        await self.send_json({"cmd": "connected", "machine_id": machine_id})

    async def disconnect(self, code):
        if hasattr(self, "group"):
            await self.channel_layer.group_discard(self.group, self.channel_name)
        if hasattr(self, "machine_id"):
            await self._mark_offline()
            logger.info("Device WS disconnected: %s (code=%s)", self.machine_id, code)

    async def receive_json(self, content, **kwargs):
        """处理设备上报"""
        cmd = content.get("cmd")
        if cmd == "heartbeat":
            await self._handle_heartbeat(content)
            await self.send_json({"cmd": "heartbeat_ack", "ts": timezone.now().isoformat()})
        elif cmd == "motor_done":
            await self._handle_motor_done(content)
        elif cmd == "fault":
            await self._handle_fault(content)
        else:
            logger.debug("Unknown cmd from %s: %s", getattr(self, "machine_id", "?"), content)

    # ---------- 由 channel layer 推送的事件 ----------
    async def device_command(self, event):
        """
        被 group_send 触发，向设备下发指令。
        event = {"type": "device.command", "payload": {...}}
        """
        await self.send_json(event["payload"])

    # ---------- DB 读写（同步包装） ----------
    @database_sync_to_async
    def _authenticate(self, machine_id, secret):
        from .models import Machine
        try:
            m = Machine.objects.only("id", "comm_secret").get(machine_id=machine_id)
        except Machine.DoesNotExist:
            return None
        if m.comm_secret != secret:
            return None
        return {"pk": m.id}

    @database_sync_to_async
    def _mark_online(self):
        from .models import Machine
        Machine.objects.filter(pk=self.machine_pk).update(
            status=Machine.Status.ONLINE,
            last_heartbeat_at=timezone.now(),
        )

    @database_sync_to_async
    def _mark_offline(self):
        from .models import Machine
        Machine.objects.filter(pk=self.machine_pk).update(status=Machine.Status.OFFLINE)

    @database_sync_to_async
    def _handle_heartbeat(self, payload):
        from .models import HeartbeatLog, Machine
        signal = int(payload.get("signal") or 0)
        network = (payload.get("network") or "")[:16]
        Machine.objects.filter(pk=self.machine_pk).update(
            status=Machine.Status.ONLINE,
            last_heartbeat_at=timezone.now(),
            signal_strength=signal,
            network_type=network,
        )
        HeartbeatLog.objects.create(
            machine_id=self.machine_pk,
            signal_strength=signal,
            network_type=network,
            payload=payload,
        )

    @database_sync_to_async
    def _handle_motor_done(self, payload):
        """
        STM32 出货完成：{"cmd":"motor_done","id":N,"state":0,"fault":0}
        state=0 成功；fault!=0 故障
        """
        from django.db import transaction
        from apps.products import services as stock_services
        from apps.projects.models import RedeemCode
        from .models import Channel, DispenseLog
        motor_id = int(payload.get("id") or 0)
        state = int(payload.get("state") or 0)
        fault = int(payload.get("fault") or 0)

        # motor_id 1..60 → row/col 反推
        if not (1 <= motor_id <= 60):
            return
        idx = motor_id - 1
        row_idx, col = divmod(idx, 10)
        row = "ABCDEF"[row_idx]
        channel_code = f"{row}{col}"

        channel = (
            Channel.objects
            .select_related("product", "machine")
            .filter(machine_id=self.machine_pk, channel_code=channel_code)
            .first()
        )

        if state == 0 and fault == 0:
            result = DispenseLog.Result.SUCCESS
            detail = "出货成功"
            with transaction.atomic():
                product = None
                if channel:
                    locked = Channel.objects.select_for_update().get(pk=channel.pk)
                    locked.current_stock = max(0, locked.current_stock - 1)
                    locked.last_dispense_at = timezone.now()
                    locked.save(update_fields=["current_stock", "last_dispense_at", "updated_at"])
                    locked.recompute_status(save=True)
                    channel = locked
                    product = channel.product
                # 关联兑换码：找最近一条 busy 状态的待结算记录
                redeem = None
                if channel:
                    pending = (
                        DispenseLog.objects
                        .filter(machine_id=self.machine_pk, channel=channel,
                                result=DispenseLog.Result.BUSY)
                        .order_by("-created_at").first()
                    )
                    if pending and pending.redeem_code_id:
                        pending.result = DispenseLog.Result.SUCCESS
                        pending.detail = "设备回报出货成功"
                        pending.save(update_fields=["result", "detail"])
                        redeem = pending.redeem_code
                        log = pending
                    else:
                        log = DispenseLog.objects.create(
                            machine_id=self.machine_pk,
                            channel=channel,
                            channel_code=channel_code,
                            result=result,
                            detail=detail,
                        )
                else:
                    log = DispenseLog.objects.create(
                        machine_id=self.machine_pk,
                        channel=None,
                        channel_code=channel_code,
                        result=result,
                        detail=detail,
                    )

                if product and channel:
                    stock_services.record_dispense(
                        product=product,
                        channel=channel,
                        quantity=1,
                        channel_stock_after=channel.current_stock,
                        redeem_code=redeem,
                        dispense_log=log,
                        source="motor_done",
                        note="设备回报出货完成",
                    )
        else:
            result = DispenseLog.Result.ERROR
            detail = f"state={state} fault={fault}"
            DispenseLog.objects.create(
                machine_id=self.machine_pk,
                channel=channel,
                channel_code=channel_code,
                result=result,
                detail=detail,
            )

    @database_sync_to_async
    def _handle_fault(self, payload):
        from .models import Channel, FaultLog
        channel_code = (payload.get("channel") or "")[:4]
        code = (payload.get("code") or "")[:32]
        message = (payload.get("message") or "")[:255]
        severity = payload.get("severity") or FaultLog.Severity.WARN

        channel = None
        if channel_code:
            channel = Channel.objects.filter(
                machine_id=self.machine_pk, channel_code=channel_code
            ).first()
            if channel:
                channel.status = Channel.Status.FAULT
                channel.fault_message = message or code or "设备上报故障"
                channel.save(update_fields=["status", "fault_message", "updated_at"])

        FaultLog.objects.create(
            machine_id=self.machine_pk,
            channel=channel,
            severity=severity if severity in dict(FaultLog.Severity.choices) else FaultLog.Severity.WARN,
            code=code,
            message=message or "未提供故障描述",
        )
