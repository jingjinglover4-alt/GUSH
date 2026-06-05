from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from .serializers import LoginSerializer, UserSerializer


class LoginView(TokenObtainPairView):
    """POST /api/auth/login/  body: {username, password}"""
    serializer_class = LoginSerializer
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        response = super().post(request, *args, **kwargs)
        # 记录登录 IP
        if response.status_code == 200:
            user_data = response.data.get("user") or {}
            user_id = user_data.get("id")
            if user_id:
                from .models import User
                ip = request.META.get("HTTP_X_FORWARDED_FOR", "").split(",")[0].strip()
                ip = ip or request.META.get("REMOTE_ADDR")
                User.objects.filter(id=user_id).update(last_login_ip=ip)
        return response


class RefreshView(TokenRefreshView):
    """POST /api/auth/refresh/  body: {refresh}"""
    permission_classes = (AllowAny,)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def me(request):
    """GET /api/auth/me/ - 获取当前登录用户信息"""
    return Response(UserSerializer(request.user).data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def logout(request):
    """前端清 token 即可，后端无 session 可清；预留接口给后续黑名单逻辑"""
    return Response({"detail": "logged out"}, status=status.HTTP_200_OK)
