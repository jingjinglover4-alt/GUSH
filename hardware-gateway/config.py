import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    """硬件网关配置"""
    
    # 服务器配置
    SECRET_KEY = os.getenv('SECRET_KEY', 'hardware-gateway-secret-key-2026')
    HOST = os.getenv('HOST', '0.0.0.0')
    PORT = int(os.getenv('PORT', 5003))
    DEBUG = os.getenv('DEBUG', 'False').lower() == 'true'
    
    # WebSocket配置
    SOCKETIO_PING_TIMEOUT = int(os.getenv('SOCKETIO_PING_TIMEOUT', 30))
    SOCKETIO_PING_INTERVAL = int(os.getenv('SOCKETIO_PING_INTERVAL', 25))
    SOCKETIO_ASYNC_MODE = os.getenv('SOCKETIO_ASYNC_MODE', 'eventlet')
    
    # Redis配置（用于连接管理）
    REDIS_URL = os.getenv('REDIS_URL', 'redis://localhost:6379/0')
    
    # 数据库配置（使用现有SQLite数据库）
    DATABASE_URI = os.getenv('DATABASE_URI', 'sqlite:////opt/hinana-admin/instance/hinana.db')
    
    # 安全配置
    TOKEN_SECRET = os.getenv('TOKEN_SECRET', 'hardware-token-secret-2026')
    TOKEN_EXPIRE_DAYS = int(os.getenv('TOKEN_EXPIRE_DAYS', 365))
    
    # 硬件认证
    ALLOWED_IMEI_PREFIXES = ['86570904']  # 允许的IMEI前缀（华为模块）
    
    # 速率限制
    RATE_LIMIT_PER_MINUTE = int(os.getenv('RATE_LIMIT_PER_MINUTE', 60))
    
    # 日志配置
    LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
    LOG_FILE = os.getenv('LOG_FILE', '/var/log/hardware-gateway.log')