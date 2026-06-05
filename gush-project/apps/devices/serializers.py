"""
设备序列化器
- 列表 / 详情 / 创建分开 → 避免一个大 serializer 既臃肿又泄露字段
- Channel / DispenseLog / FaultLog 单独
"""
from django.conf import settings
from rest_framework import serializers

from .models import Channel, DispenseLog, FaultLog, HeartbeatLog, Machine


class ChannelSerializer(serializers.ModelSerializer):
    product_name = serializers.CharField(source="product.name", read_only=True, default="")

    class Meta:
        model = Channel
        fields = (
            "id", "channel_code", "row", "col", "layer",
            "capacity", "current_stock", "status",
            "product", "product_name",
            "last_dispense_at", "fault_message", "updated_at",
        )
        read_only_fields = ("channel_code", "row", "col", "layer", "capacity", "updated_at")


class MachineListSerializer(serializers.ModelSerializer):
    """列表用，字段少而轻"""
    public_url = serializers.CharField(read_only=True)
    bound_project_name = serializers.CharField(source="bound_project.name", read_only=True, default="")
    online_channels = serializers.SerializerMethodField()
    total_channels = serializers.SerializerMethodField()

    class Meta:
        model = Machine
        fields = (
            "id", "machine_id", "name", "subdomain", "address",
            "status", "signal_strength", "network_type",
            "last_heartbeat_at", "firmware_version",
            "bound_project", "bound_project_name",
            "public_url",
            "online_channels", "total_channels",
            # Phase 5.2 网络方案摘要
            "network_plan", "carrier",
            "dispense_strategy",
            "created_at",
        )

    def get_total_channels(self, obj):
        # 走 prefetch / annotation 时优先用
        return getattr(obj, "_total_channels", obj.channels.count())

    def get_online_channels(self, obj):
        return getattr(obj, "_online_channels", obj.channels.exclude(status=Channel.Status.FAULT).count())


class MachineDetailSerializer(serializers.ModelSerializer):
    public_url = serializers.CharField(read_only=True)
    bound_project_name = serializers.CharField(source="bound_project.name", read_only=True, default="")
    channels = ChannelSerializer(many=True, read_only=True)

    class Meta:
        model = Machine
        fields = (
            "id", "machine_id", "name", "subdomain", "address",
            "longitude", "latitude",
            "activation_code", "comm_secret",
            "status", "signal_strength", "network_type",
            "last_heartbeat_at", "runtime_seconds", "firmware_version",
            "bound_project", "bound_project_name",
            "public_url",
            "channels",
            # Phase 5.2 网络方案
            "network_plan",
            # Wi-Fi 凭据
            "wifi_ssid", "wifi_password", "wifi_login_ip",
            "wifi_login_username", "wifi_login_password",
            # 4G 相关
            "carrier", "iccid",
            "data_limit_mb", "data_used_mb", "plan_fee",
            "plan_start_date", "renewal_date",
            "dispense_strategy",
            "created_at", "updated_at",
        )
        read_only_fields = (
            "machine_id",
            "activation_code", "comm_secret",
            "status", "last_heartbeat_at", "runtime_seconds",
            "signal_strength", "network_type", "firmware_version",
            "data_used_mb",
            "created_at", "updated_at",
        )

    def validate_subdomain(self, value):
        import re
        from .models import Machine
        v = (value or "").strip().lower()
        if not v:
            raise serializers.ValidationError("子域名不能为空")
        if not re.match(r"^[a-z0-9][a-z0-9-]{1,30}[a-z0-9]$", v):
            raise serializers.ValidationError("子域名仅允许小写字母数字与连字符，长度 3-32")
        if v in {"www", "admin", "api", "led", "p"}:
            raise serializers.ValidationError("保留子域名，不可使用")
        qs = Machine.objects.filter(subdomain=v)
        if self.instance:
            qs = qs.exclude(pk=self.instance.pk)
        if qs.exists():
            raise serializers.ValidationError("子域名已被其他设备占用")
        return v

    def update(self, instance, validated_data):
        # 如果地址有变化 → 自动解析经纬度
        if "address" in validated_data and validated_data["address"]:
            from libs.geocoding import geocode
            coords = geocode(validated_data["address"])
            if coords:
                validated_data["longitude"], validated_data["latitude"] = coords
        return super().update(instance, validated_data)


class MachineCreateSerializer(serializers.Serializer):
    """新建设备：只接收业务字段，其余由 create_with_channels 自动生成"""
    name = serializers.CharField(max_length=128)
    address = serializers.CharField(max_length=255, allow_blank=True, required=False, default="")
    longitude = serializers.DecimalField(max_digits=10, decimal_places=6, required=False, allow_null=True)
    latitude = serializers.DecimalField(max_digits=10, decimal_places=6, required=False, allow_null=True)
    # Phase 5.1：可选自定义子域名
    subdomain = serializers.CharField(max_length=63, required=False, allow_blank=True, default="")

    def validate_subdomain(self, value):
        import re
        from .models import Machine
        v = (value or "").strip().lower()
        if not v:
            return ""  # 留空 = 自动生成
        if not re.match(r"^[a-z0-9][a-z0-9-]{1,30}[a-z0-9]$", v):
            raise serializers.ValidationError("子域名仅允许小写字母数字与连字符，长度 3-32")
        if v in {"www", "admin", "api", "led", "p"}:
            raise serializers.ValidationError("保留子域名，不可使用")
        if Machine.objects.filter(subdomain=v).exists():
            raise serializers.ValidationError("子域名已被其他设备占用")
        return v

    def create(self, validated_data):
        # 把空 subdomain 剔掉，让工厂方法走默认逻辑
        sub = validated_data.pop("subdomain", "") or ""
        m = Machine.create_with_channels(**validated_data)
        if sub:
            m.subdomain = sub
            m.save(update_fields=["subdomain"])
        return m


class ChannelRestockSerializer(serializers.Serializer):
    """单货道补货"""
    quantity = serializers.IntegerField(min_value=1)
    product_id = serializers.IntegerField(required=False, allow_null=True)

    def validate_quantity(self, value):
        channel: Channel = self.context["channel"]
        if value > channel.capacity:
            raise serializers.ValidationError(f"补货数量超过容量上限 {channel.capacity}")
        return value


class ChannelMarkFaultSerializer(serializers.Serializer):
    """标记/清除故障"""
    fault = serializers.BooleanField()
    message = serializers.CharField(max_length=255, required=False, allow_blank=True, default="")


class DispenseLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = DispenseLog
        fields = ("id", "channel_code", "result", "detail", "redeem_code", "created_at")


class FaultLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = FaultLog
        fields = ("id", "channel", "severity", "code", "message", "resolved", "resolved_at", "created_at")


class HeartbeatLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = HeartbeatLog
        fields = ("id", "received_at", "signal_strength", "network_type")
