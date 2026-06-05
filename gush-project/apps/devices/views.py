"""
设备相关视图
- MachineViewSet: 列表 / 详情 / 创建 / 修改 / 删除
- ChannelViewSet: 单货道补货 / 测试出货 / 标记故障 / 清除故障
- 出货 / 故障 日志列表（嵌套于 machine 下）

注意：
- 测试出货只写日志，不真正下发硬件（阶段 3 接入 WebSocket 后再补充实际下发逻辑）
- 故障记录 / 心跳记录由设备端在阶段 3 主动上报
"""
from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
from django.db import transaction
from django.db.models import Count, Q
from django.shortcuts import get_object_or_404, render
from django.utils import timezone
from django.views.decorators.cache import never_cache
from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from apps.products import services as stock_services
from apps.products.models import Product

from .models import Channel, DispenseLog, FaultLog, HeartbeatLog, Machine
from .serializers import (
    ChannelMarkFaultSerializer,
    ChannelRestockSerializer,
    ChannelSerializer,
    DispenseLogSerializer,
    FaultLogSerializer,
    HeartbeatLogSerializer,
    MachineCreateSerializer,
    MachineDetailSerializer,
    MachineListSerializer,
)


class MachineViewSet(viewsets.ModelViewSet):
    """
    GET    /api/devices/machines/                 列表（支持 search / status 过滤）
    POST   /api/devices/machines/                 新建（自动生成 60 货道）
    GET    /api/devices/machines/{id}/            详情（含所有货道）
    PATCH  /api/devices/machines/{id}/            修改基本信息
    DELETE /api/devices/machines/{id}/            删除
    GET    /api/devices/machines/{id}/dispenses/  最近出货日志
    GET    /api/devices/machines/{id}/faults/     最近故障日志
    GET    /api/devices/machines/{id}/heartbeats/ 最近心跳日志
    """
    permission_classes = (IsAuthenticated,)
    queryset = Machine.objects.all()

    def get_queryset(self):
        qs = Machine.objects.all().select_related("bound_project")
        # 注入轻量聚合
        qs = qs.annotate(
            _total_channels=Count("channels"),
            _online_channels=Count("channels", filter=~Q(channels__status=Channel.Status.FAULT)),
        )

        search = self.request.query_params.get("search")
        if search:
            qs = qs.filter(
                Q(machine_id__icontains=search)
                | Q(name__icontains=search)
                | Q(address__icontains=search)
            )

        status_filter = self.request.query_params.get("status")
        if status_filter in Machine.Status.values:
            qs = qs.filter(status=status_filter)

        return qs

    def get_serializer_class(self):
        if self.action == "list":
            return MachineListSerializer
        if self.action == "create":
            return MachineCreateSerializer
        return MachineDetailSerializer

    def create(self, request, *args, **kwargs):
        """create 用专门的 serializer，返回详情数据"""
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        machine = serializer.save()
        out = MachineDetailSerializer(machine, context=self.get_serializer_context())
        return Response(out.data, status=status.HTTP_201_CREATED)

    @action(detail=True, methods=["get"])
    def dispenses(self, request, pk=None):
        machine = self.get_object()
        qs = machine.dispenses.all()[:200]
        return Response(DispenseLogSerializer(qs, many=True).data)

    @action(detail=True, methods=["get"])
    def faults(self, request, pk=None):
        machine = self.get_object()
        only_open = request.query_params.get("open") == "1"
        qs = machine.faults.all()
        if only_open:
            qs = qs.filter(resolved=False)
        qs = qs[:200]
        return Response(FaultLogSerializer(qs, many=True).data)

    @action(detail=True, methods=["get"], permission_classes=[])
    def qrcode(self, request, pk=None):
        """
        GET /api/devices/machines/{id}/qrcode/?url=<encoded_url>&size=512
        生成任意 URL 的 PNG 二维码。QR 内容仅来自 ?url= 参数本身，无敏感数据，所以公开。
        """
        import io
        import qrcode
        from django.http import HttpResponse
        from .models import Machine

        # 不走 self.get_object() 避免触发权限检查
        machine = Machine.objects.filter(pk=pk).first()
        if not machine:
            return HttpResponse(status=404)
        url = request.query_params.get("url", "").strip()
        if not url:
            url = machine.public_url
        try:
            size = max(128, min(1024, int(request.query_params.get("size", 512))))
        except (TypeError, ValueError):
            size = 512

        img = qrcode.make(url, box_size=max(2, size // 64), border=2)
        if hasattr(img, "resize"):
            img = img.resize((size, size))
        buf = io.BytesIO()
        img.save(buf, format="PNG")
        resp = HttpResponse(buf.getvalue(), content_type="image/png")
        resp["Cache-Control"] = "public, max-age=3600"
        return resp

    @action(detail=True, methods=["get"])
    def heartbeats(self, request, pk=None):
        machine = self.get_object()
        qs = machine.heartbeats.all()[:50]
        return Response(HeartbeatLogSerializer(qs, many=True).data)

    @action(detail=True, methods=["post"])
    def bulk_restock(self, request, pk=None):
        """
        批量补货 / 一键补满。
        body: {
          "channel_ids": [int, ...]   (可选；不传 = 所有「已绑礼品 + 非故障 + 未满」的货道)
          "product_id":  int          (可选；传了表示「批量投放此礼品」，会绑定到未绑货道)
          "max_per_channel": int      (可选；默认 = 货道 capacity，每个货道最多补这么多)
          "note": str                 (可选)
        }

        语义：
          - 不传 product_id，不传 channel_ids → 巡补：所有已绑货道补到满
          - 不传 product_id，传 channel_ids   → 巡补指定货道（每个货道用各自绑定的礼品）
          - 传 product_id，传 channel_ids     → 批量投放：给这些货道装/补这个礼品
          - 传 product_id，不传 channel_ids   → 拒绝（要求必须显式选目标货道）

        约束（针对每个货道）：
          - 故障 → skipped(reason=fault)
          - 已满 → skipped(reason=full)
          - 货道未绑礼品 且 未指定 product_id → skipped(reason=no_product)
          - 指定 product_id 与现有绑定不同 且 当前货道有库存 → skipped(reason=conflict_with_existing)
          - 仓库不足 → 部分补（partial）或 skipped(reason=warehouse_empty)
        """
        machine: Machine = self.get_object()
        body = request.data or {}
        product_id = body.get("product_id")
        channel_ids = body.get("channel_ids") or []
        max_per_channel = body.get("max_per_channel")
        note = (body.get("note") or "")[:255]

        if product_id and not channel_ids:
            return Response(
                {"detail": "批量投放（指定 product_id）时必须显式传 channel_ids，防止把礼品装满整台机器"},
                status=400,
            )

        # 选出待处理货道集
        ch_qs = machine.channels.select_related("product").order_by("row", "col")
        if channel_ids:
            ch_qs = ch_qs.filter(id__in=channel_ids)
        else:
            # 默认：已绑 + 非故障 + 未满
            ch_qs = ch_qs.exclude(product__isnull=True).exclude(status=Channel.Status.FAULT)

        channels = list(ch_qs)
        if not channels:
            return Response({"detail": "没有可处理的货道", "summary": {"filled": 0}, "details": []})

        # 一次性确定每个货道最终要用的 product_id
        target_pid_for_ch = {}
        details = []  # 累计每个货道的处理结果
        for ch in channels:
            # 解析目标礼品
            pid = product_id if product_id else ch.product_id
            if not pid:
                details.append({
                    "channel_id": ch.id, "channel_code": ch.channel_code,
                    "status": "skipped", "reason": "no_product",
                    "qty": 0, "channel_stock_after": ch.current_stock,
                })
                continue
            target_pid_for_ch[ch.id] = pid

        # 按 product 分组
        from collections import defaultdict
        per_product = defaultdict(list)
        for ch in channels:
            pid = target_pid_for_ch.get(ch.id)
            if pid:
                per_product[pid].append(ch)

        warehouse_changes = []  # [{product_id, sku, name, deducted, after}]

        with transaction.atomic():
            # 一次锁住所有涉及的 Product
            products = {
                p.id: p for p in Product.objects.select_for_update().filter(
                    id__in=list(per_product.keys())
                )
            }
            for pid, chs in per_product.items():
                product = products.get(pid)
                if product is None:
                    for ch in chs:
                        details.append({
                            "channel_id": ch.id, "channel_code": ch.channel_code,
                            "status": "skipped", "reason": "product_not_found",
                            "qty": 0, "channel_stock_after": ch.current_stock,
                        })
                    continue

                deducted = 0
                for ch in chs:
                    # 重新锁 channel
                    locked = Channel.objects.select_for_update().get(pk=ch.pk)

                    # 故障
                    if locked.status == Channel.Status.FAULT:
                        details.append({
                            "channel_id": locked.id, "channel_code": locked.channel_code,
                            "status": "skipped", "reason": "fault",
                            "qty": 0, "channel_stock_after": locked.current_stock,
                        })
                        continue
                    # 换品冲突
                    if locked.product_id and locked.product_id != product.id and locked.current_stock > 0:
                        details.append({
                            "channel_id": locked.id, "channel_code": locked.channel_code,
                            "status": "skipped", "reason": "conflict_with_existing",
                            "qty": 0, "channel_stock_after": locked.current_stock,
                        })
                        continue
                    # 已满
                    free_slots = max(0, locked.capacity - locked.current_stock)
                    if free_slots <= 0:
                        details.append({
                            "channel_id": locked.id, "channel_code": locked.channel_code,
                            "status": "skipped", "reason": "full",
                            "qty": 0, "channel_stock_after": locked.current_stock,
                        })
                        continue
                    # 仓库余量
                    if (product.total_stock or 0) <= 0:
                        details.append({
                            "channel_id": locked.id, "channel_code": locked.channel_code,
                            "status": "skipped", "reason": "warehouse_empty",
                            "qty": 0, "channel_stock_after": locked.current_stock,
                        })
                        continue

                    # 实际可补
                    want = free_slots
                    if max_per_channel:
                        try:
                            want = min(want, int(max_per_channel))
                        except (TypeError, ValueError):
                            pass
                    actual = min(want, product.total_stock)
                    if actual <= 0:
                        details.append({
                            "channel_id": locked.id, "channel_code": locked.channel_code,
                            "status": "skipped", "reason": "warehouse_empty",
                            "qty": 0, "channel_stock_after": locked.current_stock,
                        })
                        continue

                    # 执行
                    locked.product_id = product.id
                    locked.current_stock += actual
                    locked.save(update_fields=["current_stock", "product", "updated_at"])
                    locked.recompute_status(save=True)

                    product.total_stock -= actual
                    deducted += actual

                    stock_services.record_restock(
                        product=product,
                        channel=locked,
                        quantity=actual,
                        warehouse_after=product.total_stock,
                        channel_stock_after=locked.current_stock,
                        operator=request.user if request.user.is_authenticated else None,
                        note=note or "批量补货",
                    )

                    is_full = locked.current_stock >= locked.capacity
                    details.append({
                        "channel_id": locked.id, "channel_code": locked.channel_code,
                        "status": "filled" if is_full else "partial",
                        "reason": None if is_full else "warehouse_limited",
                        "qty": actual, "channel_stock_after": locked.current_stock,
                    })

                # 落盘 product 总库存
                product.save(update_fields=["total_stock", "updated_at"])
                warehouse_changes.append({
                    "product_id": product.id,
                    "sku": product.sku,
                    "name": product.name,
                    "deducted": deducted,
                    "warehouse_after": product.total_stock,
                })

        # summary
        filled = sum(1 for d in details if d["status"] == "filled")
        partial = sum(1 for d in details if d["status"] == "partial")
        skipped = sum(1 for d in details if d["status"] == "skipped")
        total_qty = sum(d["qty"] for d in details)

        return Response({
            "summary": {
                "channels_processed": len(details),
                "filled": filled,
                "partial": partial,
                "skipped": skipped,
                "total_qty": total_qty,
            },
            "warehouse_changes": warehouse_changes,
            "details": details,
        })

    @action(detail=True, methods=["post"])
    def send_command(self, request, pk=None):
        """
        通过 WebSocket 下发指令给设备。
        body 示例：
          {"cmd":"motor_run","id":1,"num":1}    # 出指定货道 1 次
          {"cmd":"motor_run","channel":"A0","num":1}  # 用货道编码（服务端转换）
        """
        machine = self.get_object()
        payload = dict(request.data or {})
        cmd = payload.get("cmd")
        if not cmd:
            return Response({"detail": "缺少 cmd 字段"}, status=400)

        # 允许用 channel_code 代替 id
        if cmd == "motor_run" and "id" not in payload and "channel" in payload:
            ch_code = str(payload.pop("channel"))[:4]
            channel = machine.channels.filter(channel_code=ch_code).first()
            if not channel:
                return Response({"detail": f"货道 {ch_code} 不存在"}, status=400)
            # A0→1, A9→10, B0→11, ..., F9→60
            payload["id"] = (ord(ch_code[0]) - ord("A")) * 10 + int(ch_code[1]) + 1
            payload["num"] = int(payload.get("num") or 1)

        layer = get_channel_layer()
        if layer is None:
            return Response({"detail": "Channel layer 未配置"}, status=500)

        async_to_sync(layer.group_send)(
            f"device_{machine.machine_id}",
            {"type": "device.command", "payload": payload},
        )
        return Response({"detail": "已下发", "payload": payload, "machine_id": machine.machine_id})


# ---------- Phase 4.1 设备健康看板 ----------
from rest_framework.decorators import api_view as _drf_api_view, permission_classes as _drf_permission_classes


@_drf_api_view(["GET"])
@_drf_permission_classes([IsAuthenticated])
def device_health_overview(request):
    """
    GET /api/devices/health/overview/
    返回全局健康摘要 + 每台设备的关键指标
    """
    from datetime import timedelta
    from django.db.models import Count, Q
    from django.utils import timezone
    from django.conf import settings
    from .models import FaultLog, HeartbeatLog, Machine

    now = timezone.now()
    week_ago = now - timedelta(days=7)
    today_start = now.replace(hour=0, minute=0, second=0, microsecond=0)
    timeout = getattr(settings, "HEARTBEAT_TIMEOUT_SECONDS", 90)

    by_status = dict(
        Machine.objects.values_list("status").annotate(c=Count("id")).values_list("status", "c")
    )
    total = sum(by_status.values())
    online = by_status.get("online", 0)

    fault_today = FaultLog.objects.filter(created_at__gte=today_start).count()
    fault_open = FaultLog.objects.filter(resolved=False).count()

    trend_qs = (
        HeartbeatLog.objects
        .filter(received_at__gte=week_ago)
        .extra(select={"d": "DATE(received_at)"})
        .values("d").annotate(c=Count("id"))
    )
    by_day = {str(r["d"]): r["c"] for r in trend_qs}
    trend = []
    for i in range(7):
        d = (week_ago + timedelta(days=i + 1)).date().isoformat()
        trend.append({"date": d, "heartbeats": by_day.get(d, 0)})

    fault_rank = list(
        Machine.objects
        .annotate(open_faults=Count("faults", filter=Q(faults__resolved=False)))
        .filter(open_faults__gt=0)
        .order_by("-open_faults")
        .values("id", "machine_id", "name", "open_faults")[:10]
    )

    machines = (
        Machine.objects.all()
        .annotate(
            open_fault_count=Count("faults", filter=Q(faults__resolved=False)),
            channel_fault=Count("channels", filter=Q(channels__status="fault")),
        )
        .order_by("status", "machine_id")
    )
    items = []
    for m in machines:
        last_hb = m.last_heartbeat_at
        seconds_since = int((now - last_hb).total_seconds()) if last_hb else None
        is_stale = (last_hb is None) or (seconds_since and seconds_since > timeout)
        items.append({
            "id": m.id,
            "machine_id": m.machine_id,
            "name": m.name,
            "subdomain": m.subdomain,
            "status": m.status,
            "last_heartbeat_at": last_hb.isoformat() if last_hb else None,
            "seconds_since_heartbeat": seconds_since,
            "stale": is_stale,
            "signal_strength": m.signal_strength,
            "network_type": m.network_type,
            "firmware_version": m.firmware_version,
            "runtime_seconds": m.runtime_seconds,
            "open_fault_count": m.open_fault_count,
            "channel_fault_count": m.channel_fault,
        })

    return Response({
        "summary": {
            "total": total,
            "online": online,
            "offline": by_status.get("offline", 0),
            "fault": by_status.get("fault", 0),
            "online_rate": round(online / total * 100, 2) if total else 0,
            "fault_open": fault_open,
            "fault_today": fault_today,
            "heartbeat_timeout_seconds": timeout,
        },
        "trend": trend,
        "fault_rank": fault_rank,
        "machines": items,
    })


# ---------- 远程控制台（不在 DRF 路由） ----------
@never_cache
def device_console(request, machine_id: str):
    """
    Qt WebView 通过 https://machineXXX.gush.cdgushai.com/device/console/?secret=xxx 载入此页。
    页面 JS 自己打开 wss://...同源.../ws/device/?machine_id=X&secret=Y。
    出于安全考虑：必须带正确 secret（不在 HTML 中暴露，前端只用于建 WS 连接）。
    """
    from .models import Machine
    machine = get_object_or_404(Machine, machine_id=machine_id)
    secret = request.GET.get("secret", "")
    if secret != machine.comm_secret:
        return render(request, "device_console.html", {
            "error": "鉴权失败：secret 不匹配",
            "machine_id": machine_id,
        }, status=403)

    return render(request, "device_console.html", {
        "error": None,
        "machine_id": machine.machine_id,
        "secret": machine.comm_secret,
    })


class ChannelViewSet(
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    mixins.ListModelMixin,
    viewsets.GenericViewSet,
):
    """
    GET   /api/devices/channels/?machine={id}    列表（必须传 machine）
    GET   /api/devices/channels/{id}/            详情
    PATCH /api/devices/channels/{id}/            修改（绑定商品 / 调整库存）
    POST  /api/devices/channels/{id}/restock/    补货
    POST  /api/devices/channels/{id}/dispense/   测试出货（仅记录日志，阶段 3 接硬件）
    POST  /api/devices/channels/{id}/fault/      标记/清除故障
    """
    permission_classes = (IsAuthenticated,)
    serializer_class = ChannelSerializer
    queryset = Channel.objects.all()

    def get_queryset(self):
        qs = Channel.objects.all().select_related("machine", "product")
        machine_id = self.request.query_params.get("machine")
        if machine_id:
            qs = qs.filter(machine_id=machine_id)
        return qs

    @action(detail=True, methods=["post"])
    def restock(self, request, pk=None):
        """
        补货：从仓库 (Product.total_stock) 出库 → 装到该货道。
        请求体: {"quantity": N, "product_id": X(可选，新装/换品时必填)}
        约束：
          - 必须有绑定商品（已绑则 product_id 可缺省）
          - quantity 不能超过仓库剩余总库存
          - 装载后不能超过货道 capacity（按 capacity-current_stock 自动 cap）
        """
        channel: Channel = self.get_object()
        ser = ChannelRestockSerializer(data=request.data, context={"channel": channel})
        ser.is_valid(raise_exception=True)
        req_qty = ser.validated_data["quantity"]
        product_id = ser.validated_data.get("product_id") or channel.product_id

        if not product_id:
            return Response({"detail": "请先选择礼品"}, status=400)

        with transaction.atomic():
            # 行锁 product，防止并发补货超扣仓库
            product = Product.objects.select_for_update().filter(pk=product_id).first()
            if not product:
                return Response({"detail": "礼品不存在"}, status=400)

            channel = Channel.objects.select_for_update().get(pk=channel.pk)

            # 换品：若货道已绑定其他商品且有存货，禁止直接换（必须先清空或回库）
            if channel.product_id and channel.product_id != product.id and channel.current_stock > 0:
                return Response(
                    {"detail": "该货道已绑定其他礼品且有存货，请先回库后再换品"},
                    status=400,
                )

            # 实际可补 = min(请求量, 货道剩余空位, 仓库剩余)
            free_slots = max(0, channel.capacity - channel.current_stock)
            actual = min(req_qty, free_slots, product.total_stock or 0)
            if actual <= 0:
                return Response({
                    "detail": "无法补货",
                    "reason": {
                        "requested": req_qty,
                        "channel_free_slots": free_slots,
                        "warehouse_stock": product.total_stock or 0,
                    }
                }, status=400)

            channel.product_id = product.id
            channel.current_stock += actual
            channel.save(update_fields=["current_stock", "product", "updated_at"])
            channel.recompute_status(save=True)

            product.total_stock = (product.total_stock or 0) - actual
            product.save(update_fields=["total_stock", "updated_at"])

            stock_services.record_restock(
                product=product,
                channel=channel,
                quantity=actual,
                warehouse_after=product.total_stock,
                channel_stock_after=channel.current_stock,
                operator=request.user if request.user.is_authenticated else None,
                note=ser.validated_data.get("note", "") if "note" in ser.validated_data else "",
            )

        data = ChannelSerializer(channel).data
        data["restocked"] = actual
        data["warehouse_left"] = product.total_stock
        return Response(data)

    @action(detail=True, methods=["post"])
    def return_to_warehouse(self, request, pk=None):
        """
        回库：把货道里剩余的 N 件回收到仓库。
        body: {"quantity": N(可选，默认全部), "note": "..."}
        约束：
          - 货道必须已绑定商品
          - quantity > 0 且 <= 当前货道库存
          - 故障货道也允许回库（运维下架）
        副作用：货道 current_stock -= N；Product.total_stock += N；写两条流水。
        若回库后货道为空，自动解绑 product。
        """
        channel: Channel = self.get_object()
        try:
            req_qty = int(request.data.get("quantity") or 0)
        except (TypeError, ValueError):
            return Response({"detail": "quantity 必须为整数"}, status=400)
        note = (request.data.get("note") or "")[:255]

        with transaction.atomic():
            channel = Channel.objects.select_for_update().get(pk=channel.pk)
            if not channel.product_id:
                return Response({"detail": "货道未绑定礼品，无需回库"}, status=400)
            if channel.current_stock <= 0:
                return Response({"detail": "货道库存为空，无需回库"}, status=400)

            # 默认回库全部
            if req_qty <= 0:
                req_qty = channel.current_stock
            actual = min(req_qty, channel.current_stock)

            product = Product.objects.select_for_update().get(pk=channel.product_id)

            channel.current_stock -= actual
            unbind = channel.current_stock == 0
            update_fields = ["current_stock", "updated_at"]
            if unbind:
                channel.product = None
                update_fields.append("product")
            channel.save(update_fields=update_fields)
            channel.recompute_status(save=True)

            product.total_stock = (product.total_stock or 0) + actual
            product.save(update_fields=["total_stock", "updated_at"])

            stock_services.record_return(
                product=product,
                channel=channel,
                quantity=actual,
                warehouse_after=product.total_stock,
                channel_stock_after=channel.current_stock,
                operator=request.user if request.user.is_authenticated else None,
                note=note,
            )

        data = ChannelSerializer(channel).data
        data["returned"] = actual
        data["warehouse_left"] = product.total_stock
        data["unbound"] = unbind
        return Response(data)

    @action(detail=True, methods=["post"])
    def dispense(self, request, pk=None):
        """
        测试出货：
        - 阶段 2：库存减 1，记录一条 success 日志
        - 阶段 3：通过 WebSocket 真正下发 {"cmd":"motor_run","id":N,"num":1}
        """
        channel: Channel = self.get_object()
        if channel.status == Channel.Status.FAULT:
            return Response({"detail": "货道处于故障状态，请先清除故障"}, status=400)
        if channel.current_stock <= 0:
            DispenseLog.objects.create(
                machine=channel.machine,
                channel=channel,
                channel_code=channel.channel_code,
                result=DispenseLog.Result.EMPTY,
                detail="测试出货失败：库存为 0",
            )
            return Response({"detail": "货道为空，无法出货"}, status=400)

        with transaction.atomic():
            channel.current_stock -= 1
            channel.last_dispense_at = timezone.now()
            channel.save(update_fields=["current_stock", "last_dispense_at", "updated_at"])
            channel.recompute_status(save=True)

            log = DispenseLog.objects.create(
                machine=channel.machine,
                channel=channel,
                channel_code=channel.channel_code,
                result=DispenseLog.Result.SUCCESS,
                detail="后台测试出货",
            )
            if channel.product_id:
                stock_services.record_dispense(
                    product=channel.product,
                    channel=channel,
                    quantity=1,
                    channel_stock_after=channel.current_stock,
                    dispense_log=log,
                    source="test_dispense",
                    operator=request.user if request.user.is_authenticated else None,
                    note="后台测试出货",
                )
        return Response(ChannelSerializer(channel).data)

    @action(detail=True, methods=["post"])
    def fault(self, request, pk=None):
        channel: Channel = self.get_object()
        ser = ChannelMarkFaultSerializer(data=request.data)
        ser.is_valid(raise_exception=True)
        is_fault = ser.validated_data["fault"]
        message = ser.validated_data.get("message", "")

        if is_fault:
            channel.status = Channel.Status.FAULT
            channel.fault_message = message or "人工标记故障"
            channel.save(update_fields=["status", "fault_message", "updated_at"])
            FaultLog.objects.create(
                machine=channel.machine,
                channel=channel,
                severity=FaultLog.Severity.WARN,
                code="manual",
                message=channel.fault_message,
            )
        else:
            # 清除故障：先把状态从 fault 摘掉（否则 recompute_status 会早退保护，
            # 永远刷不回 normal/low/empty），再按库存重新判定
            channel.fault_message = ""
            channel.status = Channel.Status.NORMAL  # 占位值，立刻被 recompute_status 覆盖
            channel.save(update_fields=["fault_message", "status", "updated_at"])
            channel.recompute_status(save=True)
            FaultLog.objects.filter(
                channel=channel, resolved=False,
            ).update(resolved=True, resolved_at=timezone.now())

        return Response(ChannelSerializer(channel).data)
