"""
账号模型 - 自定义 User
角色：超级管理员 / 运营管理员 / 操作员
"""
from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    class Role(models.TextChoices):
        SUPERADMIN = "superadmin", "超级管理员"
        ADMIN = "admin", "运营管理员"
        OPERATOR = "operator", "操作员"

    role = models.CharField(
        "角色",
        max_length=20,
        choices=Role.choices,
        default=Role.OPERATOR,
    )
    phone = models.CharField("手机号", max_length=20, blank=True, default="")
    avatar = models.URLField("头像URL", blank=True, default="")
    last_login_ip = models.GenericIPAddressField("最后登录IP", null=True, blank=True)

    class Meta:
        verbose_name = "用户"
        verbose_name_plural = "用户"
        db_table = "gush_user"

    def __str__(self) -> str:
        return f"{self.username} ({self.get_role_display()})"

    @property
    def is_admin_role(self) -> bool:
        """是否拥有管理后台访问权限"""
        return self.role in (self.Role.SUPERADMIN, self.Role.ADMIN)
