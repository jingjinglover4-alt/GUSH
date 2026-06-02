from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    role_display = serializers.CharField(source="get_role_display", read_only=True)

    class Meta:
        model = User
        fields = (
            "id", "username", "email", "phone", "avatar",
            "role", "role_display", "is_active", "last_login",
        )
        read_only_fields = ("id", "last_login")


class LoginSerializer(TokenObtainPairSerializer):
    """
    扩展 JWT 登录 - 返回 token 同时附带用户基本信息
    """

    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        token["role"] = user.role
        token["username"] = user.username
        return token

    def validate(self, attrs):
        data = super().validate(attrs)
        data["user"] = UserSerializer(self.user).data
        # 限制：仅运营/超管能登录后台
        if not self.user.is_admin_role and not self.user.is_superuser:
            raise serializers.ValidationError("该账号无管理后台访问权限")
        return data
