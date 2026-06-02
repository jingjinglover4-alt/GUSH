from django.contrib import admin

from .models import (
    DevicePageOverride, Experiment, ExperimentVariant,
    H5Page, LedPage, PageTheme, PageVersion, PageVisitLog,
)


@admin.register(PageTheme)
class PageThemeAdmin(admin.ModelAdmin):
    list_display = ("id", "project", "brand_color", "updated_at")
    search_fields = ("project__name",)


@admin.register(H5Page)
class H5PageAdmin(admin.ModelAdmin):
    list_display = ("id", "project", "header_title", "status", "current_version", "updated_at")
    list_filter = ("status",)
    search_fields = ("project__name", "header_title")


@admin.register(LedPage)
class LedPageAdmin(admin.ModelAdmin):
    list_display = ("id", "project", "status", "current_version", "updated_at")
    list_filter = ("status",)
    search_fields = ("project__name",)


@admin.register(DevicePageOverride)
class DevicePageOverrideAdmin(admin.ModelAdmin):
    list_display = ("id", "machine", "enabled", "updated_at")
    list_filter = ("enabled",)
    search_fields = ("machine__machine_id", "machine__name")


@admin.register(PageVersion)
class PageVersionAdmin(admin.ModelAdmin):
    list_display = ("id", "page_type", "page_id", "project", "version", "published_at", "published_by")
    list_filter = ("page_type",)
    search_fields = ("project__name",)
    readonly_fields = ("snapshot", "published_at")


@admin.register(PageVisitLog)
class PageVisitLogAdmin(admin.ModelAdmin):
    list_display = ("id", "page_type", "project", "machine", "device_fp",
                    "experiment", "variant_key", "ip", "visited_at")
    list_filter = ("page_type", "variant_key")
    search_fields = ("project__name", "machine__machine_id", "device_fp", "ip")
    readonly_fields = ("visited_at",)
    date_hierarchy = "visited_at"


class ExperimentVariantInline(admin.TabularInline):
    model = ExperimentVariant
    extra = 0


@admin.register(Experiment)
class ExperimentAdmin(admin.ModelAdmin):
    list_display = ("id", "project", "name", "status", "traffic_split_b",
                    "winner", "started_at", "stopped_at")
    list_filter = ("status", "winner")
    search_fields = ("project__name", "name")
    inlines = [ExperimentVariantInline]
