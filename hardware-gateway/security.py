import hmac
import hashlib
import json
import logging
from datetime import datetime, timedelta
from typing import Optional, Dict, Any
import jwt
from cryptography.fernet import Fernet
import base64

logger = logging.getLogger(__name__)

class SecurityManager:
    """安全管理器：处理认证、加密和签名"""
    
    def __init__(self, secret_key: str, token_secret: str):
        self.secret_key = secret_key.encode()
        self.token_secret = token_secret
        # 生成加密密钥（用于敏感数据）
        self.fernet = Fernet(Fernet.generate_key())
    
    def generate_command_signature(self, command: Dict[str, Any], timestamp: str) -> str:
        """生成指令签名，防止篡改"""
        # 排序键确保签名一致
        sorted_items = sorted(command.items())
        command_str = json.dumps(sorted_items, separators=(',', ':'))
        
        # 构建签名消息
        message = f"{command_str}:{timestamp}"
        
        # 使用HMAC-SHA256签名
        signature = hmac.new(
            self.secret_key,
            message.encode('utf-8'),
            hashlib.sha256
        ).hexdigest()
        
        return signature
    
    def verify_command_signature(self, command: Dict[str, Any], timestamp: str, signature: str) -> bool:
        """验证指令签名"""
        # 检查时间戳有效性（防止重放攻击）
        try:
            cmd_time = datetime.fromisoformat(timestamp.replace('Z', '+00:00'))
            now = datetime.utcnow()
            
            # 指令有效期5分钟
            if abs((now - cmd_time).total_seconds()) > 300:
                logger.warning(f"指令时间戳过期: {timestamp}")
                return False
        except ValueError:
            logger.warning(f"无效时间戳格式: {timestamp}")
            return False
        
        # 重新计算签名进行验证
        expected_signature = self.generate_command_signature(command, timestamp)
        
        # 使用恒定时间比较防止时序攻击
        return hmac.compare_digest(signature, expected_signature)
    
    def encrypt_sensitive_data(self, data: str) -> str:
        """加密敏感数据（如配置中的密码）"""
        encrypted = self.fernet.encrypt(data.encode())
        return base64.urlsafe_b64encode(encrypted).decode()
    
    def decrypt_sensitive_data(self, encrypted_data: str) -> Optional[str]:
        """解密敏感数据"""
        try:
            encrypted = base64.urlsafe_b64decode(encrypted_data.encode())
            decrypted = self.fernet.decrypt(encrypted)
            return decrypted.decode()
        except Exception as e:
            logger.error(f"解密失败: {e}")
            return None
    
    def validate_imei_format(self, imei: str) -> bool:
        """验证IMEI格式"""
        if not imei or len(imei) != 15:
            return False
        
        # 检查是否为数字（最后一位可能是校验位）
        if not imei.isdigit():
            return False
        
        # 简单的Luhn算法校验
        total = 0
        for i, digit in enumerate(imei):
            n = int(digit)
            if (i + 1) % 2 == 0:  # 偶数位（从1开始计数）
                n *= 2
                if n > 9:
                    n -= 9
            total += n
        
        return total % 10 == 0
    
    def validate_sn_format(self, sn: str) -> bool:
        """验证序列号格式"""
        if not sn or len(sn) < 10:
            return False
        
        # 华为模块序列号通常为字母数字组合
        return sn.isalnum()
    
    def check_ip_whitelist(self, ip_address: str, whitelist: list) -> bool:
        """检查IP是否在白名单中"""
        if not whitelist:
            return True  # 空白名单表示允许所有
        
        import ipaddress
        
        try:
            client_ip = ipaddress.ip_address(ip_address)
            for network in whitelist:
                if client_ip in ipaddress.ip_network(network, strict=False):
                    return True
        except ValueError:
            logger.warning(f"无效IP地址: {ip_address}")
        
        return False


class RateLimiter:
    """速率限制器"""
    
    def __init__(self, redis_client, limit_per_minute: int = 60):
        self.redis = redis_client
        self.limit = limit_per_minute
    
    def check_limit(self, key: str) -> tuple:
        """检查速率限制，返回 (是否允许, 剩余请求数, 重置时间)"""
        current_minute = datetime.utcnow().strftime('%Y%m%d%H%M')
        redis_key = f"rate_limit:{key}:{current_minute}"
        
        # 使用Redis原子操作
        pipe = self.redis.pipeline()
        pipe.incr(redis_key)
        pipe.expire(redis_key, 61)  # 设置61秒过期，确保覆盖整个分钟
        result = pipe.execute()
        
        current_count = result[0]
        remaining = max(0, self.limit - current_count)
        
        if current_count > self.limit:
            logger.warning(f"速率限制触发: {key}, 当前: {current_count}, 限制: {self.limit}")
            return False, remaining, 61
        
        return True, remaining, 61


def create_test_token(imei: str, sn: str, secret: str) -> str:
    """创建测试用硬件令牌（简化版）"""
    import secrets
    raw = f"test:{imei}:{sn}:{secret}"
    token_hash = hashlib.sha256(raw.encode()).hexdigest()
    return f"test_{token_hash[:16]}"


if __name__ == "__main__":
    # 测试代码
    sm = SecurityManager("test-secret", "test-token-secret")
    
    # 测试签名
    command = {"type": "dispense", "channel": "A0", "amount": 1}
    timestamp = datetime.utcnow().isoformat()
    signature = sm.generate_command_signature(command, timestamp)
    
    print(f"命令: {command}")
    print(f"时间戳: {timestamp}")
    print(f"签名: {signature}")
    print(f"验证结果: {sm.verify_command_signature(command, timestamp, signature)}")