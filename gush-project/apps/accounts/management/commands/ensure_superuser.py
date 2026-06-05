"""
首次启动时自动创建超级管理员
读取环境变量：
  DJANGO_SUPERUSER_USERNAME
  DJANGO_SUPERUSER_PASSWORD
  DJANGO_SUPERUSER_EMAIL
若用户已存在则跳过；不存在则创建。
"""
import os

from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand

User = get_user_model()


class Command(BaseCommand):
    help = "确保超级管理员账号存在（幂等）"

    def handle(self, *args, **options):
        username = os.environ.get("DJANGO_SUPERUSER_USERNAME", "admin")
        password = os.environ.get("DJANGO_SUPERUSER_PASSWORD", "admin123456")
        email = os.environ.get("DJANGO_SUPERUSER_EMAIL", "admin@example.com")

        if User.objects.filter(username=username).exists():
            self.stdout.write(self.style.WARNING(
                f"超管 {username} 已存在，跳过创建"
            ))
            return

        user = User.objects.create_superuser(
            username=username,
            email=email,
            password=password,
        )
        user.role = User.Role.SUPERADMIN
        user.save(update_fields=["role"])
        self.stdout.write(self.style.SUCCESS(
            f"已创建超级管理员: {username} / {password}"
        ))
