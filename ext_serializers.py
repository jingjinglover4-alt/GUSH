"""项目 / 兑换码 序列化器"""
from rest_framework import serializers

from apps.devices.models import Machine
from apps.products.models import Product

from .models import Project, ProjectMachine, RedeemCode


class ProductBriefSerializer(serializers.ModelSerializer):
    """项目里展示挂载的礼品：精简字段"""
    image_url = serializers.SerializerMethodField()

    class Meta:
        model = Product
        fields = ("id", "sku", "name", "brand", "image_url", "total_stock")

    def get_image_url(self, obj):
        request = self.context.get("request")
        if obj.image and request:
            return request.build_absolute_uri(obj.image.url)
        return None


class MachineBriefSerializer(serializers.ModelSerializer):
    """项目详情里要显示绑定的设备：只用极少字段"""
    class Meta:
        model = Machine
        fields = ("id", "machine_id", "name", "status", "subdomain")


class ProjectListSerializer(serializers.ModelSerializer):
    machine_count = serializers.SerializerMethodField()
    code_total = serializers.SerializerMethodField()
    code_used = serializers.SerializerMethodField()

    class Meta:
        model = Project
        fields = (
            "id", "name", "status",
            "starts_at", "ends_at",
            "code_length", "code_validity_days", "max_per_user", "daily_per_user_per_machine", "daily_window_start_hour",
            "machine_count", "code_total", "code_used",
            "created_at",
        )

    def get_machine_count(self, obj):
        return getattr(obj, "_machine_count", obj.machines.count())

    def get_code_total(self, obj):
        return getattr(obj, "_code_total", obj.redeem_codes.count())

    def get_code_used(self, obj):
        return getattr(obj, "_code_used",
                       obj.redeem_codes.filter(status=RedeemCode.Status.USED).count())


class ProjectDetailSerializer(serializers.ModelSerializer):
    machines = MachineBriefSerializer(many=True, read_only=True)
    products = ProductBriefSerializer(many=True, read_only=True)
    poster_url = serializers.SerializerMethodField()
    wechat_qr_url = serializers.SerializerMethodField()
    client_url = serializers.SerializerMethodField()

    class Meta:
        model = Project
        fields = (
            "id", "name", "description",
            "starts_at", "ends_at",
            "poster_image", "poster_url",
            "wechat_qr", "wechat_qr_url",
            "rules_text",
            "code_length", "code_validity_days", "max_per_user", "daily_per_user_per_machine", "daily_window_start_hour",
            "status",
            "machines",
            "products",
            "client_token",
            "client_url",
            "created_at", "updated_at",
        )
        read_only_fields = ("created_at", "updated_at", "client_token")

    def get_poster_url(self, obj):
        request = self.context.get("request")
        if obj.poster_image and request:
            return request.build_absolute_uri(obj.poster_image.url)
        return None

    def get_wechat_qr_url(self, obj):
        request = self.context.get("request")
        if obj.wechat_qr and request:
            return request.build_absolute_uri(obj.wechat_qr.url)
        return None

    def get_client_url(self, obj):
        request = self.context.get("request")
        if not obj.client_token:
            return None
        if request:
            return request.build_absolute_uri(f"/client/{obj.client_token}/")
        return f"/client/{obj.client_token}/"


class ProjectWriteSerializer(serializers.ModelSerializer):
    """创建 / 修改 用：只接业务字段"""
    class Meta:
        model = Project
        fields = (
            "name", "description",
            "starts_at", "ends_at",
            "poster_image", "wechat_qr", "rules_text",
            "code_length", "code_validity_days", "max_per_user", "daily_per_user_per_machine", "daily_window_start_hour",
            "status",
        )


class BindMachinesSerializer(serializers.Serializer):
    machine_ids = serializers.ListField(child=serializers.IntegerField(), allow_empty=True)


class BindProductsSerializer(serializers.Serializer):
    """项目挂载/解绑礼品清单（全量覆盖）"""
    product_ids = serializers.ListField(child=serializers.IntegerField(), allow_empty=True)


class GenerateCodesSerializer(serializers.Serializer):
    count = serializers.IntegerField(min_value=1, max_value=10000)


class RedeemCodeSerializer(serializers.ModelSerializer):
    status_label = serializers.CharField(source="get_status_display", read_only=True)
    used_machine_id = serializers.CharField(source="used_on_machine.machine_id", read_only=True, default="")

    class Meta:
        model = RedeemCode
        fields = (
            "id", "code", "status", "status_label",
            "user_openid", "user_nickname",
            "expires_at", "used_at",
            "used_on_machine", "used_machine_id", "used_on_channel_code",
            "created_at",
        )


# ---- 公开（C 端）兑换 ----
class PublicRedeemSerializer(serializers.Serializer):
    code = serializers.CharField(max_length=32)
    machine_id = serializers.CharField(max_length=32, required=False, allow_blank=True)
