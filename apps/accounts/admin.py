from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

from .models import User


@admin.register(User)
class UserAdmin(BaseUserAdmin):
    list_display = ("username", "email", "role", "phone", "is_active", "last_login")
    list_filter = ("role", "is_active", "is_staff")
    search_fields = ("username", "email", "phone")
    fieldsets = BaseUserAdmin.fieldsets + (
        ("扩展信息", {"fields": ("role", "phone", "avatar", "last_login_ip")}),
    )
    add_fieldsets = BaseUserAdmin.add_fieldsets + (
        ("扩展信息", {"fields": ("role", "phone")}),
    )
