from django.contrib import admin

from .models import Project, ProjectMachine, RedeemCode


@admin.register(Project)
class ProjectAdmin(admin.ModelAdmin):
    list_display = ("name", "status", "starts_at", "ends_at", "created_by")
    list_filter = ("status",)
    search_fields = ("name",)


@admin.register(ProjectMachine)
class ProjectMachineAdmin(admin.ModelAdmin):
    list_display = ("project", "machine", "bound_at")


@admin.register(RedeemCode)
class RedeemCodeAdmin(admin.ModelAdmin):
    list_display = ("code", "project", "status", "user_openid", "expires_at", "used_at")
    list_filter = ("status", "project")
    search_fields = ("code", "user_openid")
