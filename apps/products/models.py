"""商品档案 + 库存流水"""
from django.conf import settings
from django.db import models


class Product(models.Model):
    sku = models.CharField("SKU编码", max_length=64, unique=True)
    name = models.CharField("商品名称", max_length=128)
    brand = models.CharField("品牌", max_length=64, blank=True, default="")
    image = models.ImageField("商品图片", upload_to="products/", blank=True, null=True)
    description = models.TextField("描述", blank=True, default="")
    low_stock_threshold = models.IntegerField(
        "低库存预警阈值", default=1,
        help_text="单个货道库存低于此值时报警",
    )
    total_stock = models.IntegerField(
        "仓库总库存", default=0,
        help_text="仓库剩余可补货数量。补货到货道时扣减；入库时增加。",
    )
    created_at = models.DateTimeField("创建时间", auto_now_add=True)
    updated_at = models.DateTimeField("更新时间", auto_now=True)

    class Meta:
        verbose_name = "商品"
        verbose_name_plural = "商品"
        db_table = "gush_product"
        ordering = ["-created_at"]

    def __str__(self) -> str:
        return f"{self.sku} - {self.name}"


class StockMovement(models.Model):
    """
    库存流水（不可变账本）

    四类事件：
      - inbound   入库   warehouse += qty                 （仓库手工入库）
      - restock   补货   warehouse -= qty, channel += qty （仓库 → 货道）
      - dispense  派样   channel   -= qty                 （货道 → 出货口）
      - return    回库   channel   -= qty, warehouse += qty（货道 → 仓库）

    `quantity` 一律存正数；流向通过 `kind` 解读。
    一次"补货"或"回库"会产生 **两条** 记录（一条 warehouse 一条 channel），用 `paired_with` 串起来。
    入库 / 派样 只产生一条。
    """

    class Kind(models.TextChoices):
        INBOUND = "inbound", "入库"
        RESTOCK_OUT = "restock_out", "补货出库（仓库扣减）"
        RESTOCK_IN = "restock_in", "补货上机（货道增加）"
        DISPENSE = "dispense", "派样出货"
        RETURN_OUT = "return_out", "回库下机（货道扣减）"
        RETURN_IN = "return_in", "回库归仓（仓库增加）"
        ADJUST = "adjust", "人工调整"

    product = models.ForeignKey(
        Product, on_delete=models.CASCADE,
        related_name="movements", verbose_name="礼品",
    )
    kind = models.CharField("事件类型", max_length=16, choices=Kind.choices, db_index=True)
    quantity = models.IntegerField("数量（绝对值）")

    machine = models.ForeignKey(
        "devices.Machine", on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="stock_movements",
        verbose_name="涉及设备",
    )
    channel = models.ForeignKey(
        "devices.Channel", on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="stock_movements",
        verbose_name="涉及货道",
    )
    channel_code = models.CharField("货道编码快照", max_length=4, blank=True, default="")

    redeem_code = models.ForeignKey(
        "projects.RedeemCode", on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="stock_movements",
        verbose_name="关联兑换码",
    )
    dispense_log = models.ForeignKey(
        "devices.DispenseLog", on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="stock_movements",
        verbose_name="关联出货日志",
    )

    warehouse_after = models.IntegerField("操作后仓库库存", null=True, blank=True)
    channel_stock_after = models.IntegerField("操作后货道库存", null=True, blank=True)

    operator = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="stock_movements",
        verbose_name="操作人",
    )
    source = models.CharField(
        "来源", max_length=32, blank=True, default="",
        help_text="manual / restock / dispense / motor_done / redeem / return / system",
    )
    note = models.CharField("备注", max_length=255, blank=True, default="")

    paired_with = models.ForeignKey(
        "self", on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="pair",
        verbose_name="配对记录",
        help_text="补货/回库时另一半的流水 id",
    )

    created_at = models.DateTimeField("时间", auto_now_add=True, db_index=True)

    class Meta:
        verbose_name = "库存流水"
        verbose_name_plural = "库存流水"
        db_table = "gush_stock_movement"
        ordering = ["-created_at", "-id"]
        indexes = [
            models.Index(fields=["product", "-created_at"]),
            models.Index(fields=["machine", "-created_at"]),
            models.Index(fields=["kind", "-created_at"]),
        ]

    def __str__(self) -> str:
        return f"[{self.get_kind_display()}] {self.product_id} ×{self.quantity}"
