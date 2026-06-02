"""
操作日志中间件
- 仅记录写操作（POST/PUT/PATCH/DELETE）
- 跳过登录/刷新/公开接口
- 异步幂等：失败不影响业务
"""
import logging

from django.utils.deprecation import MiddlewareMixin

logger = logging.getLogger("apps.operations")

_WRITE_METHODS = {"POST", "PUT", "PATCH", "DELETE"}
_SKIP_PREFIXES = (
    "/api/auth/login",
    "/api/auth/token",
    "/api/public/",
    "/api/health",
    "/admin/login",
)


class OperationLogMiddleware(MiddlewareMixin):
    def process_response(self, request, response):
        try:
            if request.method not in _WRITE_METHODS:
                return response
            path = request.path or ""
            if any(path.startswith(p) for p in _SKIP_PREFIXES):
                return response
            # 仅记录 API 路径
            if not path.startswith("/api/"):
                return response

            from .models import OperationLog  # 延迟导入，避免 app loading 顺序问题

            user = getattr(request, "user", None)
            is_auth = bool(user and user.is_authenticated)
            ip = (
                request.META.get("HTTP_X_FORWARDED_FOR", "").split(",")[0].strip()
                or request.META.get("REMOTE_ADDR", "")
            )
            ua = request.META.get("HTTP_USER_AGENT", "")[:255]

            OperationLog.objects.create(
                user=user if is_auth else None,
                username=getattr(user, "username", "") if is_auth else "",
                method=request.method,
                path=path[:255],
                status_code=response.status_code,
                ip=ip[:64],
                user_agent=ua,
                summary="",
            )
        except Exception as e:  # noqa: BLE001
            logger.warning("operation log failed: %s", e)
        return response
