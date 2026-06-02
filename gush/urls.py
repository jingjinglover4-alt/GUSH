"""GUSH 2.0 顶层 URL 路由"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.http import JsonResponse
from django.urls import include, path

from apps.devices.views import device_console
from apps.pages.views import led_dispense, privacy_policy_page, public_led_page, public_privacy_policy, subdomain_root
from apps.projects.views import (
    qt_exchange,
    qt_report,
    public_claim_submit,
    public_project_dashboard_api,
    public_project_dashboard_page,
    public_redeem_page,
    public_redeem_submit,
)
from apps.stats.views import dashboard as stats_dashboard


def health(_request):
    """健康检查端点 - 供 Docker / 监控调用"""
    return JsonResponse({"status": "ok", "service": "gush2-backend"})


def system_info(_request):
    """系统配置 - 给前端拼 URL 用"""
    return JsonResponse({
        "root_domain": settings.ROOT_DOMAIN,
        "use_https": not settings.DEBUG,
    })


urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/health/", health),
    path("api/system/info/", system_info),
    path("api/auth/", include("apps.accounts.urls")),
    path("api/devices/", include("apps.devices.urls")),
    path("api/projects/", include("apps.projects.urls")),
    path("api/", include("apps.pages.urls")),
    path("api/", include("apps.face.urls")),
    path("api/", include("apps.products.urls")),
    path("api/operations/", include("apps.operations.urls")),
    path("api/stats/dashboard/", stats_dashboard, name="stats-dashboard"),
    # 远程控制台 - Qt WebView 加载此页
    path("device/console/<str:machine_id>/", device_console, name="device-console"),
    # C 端（公开）兑换页面 & 兑换接口
    path("p/<int:project_id>/", public_redeem_page, name="public-redeem-page"),
    path("api/public/redeem/", public_redeem_submit, name="public-redeem-submit"),
    path("api/public/redeem/api/exchange/", qt_exchange, name="qt-exchange"),
    path("api/public/redeem/api/report/", qt_report, name="qt-report"),
    path("api/public/claim/", public_claim_submit, name="public-claim-submit"),
    # 客户端看板
    path("api/public/project-dashboard/<str:token>/", public_project_dashboard_api, name="public-project-dashboard-api"),
    path("client/<str:token>/", public_project_dashboard_page, name="public-project-dashboard"),
    # LED 大屏页（Qt WebView 加载）
    path("led/<str:machine_id>/", public_led_page, name="public-led-page"),
    # LED 触摸屏直接出货
    path("api/public/led-dispense/", led_dispense, name="led-dispense"),
    path("api/public/privacy/<int:page_id>/", public_privacy_policy, name="public-privacy-policy"),
    path("p/privacy/<int:page_id>/", privacy_policy_page, name="privacy-policy-page"),
    # Phase 1.7：子域名根路径 → 自动 LED（需 device_subdomain.gush.cdgushai.com）
    path("", subdomain_root, name="subdomain-root"),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
