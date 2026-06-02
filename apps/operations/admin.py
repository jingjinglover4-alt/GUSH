from django.contrib import admin

from .models import OperationLog


@admin.register(OperationLog)
class OperationLogAdmin(admin.ModelAdmin):
    list_display = ("created_at", "username", "method", "path", "status_code", "ip")
    list_filter = ("method", "status_code")
    search_fields = ("path", "username", "ip")
    readonly_fields = tuple(f.name for f in OperationLog._meta.fields)
