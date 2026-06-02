"""
GUSH 2.0 派样机SaaS - Django 配置
所有可变项均通过环境变量读取，便于本地/生产切换。
"""
import os
from datetime import timedelta
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

# ============================================================
# 安全 & 调试
# ============================================================
SECRET_KEY = os.environ.get("DJANGO_SECRET_KEY", "dev-insecure-key")
DEBUG = os.environ.get("DJANGO_DEBUG", "1") == "1"
ALLOWED_HOSTS = os.environ.get("DJANGO_ALLOWED_HOSTS", "*").split(",")

# ============================================================
# 应用注册
# ============================================================
INSTALLED_APPS = [
    # daphne 必须放在 staticfiles 之前，让 runserver 走 ASGI
    "daphne",
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # 第三方
    "channels",
    "rest_framework",
    "rest_framework_simplejwt",
    "corsheaders",
    "django_filters",
    # 本项目
    "apps.accounts",
    "apps.devices",
    "apps.projects",
    "apps.products",
    "apps.stats",
    "apps.operations",
    "apps.pages",
    "apps.face",
]

MIDDLEWARE = [
    "corsheaders.middleware.CorsMiddleware",
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
    "apps.operations.middleware.OperationLogMiddleware",
    # Phase 1.7：子域名 → Machine 解析（写入 request.device_machine）
    "apps.devices.middleware.SubdomainMachineMiddleware",
]

ROOT_URLCONF = "gush.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [BASE_DIR / "templates"],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "gush.wsgi.application"
ASGI_APPLICATION = "gush.asgi.application"

# ============================================================
# Channels - WebSocket
# ============================================================
CHANNEL_LAYERS = {
    "default": {
        "BACKEND": "channels_redis.core.RedisChannelLayer",
        "CONFIG": {
            "hosts": [os.environ.get("REDIS_URL", "redis://localhost:6379/0")],
        },
    }
}

# ============================================================
# 数据库 - MySQL 8
# ============================================================
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.mysql",
        "NAME": os.environ.get("MYSQL_DATABASE", "gush2"),
        "USER": os.environ.get("MYSQL_USER", "gush"),
        "PASSWORD": os.environ.get("MYSQL_PASSWORD", "gush_pass_2024"),
        "HOST": os.environ.get("MYSQL_HOST", "localhost"),
        "PORT": os.environ.get("MYSQL_PORT", "3306"),
        "OPTIONS": {
            "charset": "utf8mb4",
            "init_command": "SET sql_mode='STRICT_TRANS_TABLES'",
        },
    }
}

# ============================================================
# Redis 缓存
# ============================================================
CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": os.environ.get("REDIS_URL", "redis://localhost:6379/0"),
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        },
    }
}

# ============================================================
# 自定义用户模型
# ============================================================
AUTH_USER_MODEL = "accounts.User"

AUTH_PASSWORD_VALIDATORS = [
    {"NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"},
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
     "OPTIONS": {"min_length": 8}},
    {"NAME": "django.contrib.auth.password_validation.CommonPasswordValidator"},
    {"NAME": "django.contrib.auth.password_validation.NumericPasswordValidator"},
]

# ============================================================
# DRF + JWT
# ============================================================
REST_FRAMEWORK = {
    "DEFAULT_AUTHENTICATION_CLASSES": (
        "rest_framework_simplejwt.authentication.JWTAuthentication",
    ),
    "DEFAULT_PERMISSION_CLASSES": (
        "rest_framework.permissions.IsAuthenticated",
    ),
    "DEFAULT_FILTER_BACKENDS": (
        "django_filters.rest_framework.DjangoFilterBackend",
        "rest_framework.filters.SearchFilter",
        "rest_framework.filters.OrderingFilter",
    ),
    "DEFAULT_PAGINATION_CLASS": "rest_framework.pagination.PageNumberPagination",
    "PAGE_SIZE": 20,
    "DATETIME_FORMAT": "%Y-%m-%d %H:%M:%S",
}

SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(hours=12),
    "REFRESH_TOKEN_LIFETIME": timedelta(days=7),
    "AUTH_HEADER_TYPES": ("Bearer",),
    "USER_ID_FIELD": "id",
    "USER_ID_CLAIM": "user_id",
}

# ============================================================
# CORS（开发期允许所有，生产用白名单）
# ============================================================
CORS_ALLOW_ALL_ORIGINS = DEBUG
CORS_ALLOWED_ORIGINS = [
    "http://localhost:5173",
    "http://127.0.0.1:5173",
    "https://admin.gush.cdgushai.com",
]
CORS_ALLOW_CREDENTIALS = True

# ============================================================
# 安全 - 反代（Nginx）支持
# ============================================================
SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")
# 信任 X-Forwarded-Host（不设则自动用 Host header，此处为 admin.gush.cdgushai.com）
# USE_X_FORWARDED_HOST = True

# ============================================================
# 国际化 & 静态文件
# ============================================================
LANGUAGE_CODE = "zh-hans"
TIME_ZONE = "Asia/Shanghai"
USE_I18N = True
USE_TZ = True

STATIC_URL = "/static/"
STATIC_ROOT = BASE_DIR / "staticfiles"
MEDIA_URL = "/media/"
MEDIA_ROOT = BASE_DIR / "media"

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"

# ============================================================
# 日志
# ============================================================
LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "verbose": {
            "format": "[{asctime}] {levelname} {name} {message}",
            "style": "{",
        },
    },
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "formatter": "verbose",
        },
    },
    "root": {
        "handlers": ["console"],
        "level": "INFO",
    },
    "loggers": {
        "django.db.backends": {"level": "WARNING"},
        "apps": {"level": "DEBUG" if DEBUG else "INFO"},
    },
}

# ============================================================
# 业务常量
# ============================================================
# 一台机器的固定货道数量（与硬件协议 A0-F9 一致）
MACHINE_CHANNEL_ROWS = ["A", "B", "C", "D", "E", "F"]   # 6 层（行）
MACHINE_CHANNEL_COLS = list(range(10))                  # 每层 10 个货道
MACHINE_CHANNEL_CAPACITY = 5                            # 每货道容量 5 个样品

# 心跳超时（秒）：超过该时长未上报心跳标记为离线
HEARTBEAT_TIMEOUT_SECONDS = 90

# 主域名（用于生成设备子域名）
ROOT_DOMAIN = os.environ.get("ROOT_DOMAIN", "gush.cdgushai.com")

# 地理编码 API（腾讯位置服务 https://lbs.qq.com）
GEOCODING_API_KEY = os.environ.get("GEOCODING_API_KEY", "")
