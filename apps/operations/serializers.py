from rest_framework import serializers

from .models import OperationLog


class OperationLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = OperationLog
        fields = (
            "id", "username", "method", "path", "status_code",
            "ip", "user_agent", "summary", "created_at",
        )
        read_only_fields = fields
