from django.contrib import admin

from .models import Channel, DispenseLog, FaultLog, HeartbeatLog, Machine


class ChannelInline(admin.TabularInline):
    model = Channel
    extra = 0
    fields = ("channel_code", "layer", "capacity", "current_stock", "status", "product")
    readonly_fields = ("channel_code", "layer")
    can_delete = False
    show_change_link = True


@admin.register(Machine)
class MachineAdmin(admin.ModelAdmin):
    list_display = ("machine_id", "name", "status", "subdomain", "last_heartbeat_at", "bound_project")
    list_filter = ("status",)
    search_fields = ("machine_id", "name", "address")
    readonly_fields = ("machine_id", "subdomain", "activation_code", "comm_secret",
                       "last_heartbeat_at", "runtime_seconds", "created_at", "updated_at")
    inlines = [ChannelInline]


@admin.register(Channel)
class ChannelAdmin(admin.ModelAdmin):
    list_display = ("machine", "channel_code", "layer", "current_stock", "capacity", "status", "product")
    list_filter = ("status", "layer")
    search_fields = ("machine__machine_id", "channel_code")


@admin.register(HeartbeatLog)
class HeartbeatLogAdmin(admin.ModelAdmin):
    list_display = ("machine", "received_at", "signal_strength", "network_type")
    list_filter = ("network_type",)
    search_fields = ("machine__machine_id",)
    readonly_fields = ("machine", "received_at", "signal_strength", "network_type", "payload")


@admin.register(DispenseLog)
class DispenseLogAdmin(admin.ModelAdmin):
    list_display = ("machine", "channel_code", "result", "redeem_code", "created_at")
    list_filter = ("result",)
    search_fields = ("machine__machine_id", "channel_code")


@admin.register(FaultLog)
class FaultLogAdmin(admin.ModelAdmin):
    list_display = ("machine", "severity", "code", "message", "resolved", "created_at")
    list_filter = ("severity", "resolved")
    search_fields = ("machine__machine_id", "code", "message")
