from rest_framework.routers import DefaultRouter

from .views import ProjectViewSet, RedeemCodeViewSet

router = DefaultRouter()
router.register("projects", ProjectViewSet, basename="project")
router.register("codes", RedeemCodeViewSet, basename="redeem-code")

urlpatterns = router.urls
