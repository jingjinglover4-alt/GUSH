"""页面装修 - URL 路由（挂在 /api/projects/{project_id}/ 下）"""
from django.urls import path

from . import views

urlpatterns = [
    path("projects/<int:project_id>/theme/", views.project_theme, name="project-theme"),
    path("projects/<int:project_id>/h5/", views.project_h5, name="project-h5"),
    path("projects/<int:project_id>/h5/publish/", views.publish_h5, name="project-h5-publish"),
    path("projects/<int:project_id>/led/", views.project_led, name="project-led"),
    path("projects/<int:project_id>/led/publish/", views.publish_led, name="project-led-publish"),
    path("projects/<int:project_id>/page-versions/", views.project_page_versions, name="project-page-versions"),
    path("projects/<int:project_id>/page-versions/<int:version_id>/restore/",
         views.restore_page_version, name="project-page-version-restore"),
    # Phase 1.7：设备级覆盖
    path("devices/<str:machine_id>/page-override/", views.device_page_override, name="device-page-override"),
    # Phase 2.2：访问上报 + 漏斗
    path("public/visit/", views.public_visit_report, name="public-visit-report"),
    path("projects/<int:project_id>/stats/funnel/", views.project_funnel, name="project-funnel"),
    # Phase 2.3：A/B 实验
    path("projects/<int:project_id>/experiment/", views.project_experiment, name="project-experiment"),
    path("projects/<int:project_id>/experiment/variants/<int:variant_id>/",
         views.experiment_variant, name="project-experiment-variant"),
    path("projects/<int:project_id>/experiment/transition/",
         views.experiment_transition, name="project-experiment-transition"),
    path("projects/<int:project_id>/experiment/stats/",
         views.experiment_stats, name="project-experiment-stats"),
    path("projects/<int:project_id>/upload/", views.upload_image, name="project-upload"),
    # Phase 2.5：CSV 导出
    path("projects/<int:project_id>/stats/funnel/export/",
         views.export_project_funnel, name="export-funnel"),
    path("projects/<int:project_id>/experiment/export/",
         views.export_experiment, name="export-experiment"),
]
