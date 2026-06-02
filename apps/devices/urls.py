from django.urls import path
from rest_framework.routers import DefaultRouter

from .views import ChannelViewSet, MachineViewSet, device_health_overview

router = DefaultRouter()
router.register("machines", MachineViewSet, basename="machine")
router.register("channels", ChannelViewSet, basename="channel")

urlpatterns = [
    path("health/overview/", device_health_overview, name="device-health-overview"),
] + router.urls
