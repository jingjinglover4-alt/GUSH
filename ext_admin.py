from django.contrib import admin

from .models import Project, ProjectMachine, RedeemCode


@admin.register(Project)
class ProjectAdmin(admin.ModelAdmin):
    list_display = ("name", "status", "max_per_user", "daily_per_user_per_machine",
                    "daily_window_start_hour", "starts_at", "ends_at", "created_by")
    list_filter = ("status", "daily_per_user_per_machine")
    search_fields = ("name",)

    fieldsets = (
        ("业务规则", {
            "fields": ("max_per_user", "daily_per_user_per_machine", "daily_window_start_hour"),
        }),
        ("基础信息", {
            "fields": ("name", "description", "status", "starts_at", "ends_at"),
        }),
        ("兑换码规则", {
            "fields": ("code_length", "code_validity_days"),
        }),
        ("媒体与凭证", {
            "fields": ("poster_image", "wechat_qr", "rules_text", "client_token", "created_by"),
        }),
    )


@admin.register(ProjectMachine)
class ProjectMachineAdmin(admin.ModelAdmin):
    list_display = ("project", "machine", "bound_at")


@admin.register(RedeemCode)
class RedeemCodeAdmin(admin.ModelAdmin):
    list_display = ("code", "project", "status", "user_openid", "expires_at", "used_at")
    list_filter = ("status", "project")
    search_fields = ("code", "user_openid")
