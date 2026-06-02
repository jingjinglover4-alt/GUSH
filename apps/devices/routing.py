"""WebSocket URL 路由"""
from django.urls import re_path

from . import consumers

websocket_urlpatterns = [
    # 设备端：远程 HTML 页面（被 Qt WebView 载入）连这个
    # 鉴权用 query string：?machine_id=MACHINE001&secret=xxx
    re_path(r"^ws/device/$", consumers.DeviceConsumer.as_asgi()),
]
