from rest_framework import serializers

from apps.devices.models import DispenseLog

from .models import Product, StockMovement


class ProductSerializer(serializers.ModelSerializer):
    """商品列表/详情通用（含库存四件套聚合）"""

    image_url = serializers.SerializerMethodField()
    channel_count = serializers.SerializerMethodField()

    # 库存四件套
    on_machine_stock = serializers.SerializerMethodField()
    dispensed_count = serializers.SerializerMethodField()
    remaining_stock = serializers.SerializerMethodField()

    # 在机设备分布：[{machine_id, name, status, channel_codes:[...], stock_sum}]
    machines = serializers.SerializerMethodField()

    class Meta:
        model = Product
        fields = (
            "id", "sku", "name", "brand",
            "image", "image_url",
            "description", "low_stock_threshold",
            "total_stock",          # 仓库总库存（可写）
            "on_machine_stock",     # 已分布到所有货道的库存（只读）
            "dispensed_count",      # 累计已派（只读）
            "remaining_stock",      # 总+在机（只读）
            "channel_count",
            "machines",             # 在机设备分布
            "created_at", "updated_at",
        )
        read_only_fields = ("created_at", "updated_at")

    def get_machines(self, obj):
        """按机器聚合：同一台机器多个货道合并成一行"""
        groups = {}  # machine_id → {…, channel_codes:[]}
        for ch in obj.channels.all():  # 依赖 prefetch_related('channels__machine')
            m = ch.machine
            g = groups.get(m.machine_id)
            if g is None:
                g = {
                    "id": m.id,
                    "machine_id": m.machine_id,
                    "name": m.name,
                    "status": m.status,
                    "channel_codes": [],
                    "stock_sum": 0,
                }
                groups[m.machine_id] = g
            g["channel_codes"].append(ch.channel_code)
            g["stock_sum"] += ch.current_stock
        # 排序：编号字典序
        return sorted(groups.values(), key=lambda x: x["machine_id"])

    def get_image_url(self, obj):
        request = self.context.get("request")
        if obj.image and request:
            return request.build_absolute_uri(obj.image.url)
        return None

    def get_channel_count(self, obj):
        return getattr(obj, "_channel_count", obj.channels.count())

    def get_on_machine_stock(self, obj):
        v = getattr(obj, "_on_machine_stock", None)
        if v is not None:
            return v
        return sum(c.current_stock for c in obj.channels.all())

    def get_dispensed_count(self, obj):
        v = getattr(obj, "_dispensed_count", None)
        if v is not None:
            return v
        return DispenseLog.objects.filter(
            channel__product=obj,
            result=DispenseLog.Result.SUCCESS,
        ).count()

    def get_remaining_stock(self, obj):
        return (obj.total_stock or 0) + self.get_on_machine_stock(obj)


class ProductDetailSerializer(ProductSerializer):
    """商品详情：再附带货道分布 + 关联项目"""

    channels = serializers.SerializerMethodField()
    projects = serializers.SerializerMethodField()

    class Meta(ProductSerializer.Meta):
        fields = ProductSerializer.Meta.fields + ("channels", "projects")

    def get_channels(self, obj):
        rows = (
            obj.channels.select_related("machine")
            .order_by("machine__machine_id", "row", "col")
        )
        return [
            {
                "id": c.id,
                "machine_id": c.machine.machine_id,
                "machine_name": c.machine.name,
                "channel_code": c.channel_code,
                "current_stock": c.current_stock,
                "capacity": c.capacity,
                "status": c.status,
            }
            for c in rows
        ]

    def get_projects(self, obj):
        return [
            {"id": p.id, "name": p.name, "status": p.status}
            for p in obj.projects.all()
        ]


class StockInSerializer(serializers.Serializer):
    """入库（仓库新增）"""
    quantity = serializers.IntegerField(min_value=1, max_value=100000)
    note = serializers.CharField(max_length=255, required=False, allow_blank=True)


class StockMovementSerializer(serializers.ModelSerializer):
    """库存流水（不可变账本）"""
    product_sku = serializers.CharField(source="product.sku", read_only=True)
    product_name = serializers.CharField(source="product.name", read_only=True)
    machine_code = serializers.CharField(source="machine.machine_id", read_only=True, default="")
    machine_name = serializers.CharField(source="machine.name", read_only=True, default="")
    operator_name = serializers.CharField(source="operator.username", read_only=True, default="")
    redeem_code_str = serializers.CharField(source="redeem_code.code", read_only=True, default="")
    kind_display = serializers.CharField(source="get_kind_display", read_only=True)
    # 资金式正负号：仓库视角 / 货道视角
    warehouse_delta = serializers.SerializerMethodField()
    channel_delta = serializers.SerializerMethodField()

    class Meta:
        model = StockMovement
        fields = (
            "id",
            "kind", "kind_display",
            "quantity",
            "warehouse_delta", "channel_delta",
            "product", "product_sku", "product_name",
            "machine", "machine_code", "machine_name",
            "channel", "channel_code",
            "redeem_code", "redeem_code_str",
            "dispense_log",
            "warehouse_after", "channel_stock_after",
            "operator", "operator_name",
            "source", "note",
            "paired_with",
            "created_at",
        )

    def get_warehouse_delta(self, obj):
        K = StockMovement.Kind
        if obj.kind in (K.INBOUND, K.RETURN_IN):
            return obj.quantity
        if obj.kind == K.RESTOCK_OUT:
            return -obj.quantity
        return 0

    def get_channel_delta(self, obj):
        K = StockMovement.Kind
        if obj.kind == K.RESTOCK_IN:
            return obj.quantity
        if obj.kind in (K.DISPENSE, K.RETURN_OUT):
            return -obj.quantity
        return 0
