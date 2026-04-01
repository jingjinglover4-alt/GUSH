import redis
import json
import logging
from datetime import datetime, timedelta
from typing import Dict, Optional, List
from dataclasses import dataclass, asdict
import hashlib
import secrets

logger = logging.getLogger(__name__)

@dataclass
class HardwareInfo:
    """硬件信息"""
    imei: str
    sn: str
    sid: str  # SocketIO session ID
    ip_address: str
    signal_strength: int = 0  # RSSI值，负数，越大越好
    firmware_version: str = "1.0.0"
    last_heartbeat: datetime = None
    online: bool = False
    connection_count: int = 0
    created_at: datetime = None


class HardwareManager:
    """硬件连接管理器"""
    
    def __init__(self, redis_url: str):
        self.redis = redis.Redis.from_url(redis_url, decode_responses=True)
        self.active_hardware: Dict[str, HardwareInfo] = {}  # imei -> HardwareInfo
        self.sid_to_imei: Dict[str, str] = {}  # sid -> imei
        self.hardware_tokens: Dict[str, str] = {}  # imei -> token
        
    def generate_hardware_token(self, imei: str, sn: str, secret: str) -> str:
        """生成硬件认证令牌"""
        raw = f"{imei}:{sn}:{secret}"
        salt = secrets.token_hex(8)
        token_hash = hashlib.sha256(f"{raw}:{salt}".encode()).hexdigest()
        token = f"hw_{token_hash[:24]}"  # 格式: hw_<24字符哈希>
        
        # 存储到Redis，有效期30天
        token_key = f"hardware_token:{imei}"
        self.redis.setex(token_key, timedelta(days=30), token)
        
        # 同时存储到内存缓存
        self.hardware_tokens[imei] = token
        
        logger.info(f"为硬件 {imei} 生成令牌: {token[:8]}...")
        return token
    
    def verify_hardware_token(self, imei: str, token: str) -> bool:
        """验证硬件令牌"""
        # 首先检查内存缓存
        if imei in self.hardware_tokens and self.hardware_tokens[imei] == token:
            return True
        
        # 检查Redis
        token_key = f"hardware_token:{imei}"
        stored_token = self.redis.get(token_key)
        
        if stored_token and stored_token == token:
            # 更新内存缓存
            self.hardware_tokens[imei] = token
            return True
        
        return False
    
    def register_hardware(self, imei: str, sid: str, data: dict) -> HardwareInfo:
        """注册硬件连接"""
        # 检查是否已存在
        if imei in self.active_hardware:
            old_info = self.active_hardware[imei]
            old_info.online = False
            # 清理旧的sid映射
            if old_info.sid in self.sid_to_imei:
                del self.sid_to_imei[old_info.sid]
        
        # 创建新的硬件信息
        hardware = HardwareInfo(
            imei=imei,
            sn=data.get('sn', ''),
            sid=sid,
            ip_address=data.get('ip', ''),
            signal_strength=data.get('signal_strength', 0),
            firmware_version=data.get('firmware_version', '1.0.0'),
            last_heartbeat=datetime.utcnow(),
            online=True,
            connection_count=data.get('connection_count', 0),
            created_at=datetime.utcnow()
        )
        
        # 存储到内存
        self.active_hardware[imei] = hardware
        self.sid_to_imei[sid] = imei
        
        # 存储到Redis（用于跨进程/重启恢复）
        hardware_key = f"hardware_active:{imei}"
        self.redis.hset(hardware_key, mapping={
            "imei": imei,
            "sn": hardware.sn,
            "sid": sid,
            "ip_address": hardware.ip_address,
            "signal_strength": str(hardware.signal_strength),
            "firmware_version": hardware.firmware_version,
            "last_heartbeat": hardware.last_heartbeat.isoformat(),
            "online": "1",
            "connection_count": str(hardware.connection_count),
            "created_at": hardware.created_at.isoformat() if hardware.created_at else ""
        })
        self.redis.expire(hardware_key, timedelta(hours=1))
        
        logger.info(f"硬件 {imei} 注册成功，SID: {sid}")
        return hardware
    
    def update_heartbeat(self, imei: str, data: dict):
        """更新硬件心跳"""
        if imei not in self.active_hardware:
            logger.warning(f"硬件 {imei} 未注册，尝试注册")
            return False
        
        hardware = self.active_hardware[imei]
        hardware.last_heartbeat = datetime.utcnow()
        
        # 更新信号强度等信息
        if 'signal_strength' in data:
            hardware.signal_strength = data['signal_strength']
        
        # 更新Redis
        hardware_key = f"hardware_active:{imei}"
        self.redis.hset(hardware_key, "last_heartbeat", hardware.last_heartbeat.isoformat())
        if 'signal_strength' in data:
            self.redis.hset(hardware_key, "signal_strength", str(hardware.signal_strength))
        
        logger.debug(f"硬件 {imei} 心跳更新")
        return True
    
    def get_hardware_by_imei(self, imei: str) -> Optional[HardwareInfo]:
        """根据IMEI获取硬件信息"""
        return self.active_hardware.get(imei)
    
    def get_hardware_by_sid(self, sid: str) -> Optional[HardwareInfo]:
        """根据SocketIO SID获取硬件信息"""
        imei = self.sid_to_imei.get(sid)
        return self.active_hardware.get(imei) if imei else None
    
    def disconnect_hardware(self, sid: str):
        """硬件断开连接"""
        imei = self.sid_to_imei.get(sid)
        if not imei:
            logger.warning(f"未知SID断开: {sid}")
            return
        
        if imei in self.active_hardware:
            hardware = self.active_hardware[imei]
            hardware.online = False
            
            # 更新Redis
            hardware_key = f"hardware_active:{imei}"
            self.redis.hset(hardware_key, "online", "0")
            
            logger.info(f"硬件 {imei} 断开连接")
        
        # 清理映射
        if sid in self.sid_to_imei:
            del self.sid_to_imei[sid]
    
    def get_online_hardware_count(self) -> int:
        """获取在线硬件数量"""
        return sum(1 for hw in self.active_hardware.values() if hw.online)
    
    def get_all_hardware(self) -> List[HardwareInfo]:
        """获取所有硬件信息"""
        return list(self.active_hardware.values())
    
    def cleanup_inactive_hardware(self, timeout_minutes: int = 5):
        """清理不活跃的硬件连接"""
        cutoff = datetime.utcnow() - timedelta(minutes=timeout_minutes)
        inactive_hardware = []
        
        for imei, hardware in self.active_hardware.items():
            if hardware.last_heartbeat and hardware.last_heartbeat < cutoff:
                inactive_hardware.append(imei)
        
        for imei in inactive_hardware:
            hardware = self.active_hardware[imei]
            hardware.online = False
            
            # 清理映射
            sid = hardware.sid
            if sid in self.sid_to_imei:
                del self.sid_to_imei[sid]
            
            logger.info(f"清理不活跃硬件: {imei}")
        
        return len(inactive_hardware)