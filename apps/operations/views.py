from rest_framework import mixins, viewsets
from rest_framework.permissions import IsAuthenticated

from .models import OperationLog
from .serializers import OperationLogSerializer


class OperationLogViewSet(mixins.ListModelMixin, viewsets.GenericViewSet):
    """操作日志只读接口（仅管理员可见）"""
    permission_classes = (IsAuthenticated,)
    serializer_class = OperationLogSerializer
    queryset = OperationLog.objects.all().select_related("user")
    filterset_fields = ("method", "status_code", "username")
    search_fields = ("path", "username", "ip")
    ordering_fields = ("created_at", "id")

    def get_queryset(self):
        qs = super().get_queryset()
        method = self.request.query_params.get("method")
        if method:
            qs = qs.filter(method=method.upper())
        username = self.request.query_params.get("username")
        if username:
            qs = qs.filter(username__icontains=username)
        return qs
