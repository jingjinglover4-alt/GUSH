"""页面装修 - 序列化器"""
from rest_framework import serializers

from .models import (
    DevicePageOverride, Experiment, ExperimentVariant,
    H5Page, LedPage, PageTheme, PageVersion,
)


class PageThemeSerializer(serializers.ModelSerializer):
    logo_url = serializers.SerializerMethodField()
    favicon_url = serializers.SerializerMethodField()
    background_image_url = serializers.SerializerMethodField()

    class Meta:
        model = PageTheme
        fields = (
            "id", "project",
            "brand_color", "accent_color", "text_color",
            "logo", "logo_url",
            "favicon", "favicon_url",
            "background_type", "background_value",
            "background_image", "background_image_url",
            "font_family", "shared_assets",
            "created_at", "updated_at",
        )
        read_only_fields = ("project", "created_at", "updated_at")
        extra_kwargs = {
            "logo": {"write_only": True, "required": False},
            "favicon": {"write_only": True, "required": False},
            "background_image": {"write_only": True, "required": False},
        }

    def _abs(self, field):
        request = self.context.get("request")
        if field and request:
            return request.build_absolute_uri(field.url)
        return field.url if field else None

    def get_logo_url(self, obj):
        return self._abs(obj.logo)

    def get_favicon_url(self, obj):
        return self._abs(obj.favicon)

    def get_background_image_url(self, obj):
        return self._abs(obj.background_image)


class H5PageSerializer(serializers.ModelSerializer):
    class Meta:
        model = H5Page
        fields = (
            "id", "project",
            "header_title", "header_subtitle",
            "blocks", "form_fields", "privacy",
            "submit_button", "rate_limit", "success_view",
            "page1_background", "page2_background", "page3_background",
            "page1_button_font_size", "page1_button_padding",
            "page1_button_font_color", "page1_button_bg_color",
            "header_font_color", "header_font_size",
            "header_position", "button_position",
            "status", "published_at", "current_version",
            "created_at", "updated_at",
        )
        read_only_fields = (
            "project", "status", "published_at", "current_version",
            "created_at", "updated_at",
        )


class PageVersionSerializer(serializers.ModelSerializer):
    published_by_name = serializers.CharField(source="published_by.username", read_only=True)

    class Meta:
        model = PageVersion
        fields = (
            "id", "page_type", "page_id", "project", "version",
            "snapshot", "note", "published_at",
            "published_by", "published_by_name",
        )
        read_only_fields = fields


class PublishH5Serializer(serializers.Serializer):
    """发布 H5 页面：可选附带发布说明"""
    note = serializers.CharField(max_length=255, required=False, allow_blank=True, default="")


class LedPageSerializer(serializers.ModelSerializer):
    qr_image_url = serializers.SerializerMethodField()

    class Meta:
        model = LedPage
        fields = (
            "id", "project",
            "header_title", "header_subtitle",
            "ads",
            "qr_image", "qr_image_url", "qr",
            "input_config", "footer_tip",
            "page1_blocks", "page2_blocks",
            "page1_background", "page2_background",
            "status", "published_at", "current_version",
            "created_at", "updated_at",
        )
        read_only_fields = (
            "project", "status", "published_at", "current_version",
            "created_at", "updated_at",
        )
        extra_kwargs = {
            "qr_image": {"write_only": True, "required": False},
        }

    def get_qr_image_url(self, obj):
        request = self.context.get("request")
        if obj.qr_image and request:
            return request.build_absolute_uri(obj.qr_image.url)
        return obj.qr_image.url if obj.qr_image else None


class PublishLedSerializer(serializers.Serializer):
    note = serializers.CharField(max_length=255, required=False, allow_blank=True, default="")


class DevicePageOverrideSerializer(serializers.ModelSerializer):
    led_qr_image_url = serializers.SerializerMethodField()
    machine_id = serializers.CharField(source="machine.machine_id", read_only=True)
    active_project_name = serializers.CharField(source="active_project.name", read_only=True, default="")

    class Meta:
        model = DevicePageOverride
        fields = (
            "id", "machine", "machine_id",
            "theme_override", "h5_override", "led_override",
            "led_qr_image", "led_qr_image_url",
            "active_project", "active_project_name",
            "enabled", "note",
            "created_at", "updated_at",
        )
        read_only_fields = ("machine", "machine_id", "active_project_name", "created_at", "updated_at")
        extra_kwargs = {
            "led_qr_image": {"write_only": True, "required": False},
        }

    def get_led_qr_image_url(self, obj):
        request = self.context.get("request")
        if obj.led_qr_image and request:
            return request.build_absolute_uri(obj.led_qr_image.url)
        return obj.led_qr_image.url if obj.led_qr_image else None


# ===== Phase 2.3 A/B 实验 =====

class ExperimentVariantSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExperimentVariant
        fields = ("id", "experiment", "key", "name", "note", "traffic_share",
                  "h5_snapshot", "created_at", "updated_at")
        read_only_fields = ("experiment", "created_at", "updated_at")


class ExperimentSerializer(serializers.ModelSerializer):
    variants = ExperimentVariantSerializer(many=True, read_only=True)

    class Meta:
        model = Experiment
        fields = (
            "id", "project", "name", "hypothesis",
            "status", "traffic_split_b",
            "started_at", "stopped_at", "winner", "conclusion_note",
            "variants",
            "created_at", "updated_at",
        )
        read_only_fields = (
            "project", "status", "started_at", "stopped_at",
            "winner", "conclusion_note",
            "created_at", "updated_at",
        )
