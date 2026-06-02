"""人脸画像 - 路由（挂在 /api/ 下）"""
from django.urls import path

from . import views, leads_views

urlpatterns = [
    # 设备侧上报（公开，secret 鉴权）
    path("public/face/upload/", views.upload_face_image, name="face-upload"),
    path("public/face/observation/", views.submit_face_observation, name="face-observation"),

    # 用户获客列表（鉴权）
    path("projects/<int:project_id>/leads/", leads_views.project_leads, name="project-leads"),
    path("projects/<int:project_id>/leads/summary/", leads_views.project_leads_summary,
         name="project-leads-summary"),
    path("projects/<int:project_id>/leads/export/", leads_views.export_leads_csv,
         name="project-leads-export"),
    path("projects/<int:project_id>/leads/delete/", leads_views.delete_leads,
         name="project-leads-delete"),
]
