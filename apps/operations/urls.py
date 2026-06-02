from rest_framework.routers import DefaultRouter

from .views import OperationLogViewSet

router = DefaultRouter()
router.register("logs", OperationLogViewSet, basename="operation-log")

urlpatterns = router.urls
