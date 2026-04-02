#!/usr/bin/env python3
"""
HI拿硬件网关服务
提供硬件与服务器之间的WebSocket通信，支持远程控制、状态监控和实时调试
"""

import os
import sys
import json
import logging
from datetime import datetime, timedelta
from typing import Dict, Any, Optional

from flask import Flask, request, jsonify
from flask_socketio import SocketIO, emit, join_room, leave_room
from flask_cors import CORS

# 导入自定义模块
from config import Config
from hardware_manager import HardwareManager, HardwareInfo
from security import SecurityManager, RateLimiter
from models import Base, HardwareConnection, RemoteCommand, HardwareLog, NetworkStatus

# 配置日志
logging.basicConfig(
    level=getattr(logging, Config.LOG_LEVEL),
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(Config.LOG_FILE) if Config.LOG_FILE else logging.StreamHandler(),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

# 初始化Flask应用
app = Flask(__name__)
app.config['SECRET_KEY'] = Config.SECRET_KEY

# 允许跨域（生产环境应限制）
CORS(app, resources={r"/*": {"origins": "*"}})

# 初始化SocketIO
socketio = SocketIO(
    app,
    cors_allowed_origins="*",
    ping_timeout=Config.SOCKETIO_PING_TIMEOUT,
    ping_interval=Config.SOCKETIO_PING_INTERVAL,
    async_mode=Config.SOCKETIO_ASYNC_MODE,
    logger=logger.level == logging.DEBUG,
    engineio_logger=logger.level == logging.DEBUG
)

# 初始化管理器
hardware_manager = HardwareManager(Config.REDIS_URL)
security_manager = SecurityManager(Config.SECRET_KEY, Config.TOKEN_SECRET)
rate_limiter = RateLimiter(hardware_manager.redis, Config.RATE_LIMIT_PER_MINUTE)

# 数据库会话（简化版，实际应使用SQLAlchemy会话管理）
# 这里假设使用现有管理后台的数据库连接


# ==================== WebSocket事件处理 ====================

@socketio.on('connect')
def handle_connect():
    """硬件连接事件"""
    # 从请求头获取认证信息
    imei = request.headers.get('X-Hardware-IMEI')
    token = request.headers.get('X-Auth-Token')
    sid = request.sid
    
    logger.info(f"硬件连接请求: IMEI={imei}, SID={sid}")
    
    # 验证令牌
    if not imei or not token:
        logger.warning(f"缺少认证信息: IMEI={imei}, Token={'已提供' if token else '未提供'}")
        return False
    
    if not hardware_manager.verify_hardware_token(imei, token):
        logger.warning(f"硬件令牌验证失败: {imei}")
        return False
    
    # 检查速率限制
    allowed, remaining, reset = rate_limiter.check_limit(f"connect:{imei}")
    if not allowed:
        logger.warning(f"硬件 {imei} 连接频率超限")
        return False
    
    # 获取客户端IP
    client_ip = request.remote_addr
    if request.headers.get('X-Forwarded-For'):
        client_ip = request.headers.get('X-Forwarded-For').split(',')[0].strip()
    
    logger.info(f"硬件 {imei} 连接成功，IP: {client_ip}, SID: {sid}")
    return True


@socketio.on('disconnect')
def handle_disconnect():
    """硬件断开连接事件"""
    sid = request.sid
    hardware_manager.disconnect_hardware(sid)
    logger.info(f"硬件断开连接: SID={sid}")


@socketio.on('register')
def handle_register(data: Dict[str, Any]):
    """硬件注册事件"""
    sid = request.sid
    imei = data.get('imei')
    sn = data.get('sn')
    
    if not imei or not sn:
        emit('error', {'message': '缺少IMEI或SN'})
        return
    
    # 验证IMEI格式
    if not security_manager.validate_imei_format(imei):
        emit('error', {'message': '无效的IMEI格式'})
        return
    
    # 检查IMEI前缀是否允许
    allowed = False
    for prefix in Config.ALLOWED_IMEI_PREFIXES:
        if imei.startswith(prefix):
            allowed = True
            break
    
    if not allowed:
        emit('error', {'message': 'IMEI不在允许列表中'})
        return
    
    # 注册硬件
    hardware_info = hardware_manager.register_hardware(imei, sid, data)
    
    # 发送注册成功响应
    emit('registered', {
        'status': 'success',
        'timestamp': datetime.utcnow().isoformat(),
        'hardware_id': imei,
        'server_time': datetime.utcnow().isoformat()
    })
    
    logger.info(f"硬件注册成功: {imei} ({sn})")


@socketio.on('heartbeat')
def handle_heartbeat(data: Dict[str, Any]):
    """处理硬件心跳"""
    sid = request.sid
    imei = data.get('imei')
    
    if not imei:
        emit('error', {'message': '缺少IMEI'})
        return
    
    # 更新心跳
    hardware_manager.update_heartbeat(imei, data)
    
    # 发送心跳确认
    emit('heartbeat_ack', {
        'timestamp': datetime.utcnow().isoformat(),
        'server_time': datetime.utcnow().isoformat(),
        'commands_pending': 0  # 可以扩展为实际待处理命令数
    })
    
    # 记录网络状态（如果提供了网络信息）
    if 'signal_strength' in data or 'network_type' in data:
        record_network_status(imei, data)


@socketio.on('command_response')
def handle_command_response(data: Dict[str, Any]):
    """处理硬件命令响应"""
    command_id = data.get('command_id')
    imei = data.get('imei')
    success = data.get('success', False)
    result = data.get('result', {})
    
    if not command_id or not imei:
        logger.warning(f"无效的命令响应: {data}")
        return
    
    # 更新命令状态到数据库
    update_command_status(command_id, imei, success, result)
    
    # 通知管理后台（通过SocketIO房间）
    emit('command_completed', {
        'command_id': command_id,
        'imei': imei,
        'success': success,
        'result': result,
        'completed_at': datetime.utcnow().isoformat()
    }, room=f'admin_{imei}')
    
    logger.info(f"命令响应: {command_id}, 成功: {success}")


@socketio.on('log')
def handle_hardware_log(data: Dict[str, Any]):
    """处理硬件日志"""
    imei = data.get('imei')
    level = data.get('level', 'info')
    message = data.get('message')
    component = data.get('component', 'hardware')
    
    if not imei or not message:
        return
    
    # 存储日志到数据库
    store_hardware_log(imei, level, component, message, data.get('details'))
    
    # 转发到管理后台（实时查看）
    emit('hardware_log', {
        'imei': imei,
        'level': level,
        'component': component,
        'message': message,
        'timestamp': datetime.utcnow().isoformat(),
        'details': data.get('details')
    }, room=f'logs_{imei}')
    
    # 如果是错误日志，发送警报
    if level in ['error', 'critical']:
        emit('hardware_alert', {
            'imei': imei,
            'level': level,
            'message': message,
            'timestamp': datetime.utcnow().isoformat()
        }, room='admin_alerts')


# ==================== HTTP API端点 ====================

@app.route('/api/health', methods=['GET'])
def health_check():
    """健康检查端点"""
    return jsonify({
        'status': 'healthy',
        'timestamp': datetime.utcnow().isoformat(),
        'online_hardware': hardware_manager.get_online_hardware_count(),
        'total_hardware': len(hardware_manager.get_all_hardware()),
        'version': '1.0.0'
    })


@app.route('/api/hardware', methods=['GET'])
def get_all_hardware():
    """获取所有硬件连接列表"""
    # 验证管理后台权限（简化版）
    auth_token = request.headers.get('Authorization')
    if not auth_token or not validate_admin_token(auth_token):
        return jsonify({'error': '未授权'}), 401
    
    hardware_list = hardware_manager.get_all_hardware()
    return jsonify([{
        'imei': hw.imei,
        'sn': hw.sn,
        'sid': hw.sid,
        'ip_address': hw.ip_address,
        'signal_strength': hw.signal_strength,
        'firmware_version': hw.firmware_version,
        'last_heartbeat': hw.last_heartbeat.isoformat() if hw.last_heartbeat else None,
        'online': hw.online,
        'connection_count': hw.connection_count,
        'created_at': hw.created_at.isoformat() if hw.created_at else None
    } for hw in hardware_list])


@app.route('/api/hardware/<imei>/command', methods=['POST'])
def send_command_to_hardware(imei: str):
    """向指定硬件发送命令（管理后台调用）"""
    # 验证管理后台权限（简化版）
    auth_token = request.headers.get('Authorization')
    if not auth_token or not validate_admin_token(auth_token):
        return jsonify({'error': '未授权'}), 401
    
    # 解析命令
    command_data = request.get_json()
    if not command_data:
        return jsonify({'error': '无效的JSON数据'}), 400
    
    command_type = command_data.get('type')
    if not command_type:
        return jsonify({'error': '缺少命令类型'}), 400
    
    # 生成命令ID
    command_id = generate_command_id()
    
    # 创建命令记录
    command_record = create_command_record(command_id, imei, command_type, command_data)
    
    # 发送给硬件
    hardware_info = hardware_manager.get_hardware_by_imei(imei)
    if not hardware_info or not hardware_info.online:
        # 硬件离线，命令进入等待队列
        queue_command_for_offline_hardware(command_id, imei, command_data)
        return jsonify({
            'status': 'queued',
            'command_id': command_id,
            'message': '硬件离线，命令已加入队列'
        })
    
    # 硬件在线，通过WebSocket发送
    command_packet = {
        'type': 'command',
        'command_id': command_id,
        'command_type': command_type,
        'data': command_data,
        'timestamp': datetime.utcnow().isoformat(),
        'ttl': 30  # 30秒内有效
    }
    
    # 发送签名命令（可选）
    if command_type in ['dispense', 'reboot', 'update_config']:
        signature = security_manager.generate_command_signature(
            command_data, command_packet['timestamp']
        )
        command_packet['signature'] = signature
    
    # 通过SocketIO发送
    socketio.emit('command', command_packet, room=hardware_info.sid)
    
    return jsonify({
        'status': 'sent',
        'command_id': command_id,
        'message': '命令已发送到硬件'
    })


@app.route('/api/hardware/<imei>/status', methods=['GET'])
def get_hardware_status(imei: str):
    """获取硬件状态"""
    hardware_info = hardware_manager.get_hardware_by_imei(imei)
    if not hardware_info:
        return jsonify({'error': '硬件未找到'}), 404
    
    return jsonify({
        'imei': hardware_info.imei,
        'sn': hardware_info.sn,
        'online': hardware_info.online,
        'last_heartbeat': hardware_info.last_heartbeat.isoformat() if hardware_info.last_heartbeat else None,
        'signal_strength': hardware_info.signal_strength,
        'firmware_version': hardware_info.firmware_version,
        'connection_count': hardware_info.connection_count,
        'ip_address': hardware_info.ip_address
    })


@app.route('/api/hardware/tokens/generate', methods=['POST'])
def generate_hardware_token_api():
    """生成硬件令牌（管理后台调用）"""
    auth_token = request.headers.get('Authorization')
    if not auth_token or not validate_admin_token(auth_token):
        return jsonify({'error': '未授权'}), 401
    
    data = request.get_json()
    if not data:
        return jsonify({'error': '无效的JSON数据'}), 400
    
    imei = data.get('imei')
    sn = data.get('sn')
    
    if not imei or not sn:
        return jsonify({'error': '缺少IMEI或SN'}), 400
    
    # 生成令牌
    token = hardware_manager.generate_hardware_token(imei, sn, Config.TOKEN_SECRET)
    
    return jsonify({
        'imei': imei,
        'sn': sn,
        'token': token,
        'generated_at': datetime.utcnow().isoformat(),
        'expires_in': '30天'
    })


# ==================== 工具函数 ====================

def generate_command_id() -> str:
    """生成命令ID"""
    timestamp = datetime.utcnow().strftime('%Y%m%d%H%M%S')
    random_suffix = os.urandom(4).hex()
    return f"cmd_{timestamp}_{random_suffix}"


def create_command_record(command_id: str, imei: str, command_type: str, command_data: Dict[str, Any]) -> RemoteCommand:
    """创建命令记录（简化版）"""
    # 实际应使用数据库会话
    logger.info(f"创建命令记录: {command_id} for {imei}")
    return None  # 占位符


def update_command_status(command_id: str, imei: str, success: bool, result: Dict[str, Any]):
    """更新命令状态（简化版）"""
    logger.info(f"更新命令状态: {command_id}, 成功: {success}")


def store_hardware_log(imei: str, level: str, component: str, message: str, details: Any = None):
    """存储硬件日志（简化版）"""
    log_entry = {
        'imei': imei,
        'level': level,
        'component': component,
        'message': message,
        'timestamp': datetime.utcnow().isoformat()
    }
    if details:
        log_entry['details'] = details
    
    # 实际应存储到数据库
    logger.debug(f"硬件日志: {log_entry}")


def record_network_status(imei: str, data: Dict[str, Any]):
    """记录网络状态（简化版）"""
    # 实际应存储到数据库
    pass


def queue_command_for_offline_hardware(command_id: str, imei: str, command_data: Dict[str, Any]):
    """为离线硬件队列命令（简化版）"""
    logger.info(f"命令 {command_id} 加入离线队列 for {imei}")


def validate_admin_token(token: str) -> bool:
    """验证管理后台令牌（简化版）"""
    # 实际应验证JWT或会话令牌
    return token == 'admin-demo-token'  # 简化


# ==================== 定时任务 ====================

def cleanup_task():
    """清理任务：移除不活跃的硬件连接"""
    try:
        cleaned = hardware_manager.cleanup_inactive_hardware()
        if cleaned > 0:
            logger.info(f"清理了 {cleaned} 个不活跃硬件连接")
    except Exception as e:
        logger.error(f"清理任务失败: {e}")

def periodic_cleanup():
    """定期清理任务"""
    import time
    while True:
        time.sleep(300)  # 每5分钟执行一次
        cleanup_task()


# ==================== 启动应用 ====================

if __name__ == '__main__':
    logger.info("=" * 60)
    logger.info("HI拿硬件网关服务启动")
    logger.info(f"监听地址: {Config.HOST}:{Config.PORT}")
    logger.info(f"调试模式: {Config.DEBUG}")
    logger.info(f"日志级别: {Config.LOG_LEVEL}")
    logger.info("=" * 60)
    
    # 启动清理定时器（每5分钟一次）
    socketio.start_background_task(periodic_cleanup)
    
    # 启动SocketIO应用
    socketio.run(
        app,
        host=Config.HOST,
        port=Config.PORT,
        debug=Config.DEBUG,
        use_reloader=False,
        log_output=Config.DEBUG
    )