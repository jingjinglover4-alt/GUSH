"""
设备模型
- Machine: 派样机本体（1 台 = 60 个货道 × 容量 5 = 300 个样品位）
- Channel: 货道（编号 A0–F9，与 STM32 串口协议一致）
- HeartbeatLog: 心跳上报历史
- DispenseLog: 出货历史
- FaultLog: 故障告警
"""
import secrets

from django.conf import settings
from django.db import models, transaction
from django.utils import timezone


class Machine(models.Model):
    """派样机设备"""
    class DispenseStrategy(models.TextChoices):
        SEQUENTIAL = "sequential", "顺序出货"
        RANDOM = "random", "随机出货"

    class Status(models.TextChoices):
        ONLINE = "online", "在线"
        OFFLINE = "offline", "离线"
        FAULT = "fault", "故障"

    machine_id = models.CharField(
        "设备编号", max_length=32, unique=True, db_index=True,
        help_text="格式：MACHINE001（系统自动生成）",
    )
    subdomain = models.CharField(
        "子域名前缀", max_length=64, unique=True,
        help_text="自动生成，例如 machine001，最终访问 machine001.gush.cdgushai.com",
    )
    name = models.CharField("设备名称", max_length=128)
    address = models.CharField("安装地址", max_length=255, blank=True, default="")
    longitude = models.DecimalField("经度", max_digits=10, decimal_places=6, null=True, blank=True)
    latitude = models.DecimalField("纬度", max_digits=10, decimal_places=6, null=True, blank=True)

    # 通信凭证
    activation_code = models.CharField(
        "激活码", max_length=64,
        help_text="设备首次接入时使用，激活后失效",
    )
    comm_secret = models.CharField(
        "通信密钥", max_length=128,
        help_text="HMAC 签名密钥，用于设备↔服务器之间的消息验签",
    )

    # 运行状态
    status = models.CharField("状态", max_length=16, choices=Status.choices, default=Status.OFFLINE)
    last_heartbeat_at = models.DateTimeField("最后心跳时间", null=True, blank=True)
    signal_strength = models.IntegerField("信号强度(%)", default=0)
    network_type = models.CharField("网络类型", max_length=16, blank=True, default="")  # 4G/5G/WIFI
    runtime_seconds = models.BigIntegerField("累计运行秒数", default=0)
    firmware_version = models.CharField("固件版本", max_length=32, blank=True, default="")

    # 网络方案（Phase 5.2）
    class NetworkPlan(models.TextChoices):
        WIFI = "wifi", "WiFi"
        CELLULAR_4G = "4g", "4G"

    network_plan = models.CharField(
        "网络制式", max_length=8, choices=NetworkPlan.choices,
        blank=True, default="",
        help_text="wifi / 4g",
    )

    # WiFi 凭据
    wifi_ssid = models.CharField("Wi-Fi名称", max_length=64, blank=True, default="")
    wifi_password = models.CharField("Wi-Fi密码", max_length=128, blank=True, default="")
    wifi_login_ip = models.CharField("登陆IP", max_length=64, blank=True, default="")
    wifi_login_username = models.CharField("Wi-Fi设备登陆用户名", max_length=64, blank=True, default="")
    wifi_login_password = models.CharField("Wi-Fi设备登陆密码", max_length=128, blank=True, default="")

    carrier = models.CharField(
        "运营商", max_length=16, blank=True, default="",
        help_text="移动/联通/电信（4G 时填写）",
    )
    iccid = models.CharField(
        "SIM卡号/SN", max_length=32, blank=True, default="",
        help_text="4G SIM 卡号或设备序列号 SN",
    )
    data_limit_mb = models.IntegerField(
        "月流量上限(MB)", null=True, blank=True,
        help_text="例如 10240 = 10GB",
    )
    data_used_mb = models.IntegerField(
        "当月已用流量(MB)", null=True, blank=True, default=0,
        help_text="本月累计流量",
    )
    plan_fee = models.DecimalField(
        "套餐月费(元)", max_digits=8, decimal_places=2,
        null=True, blank=True,
    )
    plan_start_date = models.DateField(
        "套餐生效日", null=True, blank=True,
    )
    renewal_date = models.DateField(
        "续费日期", null=True, blank=True,
        help_text="下次续费提醒",
    )

    # 业务绑定
    # 出货逻辑
    dispense_strategy = models.CharField(
        "出货逻辑", max_length=16,
        choices=DispenseStrategy.choices,
        default=DispenseStrategy.SEQUENTIAL,
    )

    bound_project = models.ForeignKey(
        "projects.Project",
        on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="bound_machines",
        verbose_name="当前绑定项目",
    )

    created_at = models.DateTimeField("创建时间", auto_now_add=True)
    updated_at = models.DateTimeField("更新时间", auto_now=True)

    class Meta:
        verbose_name = "派样机"
        verbose_name_plural = "派样机"
        db_table = "gush_machine"
        ordering = ["-created_at"]

    def __str__(self) -> str:
        return f"{self.machine_id} - {self.name}"

    @property
    def public_url(self) -> str:
        return f"https://{self.subdomain}.{settings.ROOT_DOMAIN}"

    @property
    def is_offline(self) -> bool:
        """根据最后心跳判定是否离线"""
        if not self.last_heartbeat_at:
            return True
        delta = (timezone.now() - self.last_heartbeat_at).total_seconds()
        return delta > settings.HEARTBEAT_TIMEOUT_SECONDS

    # ------- 工厂方法 -------
    @classmethod
    @transaction.atomic
    def create_with_channels(cls, name: str, address: str = "", **extra) -> "Machine":
        """
        新建设备 + 同时初始化全部 60 个货道。
        machine_id / subdomain / activation_code / comm_secret 全部自动生成。
        """
        # 生成自增编号
        last = cls.objects.select_for_update().order_by("-id").first()
        next_seq = (last.id + 1) if last else 1
        machine_id = f"MACHINE{next_seq:03d}"
        subdomain = machine_id.lower()

        machine = cls.objects.create(
            machine_id=machine_id,
            subdomain=subdomain,
            name=name,
            address=address,
            activation_code=secrets.token_urlsafe(16),
            comm_secret=secrets.token_urlsafe(32),
            **extra,
        )

        # 初始化 60 个货道（A0–F9）
        channels = []
        for row in settings.MACHINE_CHANNEL_ROWS:
            for col in settings.MACHINE_CHANNEL_COLS:
                channels.append(Channel(
                    machine=machine,
                    row=row,
                    col=col,
                    channel_code=f"{row}{col}",
                    layer=settings.MACHINE_CHANNEL_ROWS.index(row) + 1,
                    capacity=settings.MACHINE_CHANNEL_CAPACITY,
                    current_stock=0,
                ))
        Channel.objects.bulk_create(channels)
        return machine


class Channel(models.Model):
    """
    货道（一台机器 60 个，对应 STM32 协议 A0-F9）
    显示规则：6 层 × 10 列，每个货道容量 5
    """

    class Status(models.TextChoices):
        NORMAL = "normal", "正常"
        LOW = "low", "库存低"
        EMPTY = "empty", "缺货"
        FAULT = "fault", "故障"

    machine = models.ForeignKey(
        Machine, on_delete=models.CASCADE,
        related_name="channels",
        verbose_name="所属设备",
    )
    row = models.CharField("行(A-F)", max_length=1)
    col = models.IntegerField("列(0-9)")
    channel_code = models.CharField(
        "货道编码", max_length=4,
        help_text="A0–F9，与 STM32 协议一致",
    )
    layer = models.IntegerField("层号(1-6)", help_text="UI 展示用：A行=1层 ... F行=6层")

    capacity = models.IntegerField("容量", default=5)
    current_stock = models.IntegerField("当前库存", default=0)
    status = models.CharField("状态", max_length=16, choices=Status.choices, default=Status.EMPTY)

    product = models.ForeignKey(
        "products.Product",
        on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="channels",
        verbose_name="绑定商品",
    )

    last_dispense_at = models.DateTimeField("最后出货时间", null=True, blank=True)
    fault_message = models.CharField("故障信息", max_length=255, blank=True, default="")
    updated_at = models.DateTimeField("更新时间", auto_now=True)

    class Meta:
        verbose_name = "货道"
        verbose_name_plural = "货道"
        db_table = "gush_channel"
        unique_together = [("machine", "channel_code")]
        ordering = ["machine", "row", "col"]
        indexes = [
            models.Index(fields=["machine", "status"]),
        ]

    def __str__(self) -> str:
        return f"{self.machine.machine_id}/{self.channel_code}"

    def recompute_status(self, save: bool = True):
        """根据库存自动刷新状态（fault 状态不会自动覆盖）"""
        if self.status == self.Status.FAULT:
            return
        if self.current_stock <= 0:
            self.status = self.Status.EMPTY
        elif self.current_stock <= max(1, self.capacity // 3):
            self.status = self.Status.LOW
        else:
            self.status = self.Status.NORMAL
        if save:
            self.save(update_fields=["status", "updated_at"])


class HeartbeatLog(models.Model):
    """心跳上报历史（保留最近 N 天即可）"""
    machine = models.ForeignKey(
        Machine, on_delete=models.CASCADE,
        related_name="heartbeats",
    )
    received_at = models.DateTimeField("接收时间", auto_now_add=True, db_index=True)
    signal_strength = models.IntegerField("信号强度", default=0)
    network_type = models.CharField("网络类型", max_length=16, blank=True, default="")
    payload = models.JSONField("原始上报数据", default=dict, blank=True)

    class Meta:
        verbose_name = "心跳记录"
        verbose_name_plural = "心跳记录"
        db_table = "gush_heartbeat_log"
        ordering = ["-received_at"]


class DispenseLog(models.Model):
    """出货记录"""

    class Result(models.TextChoices):
        SUCCESS = "success", "成功"
        EMPTY = "empty", "货道空/机械故障"
        BUSY = "busy", "设备忙"
        TIMEOUT = "timeout", "超时"
        ERROR = "error", "未知错误"

    machine = models.ForeignKey(Machine, on_delete=models.CASCADE, related_name="dispenses")
    channel = models.ForeignKey(Channel, on_delete=models.SET_NULL, null=True, related_name="dispenses")
    channel_code = models.CharField("货道编码快照", max_length=4)
    redeem_code = models.ForeignKey(
        "projects.RedeemCode",
        on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="dispense_logs",
    )
    result = models.CharField("结果", max_length=16, choices=Result.choices)
    detail = models.CharField("详情", max_length=255, blank=True, default="")
    created_at = models.DateTimeField("创建时间", auto_now_add=True, db_index=True)

    class Meta:
        verbose_name = "出货记录"
        verbose_name_plural = "出货记录"
        db_table = "gush_dispense_log"
        ordering = ["-created_at"]


class FaultLog(models.Model):
    """设备故障告警"""

    class Severity(models.TextChoices):
        INFO = "info", "提示"
        WARN = "warn", "警告"
        CRITICAL = "critical", "严重"

    machine = models.ForeignKey(Machine, on_delete=models.CASCADE, related_name="faults")
    channel = models.ForeignKey(Channel, on_delete=models.SET_NULL, null=True, blank=True)
    severity = models.CharField("级别", max_length=16, choices=Severity.choices, default=Severity.WARN)
    code = models.CharField("故障代码", max_length=32, blank=True, default="")
    message = models.CharField("故障描述", max_length=255)
    resolved = models.BooleanField("已处理", default=False)
    resolved_at = models.DateTimeField("处理时间", null=True, blank=True)
    created_at = models.DateTimeField("创建时间", auto_now_add=True, db_index=True)

    class Meta:
        verbose_name = "故障记录"
        verbose_name_plural = "故障记录"
        db_table = "gush_fault_log"
        ordering = ["-created_at"]
