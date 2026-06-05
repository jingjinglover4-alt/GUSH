"""新建项目时自动创建主题 + H5 落地页（默认草稿态）"""
from django.db.models.signals import post_save
from django.dispatch import receiver

from apps.projects.models import Project

from .models import H5Page, LedPage, PageTheme


@receiver(post_save, sender=Project)
def ensure_pages_for_project(sender, instance: Project, created: bool, **kwargs):
    if not created:
        return
    PageTheme.objects.get_or_create(project=instance)
    H5Page.objects.get_or_create(project=instance)
    LedPage.objects.get_or_create(project=instance)
