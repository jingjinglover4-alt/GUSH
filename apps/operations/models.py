from django.conf import settings
from django.db import models


class OperationLog(models.Model):
    """后台关键操作审计日志（由中间件自动写入）"""

    class Method(models.TextChoices):
        POST = "POST", "POST"
        PUT = "PUT", "PUT"
        PATCH = "PATCH", "PATCH"
        DELETE = "DELETE", "DELETE"

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name="operation_logs",
        verbose_name="操作人",
    )
    username = models.CharField("用户名快照", max_length=150, blank=True, default="")
    method = models.CharField("HTTP方法", max_length=8, choices=Method.choices)
    path = models.CharField("请求路径", max_length=255)
    status_code = models.PositiveSmallIntegerField("响应码", default=0)
    ip = models.CharField("IP", max_length=64, blank=True, default="")
    user_agent = models.CharField("UA", max_length=255, blank=True, default="")
    summary = models.CharField("摘要", max_length=255, blank=True, default="")
    created_at = models.DateTimeField("时间", auto_now_add=True)

    class Meta:
        ordering = ("-created_at",)
        indexes = [
            models.Index(fields=["created_at"]),
            models.Index(fields=["user"]),
        ]
        verbose_name = "操作日志"
        verbose_name_plural = "操作日志"

    def __str__(self):
        return f"[{self.created_at:%Y-%m-%d %H:%M:%S}] {self.username} {self.method} {self.path}"
