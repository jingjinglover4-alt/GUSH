"""
ASGI 入口
- HTTP 走标准 Django
- WebSocket 走 channels（auth 通过 query string 自己实现）
"""
import os

from django.core.asgi import get_asgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "gush.settings")

# 先初始化 Django ASGI，再 import 含 ORM 的 routing
django_asgi_app = get_asgi_application()

from channels.routing import ProtocolTypeRouter, URLRouter  # noqa: E402

from apps.devices.routing import websocket_urlpatterns  # noqa: E402


application = ProtocolTypeRouter({
    "http": django_asgi_app,
    "websocket": URLRouter(websocket_urlpatterns),
})
