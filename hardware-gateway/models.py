"""
硬件网关数据模型
扩展现有管理后台数据库，添加4G远程控制相关表
"""

from datetime import datetime
from typing import Optional
from sqlalchemy import Column, Integer, String, Text, DateTime, Boolean, Float, ForeignKey, JSON
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()


class HardwareConnection(Base):
    """硬件连接状态表"""
    __tablename__ = 'hardware_connections'
    
    id = Column(Integer, primary_key=True)
    imei = Column(String(20), unique=True, nullable=False, index=True)
    serial_number = Column(String(50), nullable=False)
    
    # 连接状态
    socketio_sid = Column(String(100))  # SocketIO Session ID
    ip_address = Column(String(45))
    signal_strength = Column(Integer)  # RSSI值，负数
    network_type = Column(String(20))  # 4G, 5G, WiFi
    online = Column(Boolean, default=False)
    last_seen = Column(DateTime)
    connection_count = Column(Integer, default=0)
    
    # 硬件信息
    firmware_version = Column(String(50))
    hardware_version = Column(String(50))
    orange_pi_serial = Column(String(50))
    
    # 性能指标
    cpu_temperature = Column(Float)
    memory_usage = Column(Float)  # 百分比
    disk_usage = Column(Float)    # 百分比
    uptime_seconds = Column(Integer)
    
    # 关联机器
    machine_id = Column(Integer, ForeignKey('machines.id'), nullable=True)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class RemoteCommand(Base):
    """远程命令日志表"""
    __tablename__ = 'remote_commands'
    
    id = Column(Integer, primary_key=True)
    command_id = Column(String(50), unique=True, index=True)  # 命令唯一ID
    imei = Column(String(20), nullable=False, index=True)
    
    # 命令信息
    command_type = Column(String(50), nullable=False)  # dispense, query, update, reboot
    command_data = Column(Text)  # JSON格式的命令参数
    priority = Column(String(20), default='normal')  # low, normal, high, critical
    
    # 状态跟踪
    status = Column(String(20), default='pending')  # pending, sent, executing, success, failed, timeout
    sent_at = Column(DateTime)
    executed_at = Column(DateTime)
    response_data = Column(Text)  # JSON格式的响应
    error_message = Column(Text)
    
    # 关联信息
    initiated_by = Column(String(50))  # admin_id, api, system
    machine_id = Column(Integer, ForeignKey('machines.id'), nullable=True)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class HardwareToken(Base):
    """硬件认证令牌表"""
    __tablename__ = 'hardware_tokens'
    
    id = Column(Integer, primary_key=True)
    imei = Column(String(20), unique=True, nullable=False, index=True)
    serial_number = Column(String(50), nullable=False)
    
    # 令牌信息
    token_hash = Column(String(64), nullable=False)  # SHA256哈希
    salt = Column(String(32), nullable=False)
    
    # 安全信息
    is_active = Column(Boolean, default=True)
    revoked_at = Column(DateTime)
    revoke_reason = Column(String(100))
    
    # 使用统计
    last_used_at = Column(DateTime)
    usage_count = Column(Integer, default=0)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    expires_at = Column(DateTime)


class HardwareLog(Base):
    """硬件日志表"""
    __tablename__ = 'hardware_logs'
    
    id = Column(Integer, primary_key=True)
    imei = Column(String(20), nullable=False, index=True)
    log_level = Column(String(20))  # debug, info, warning, error, critical
    component = Column(String(50))  # hardware_agent, local_api, stm32, network
    
    message = Column(Text, nullable=False)
    details = Column(Text)  # JSON格式的详细信息
    
    machine_id = Column(Integer, ForeignKey('machines.id'), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow, index=True)


class NetworkStatus(Base):
    """网络状态历史表"""
    __tablename__ = 'network_status_history'
    
    id = Column(Integer, primary_key=True)
    imei = Column(String(20), nullable=False, index=True)
    
    # 网络指标
    signal_strength = Column(Integer)  # RSSI值
    network_type = Column(String(20))
    operator = Column(String(50))  # 运营商
    cell_id = Column(String(50))   # 基站ID
    
    # 连接质量
    ping_latency_ms = Column(Integer)
    packet_loss_rate = Column(Float)  # 丢包率百分比
    bandwidth_kbps = Column(Integer)  # 带宽估计
    
    # 位置信息（如果GPS可用）
    latitude = Column(Float)
    longitude = Column(Float)
    location_accuracy = Column(Float)  # 定位精度（米）
    
    machine_id = Column(Integer, ForeignKey('machines.id'), nullable=True)
    recorded_at = Column(DateTime, default=datetime.utcnow, index=True)


# 命令类型常量
COMMAND_TYPES = {
    'DISPENSE': 'dispense',
    'QUERY_INVENTORY': 'query_inventory',
    'QUERY_STATUS': 'query_status',
    'UPDATE_CONFIG': 'update_config',
    'REBOOT': 'reboot',
    'FIRMWARE_UPGRADE': 'firmware_upgrade',
    'UPLOAD_LOGS': 'upload_logs',
    'DIAGNOSTIC': 'diagnostic',
    'TEST_COMMUNICATION': 'test_communication'
}

# 命令状态常量
COMMAND_STATUS = {
    'PENDING': 'pending',
    'SENT': 'sent',
    'EXECUTING': 'executing',
    'SUCCESS': 'success',
    'FAILED': 'failed',
    'TIMEOUT': 'timeout'
}

# 日志级别常量
LOG_LEVELS = {
    'DEBUG': 'debug',
    'INFO': 'info',
    'WARNING': 'warning',
    'ERROR': 'error',
    'CRITICAL': 'critical'
}