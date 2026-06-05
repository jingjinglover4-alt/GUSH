"""
Phase 1.7 - 子域名 → Machine 解析中间件

生产域名：{subdomain}.gush.cdgushai.com
- 解析子域名拿到 Machine
- 暴露到 request.device_machine（供视图层判断「当前设备」）

本地开发：
- 不带子域名时不解析，视图回退到 ?machine_id= / URL 参数
"""
import logging
import re

from django.conf import settings

logger = logging.getLogger(__name__)

# 跳过的「保留」子域名
SKIP_SUBDOMAINS = {"www", "admin", "api"}


class SubdomainMachineMiddleware:
    """从 Host 头解析子域名 → Machine 实例。失败安静跳过。"""

    def __init__(self, get_response):
        self.get_response = get_response
        self.root_domain = getattr(settings, "ROOT_DOMAIN", "gush.cdgushai.com")

    def __call__(self, request):
        request.device_machine = None
        request.device_subdomain = None

        try:
            self._resolve(request)
        except Exception:
            logger.exception("子域名解析失败")

        return self.get_response(request)

    def _resolve(self, request):
        host = (request.get_host() or "").split(":")[0].lower()
        if not host:
            return

        # 本地开发 host：localhost / 127.0.0.1 / IP → 无子域
        if host in ("localhost", "127.0.0.1") or re.match(r"^\d+\.\d+\.\d+\.\d+$", host):
            return

        # 必须是 {sub}.{root}
        suffix = "." + self.root_domain
        if not host.endswith(suffix):
            return
        sub = host[: -len(suffix)]
        if not sub or "." in sub or sub in SKIP_SUBDOMAINS:
            return

        request.device_subdomain = sub

        # 延迟 import 避免循环
        from .models import Machine
        machine = Machine.objects.filter(subdomain=sub).first()
        if machine:
            request.device_machine = machine
