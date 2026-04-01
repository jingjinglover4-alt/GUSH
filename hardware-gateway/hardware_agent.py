#!/usr/bin/env python3
"""
HI拿硬件代理服务
运行在Orange Pi上，连接4G模块与云端服务器通信
使用Socket.IO客户端与服务器通信
"""

import asyncio
import socketio
import json
import logging
import time
import sys
import os
from datetime import datetime
from typing import Optional, Dict, Any
import requests
import threading
import queue

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('/var/log/hardware-agent.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)


class HardwareAgent:
    """硬件代理主类"""
    
    def __init__(self, config_path: str = '/etc/hinana/hardware.conf'):
        self.config = self.load_config(config_path)
        self.imei = self.config.get('imei', '')
        self.sn = self.config.get('sn', '')
        self.token = self.config.get('token', '')
        self.server_url = self.config.get('server_url', 'ws://150.158.20.232:8003')
        
        # 串口配置
        self.modem_device = self.config.get('modem_device', '/dev/ttyUSB2')
        self.stm32_device = self.config.get('stm32_device', '/dev/ttyUSB0')
        self.baud_rate = self.config.get('baud_rate', 115200)
        
        # 本地API地址（现有的local_api.py）
        self.local_api_url = self.config.get('local_api_url', 'http://localhost:8080')
        
        # 连接状态
        self.sio = None
        self.connected = False
        self.last_heartbeat = 0
        self.heartbeat_interval = self.config.get('heartbeat_interval', 30)  # 秒
        
        # 命令队列
        self.command_queue = queue.Queue()
        self.command_results = {}  # command_id -> result
        
        # 硬件状态
        self.hardware_status = {
            'cpu_temperature': 0.0,
            'memory_used': 0.0,
            'disk_free': '0GB',
            'network_rssi': -99,
            'stm32_connected': False,
            'inventory': {}
        }
    
    def load_config(self, config_path: str) -> Dict[str, Any]:
        """加载硬件配置文件"""
        config = {
            'imei': '865709045268307',  # 默认值，从4G模块读取
            'sn': 'MP0623472DF9B5F',
            'token': '',  # 需要从管理后台获取
            'server_url': 'ws://150.158.20.232:8003',  # 硬件网关地址（HTTP）
            'local_api_url': 'http://localhost:8080',  # 本地API地址
            'local_api_port': 8080,  # 兼容旧配置
            'heartbeat_interval': 30,
            'log_level': 'INFO',
            'modem_device': '/dev/ttyUSB2',  # 4G模块设备路径
            'stm32_device': '/dev/ttyUSB0',  # STM32串口设备路径
            'baud_rate': 115200  # 串口波特率
        }
        
        # 尝试从文件加载配置
        if os.path.exists(config_path):
            try:
                with open(config_path, 'r') as f:
                    import yaml
                    file_config = yaml.safe_load(f)
                    if file_config:
                        config.update(file_config)
            except Exception as e:
                logger.warning(f"加载配置文件失败: {e}")
        
        # 尝试从4G模块读取IMEI
        if not config['imei'] or config['imei'] == '865709045268307':
            config['imei'] = self.read_imei_from_modem()
        
        logger.info(f"硬件配置加载完成: IMEI={config['imei'][:8]}..., SN={config['sn']}")
        return config
    
    def read_imei_from_modem(self) -> str:
        """从4G模块读取IMEI"""
        try:
            # 尝试通过AT命令读取IMEI
            import serial
            ser = serial.Serial(self.modem_device, self.baud_rate, timeout=1)
            ser.write(b'AT+CGSN\r\n')
            time.sleep(0.5)
            response = ser.read_all().decode('utf-8', errors='ignore')
            ser.close()
            
            # 解析IMEI
            for line in response.split('\n'):
                line = line.strip()
                if line.isdigit() and len(line) == 15:
                    logger.info(f"从模块读取到IMEI: {line}")
                    return line
        except Exception as e:
            logger.warning(f"读取4G模块IMEI失败: {e}")
        
        # 返回默认值
        return '865709045268307'
    
    async def connect_to_server(self):
        """连接服务器Socket.IO"""
        while True:
            try:
                # 创建Socket.IO客户端
                self.sio = socketio.AsyncClient(
                    reconnection=True,
                    reconnection_attempts=0,  # 无限重试
                    reconnection_delay=1,
                    reconnection_delay_max=60,
                    randomization_factor=0.5
                )
                
                # 设置事件处理函数
                self.setup_event_handlers()
                
                # 连接服务器
                logger.info(f"连接服务器: {self.server_url}")
                headers = {
                    'X-Hardware-IMEI': self.imei,
                    'X-Auth-Token': self.token
                }
                
                await self.sio.connect(
                    self.server_url,
                    headers=headers,
                    wait_timeout=30
                )
                
                self.connected = True
                logger.info("服务器连接成功")
                
                # 发送注册事件
                await self.register_hardware()
                
                # 等待连接保持（Socket.IO会自动重连）
                await self.sio.wait()
                
            except socketio.exceptions.ConnectionError as e:
                self.connected = False
                logger.error(f"Socket.IO连接错误: {e}")
            except Exception as e:
                self.connected = False
                logger.error(f"连接服务器失败: {e}")
            
            # 连接断开，等待后重试
            wait_time = 5  # 默认等待5秒
            logger.info(f"{wait_time}秒后重试连接...")
            await asyncio.sleep(wait_time)
    
    def setup_event_handlers(self):
        """设置Socket.IO事件处理函数"""
        
        @self.sio.event
        async def connect():
            """连接成功事件"""
            logger.info("Socket.IO连接成功")
        
        @self.sio.event
        async def disconnect():
            """断开连接事件"""
            logger.warning("Socket.IO连接断开")
            self.connected = False
        
        @self.sio.event
        async def connect_error(data):
            """连接错误事件"""
            logger.error(f"Socket.IO连接错误: {data}")
            self.connected = False
        
        @self.sio.on('heartbeat_ack')
        async def on_heartbeat_ack(data):
            """心跳确认事件"""
            self.last_heartbeat = time.time()
            logger.debug("收到心跳确认")
        
        @self.sio.on('command')
        async def on_command(data):
            """服务器命令事件"""
            logger.info(f"收到服务器命令: {data.get('command_type', 'unknown')}")
            await self.handle_server_command(data)
        
        @self.sio.on('registered')
        async def on_registered(data):
            """注册成功事件"""
            logger.info("硬件注册成功")
        
        @self.sio.on('*')
        async def catch_all(event, data):
            """捕获所有未处理的事件"""
            logger.debug(f"收到未处理事件: {event}, 数据: {data}")
    
    async def register_hardware(self):
        """向服务器注册硬件"""
        if not self.sio or not self.sio.connected:
            return
        
        registration_data = {
            'imei': self.imei,
            'sn': self.sn,
            'firmware_version': '1.0.0',
            'hardware_version': 'Orange Pi 3B V2.1',
            'timestamp': datetime.utcnow().isoformat()
        }
        
        # 发送注册事件（不是原始消息）
        await self.sio.emit('register', registration_data)
        logger.info("硬件注册信息已发送")
    
    async def handle_server_command(self, command: Dict[str, Any]):
        """处理服务器命令"""
        command_id = command.get('command_id')
        command_type = command.get('command_type')
        data = command.get('data', {})
        
        if not command_id or not command_type:
            logger.warning(f"无效命令格式: {command}")
            return
        
        logger.info(f"执行命令: {command_type} ({command_id})")
        
        try:
            # 根据命令类型执行不同操作
            if command_type == 'dispense':
                result = await self.execute_dispense_command(data)
            elif command_type == 'query_inventory':
                result = await self.query_inventory(data)
            elif command_type == 'query_status':
                result = await self.query_hardware_status(data)
            elif command_type == 'reboot':
                result = await self.reboot_hardware(data)
            elif command_type == 'update_config':
                result = await self.update_config(data)
            else:
                result = {'success': False, 'error': f'未知命令类型: {command_type}'}
            
            # 发送响应
            response = {
                'command_id': command_id,
                'imei': self.imei,
                'success': result.get('success', False),
                'result': result,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # 使用Socket.IO发送command_response事件
            await self.sio.emit('command_response', response)
            logger.info(f"命令响应已发送: {command_id}")
            
        except Exception as e:
            logger.error(f"执行命令失败: {e}")
            # 发送错误响应
            error_response = {
                'command_id': command_id,
                'imei': self.imei,
                'success': False,
                'error': str(e),
                'timestamp': datetime.utcnow().isoformat()
            }
            await self.sio.emit('command_response', error_response)
    
    async def execute_dispense_command(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """执行出货命令"""
        channel = data.get('channel')  # 如 "A0"
        amount = data.get('amount', 1)
        
        if not channel:
            return {'success': False, 'error': '缺少货道参数'}
        
        logger.info(f"执行出货: 货道 {channel}, 数量 {amount}")
        
        try:
            # 调用现有的local_api.py
            response = requests.post(
                f'{self.local_api_url}/dispense',
                json={'channel': channel, 'amount': amount},
                timeout=5
            )
            
            if response.status_code == 200:
                result = response.json()
                return {'success': True, 'result': result}
            else:
                return {'success': False, 'error': f'本地API错误: {response.status_code}'}
                
        except requests.exceptions.RequestException as e:
            return {'success': False, 'error': f'网络请求失败: {e}'}
        except Exception as e:
            return {'success': False, 'error': f'执行失败: {e}'}
    
    async def query_inventory(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """查询库存"""
        try:
            # 调用本地API查询库存
            response = requests.get(
                f'{self.local_api_url}/inventory',
                timeout=5
            )
            
            if response.status_code == 200:
                inventory = response.json()
                self.hardware_status['inventory'] = inventory
                return {'success': True, 'inventory': inventory}
            else:
                return {'success': False, 'error': f'查询失败: {response.status_code}'}
                
        except Exception as e:
            return {'success': False, 'error': f'查询失败: {e}'}
    
    async def query_hardware_status(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """查询硬件状态"""
        try:
            # 获取CPU温度
            cpu_temp = self.get_cpu_temperature()
            
            # 获取内存使用
            memory_used = self.get_memory_usage()
            
            # 获取磁盘空间
            disk_free = self.get_disk_free()
            
            # 获取网络信号
            network_rssi = self.get_network_signal()
            
            # 检查STM32连接
            stm32_connected = self.check_stm32_connection()
            
            status = {
                'cpu_temperature': cpu_temp,
                'memory_used': memory_used,
                'disk_free': disk_free,
                'network_rssi': network_rssi,
                'stm32_connected': stm32_connected,
                'uptime': self.get_uptime(),
                'timestamp': datetime.utcnow().isoformat()
            }
            
            self.hardware_status.update(status)
            return {'success': True, 'status': status}
            
        except Exception as e:
            return {'success': False, 'error': f'获取状态失败: {e}'}
    
    async def reboot_hardware(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """重启硬件"""
        logger.warning("收到重启命令")
        
        # 发送重启确认
        response = {'success': True, 'message': '硬件将在5秒后重启'}
        
        # 延迟执行重启
        asyncio.create_task(self.delayed_reboot(5))
        
        return response
    
    async def delayed_reboot(self, delay: int):
        """延迟重启"""
        await asyncio.sleep(delay)
        logger.info("执行系统重启")
        os.system('sudo reboot')
    
    async def update_config(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """更新配置"""
        config_data = data.get('config', {})
        
        if not config_data:
            return {'success': False, 'error': '缺少配置数据'}
        
        logger.info(f"更新配置: {config_data.keys()}")
        
        # 这里应该验证和保存配置
        try:
            # 保存配置到文件
            config_path = '/etc/hinana/hardware.conf'
            import yaml
            with open(config_path, 'w') as f:
                yaml.dump(config_data, f)
            
            return {'success': True, 'message': '配置已更新，重启后生效'}
        except Exception as e:
            return {'success': False, 'error': f'保存配置失败: {e}'}
    
    async def send_heartbeat(self):
        """发送心跳包"""
        while True:
            try:
                if self.connected and self.sio and self.sio.connected:
                    # 更新硬件状态
                    await self.update_hardware_status()
                    
                    heartbeat_data = {
                        'imei': self.imei,
                        'timestamp': datetime.utcnow().isoformat(),
                        'status': self.hardware_status
                    }
                    
                    # 使用Socket.IO发送heartbeat事件
                    await self.sio.emit('heartbeat', heartbeat_data)
                    logger.debug("心跳包已发送")
                    
            except Exception as e:
                logger.error(f"发送心跳包失败: {e}")
                self.connected = False
            
            await asyncio.sleep(self.heartbeat_interval)
    
    async def update_hardware_status(self):
        """更新硬件状态"""
        try:
            # 更新CPU温度
            self.hardware_status['cpu_temperature'] = self.get_cpu_temperature()
            
            # 更新内存使用
            self.hardware_status['memory_used'] = self.get_memory_usage()
            
            # 更新网络信号
            self.hardware_status['network_rssi'] = self.get_network_signal()
            
            # 检查STM32连接
            self.hardware_status['stm32_connected'] = self.check_stm32_connection()
            
        except Exception as e:
            logger.warning(f"更新硬件状态失败: {e}")
    
    # ==================== 系统信息获取函数 ====================
    
    def get_cpu_temperature(self) -> float:
        """获取CPU温度（Orange Pi）"""
        try:
            with open('/sys/class/thermal/thermal_zone0/temp', 'r') as f:
                temp = int(f.read().strip()) / 1000.0
            return temp
        except:
            return 0.0
    
    def get_memory_usage(self) -> float:
        """获取内存使用率"""
        try:
            with open('/proc/meminfo', 'r') as f:
                lines = f.readlines()
            
            total = 0
            free = 0
            for line in lines:
                if line.startswith('MemTotal:'):
                    total = int(line.split()[1])
                elif line.startswith('MemFree:'):
                    free = int(line.split()[1])
            
            if total > 0:
                used = total - free
                return (used / total) * 100.0
            return 0.0
        except:
            return 0.0
    
    def get_disk_free(self) -> str:
        """获取磁盘剩余空间"""
        try:
            import shutil
            total, used, free = shutil.disk_usage('/')
            return f"{free // (2**30)}GB"
        except:
            return "0GB"
    
    def get_network_signal(self) -> int:
        """获取网络信号强度（4G模块）"""
        try:
            # 尝试从4G模块读取信号强度
            import serial
            ser = serial.Serial(self.modem_device, self.baud_rate, timeout=1)
            ser.write(b'AT+CSQ\r\n')
            time.sleep(0.5)
            response = ser.read_all().decode('utf-8', errors='ignore')
            ser.close()
            
            # 解析CSQ值（0-31, 99表示未知）
            for line in response.split('\n'):
                if '+CSQ:' in line:
                    parts = line.split(':')
                    if len(parts) > 1:
                        csq_str = parts[1].split(',')[0].strip()
                        if csq_str.isdigit():
                            csq = int(csq_str)
                            if csq != 99:
                                # 转换为RSSI（近似值）
                                rssi = -113 + (csq * 2)
                                return max(-120, min(-50, rssi))
        except Exception as e:
            logger.debug(f"读取网络信号失败: {e}")
        
        return -99  # 默认值
    
    def check_stm32_connection(self) -> bool:
        """检查STM32连接状态"""
        try:
            # 尝试发送测试命令到STM32
            import serial
            ser = serial.Serial(self.stm32_device, self.baud_rate, timeout=1)
            ser.write(b'TEST\n')
            time.sleep(0.1)
            response = ser.read_all()
            ser.close()
            
            # 如果有任何响应，认为连接正常
            return len(response) > 0
        except:
            return False
    
    def get_uptime(self) -> int:
        """获取系统运行时间（秒）"""
        try:
            with open('/proc/uptime', 'r') as f:
                uptime_seconds = float(f.readline().split()[0])
            return int(uptime_seconds)
        except:
            return 0
    
    # ==================== 日志处理 ====================
    
    def log_message(self, level: str, message: str, details: Any = None):
        """记录日志并发送到服务器"""
        # 本地记录
        getattr(logger, level)(message)
        
        # 发送到服务器（如果连接正常）
        if self.connected and self.sio and self.sio.connected:
            log_data = {
                'imei': self.imei,
                'level': level,
                'message': message,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            if details:
                log_data['details'] = str(details)
            
            # 异步发送，不等待
            asyncio.create_task(self.send_log_async(log_data))
    
    async def send_log_async(self, log_data: Dict[str, Any]):
        """异步发送日志"""
        try:
            # 使用Socket.IO发送log事件
            await self.sio.emit('log', log_data)
        except:
            pass  # 发送失败时静默处理


async def main():
    """主函数"""
    logger.info("=" * 60)
    logger.info("HI拿硬件代理服务启动")
    logger.info("=" * 60)
    
    # 创建硬件代理实例
    agent = HardwareAgent()
    
    # 检查配置
    if not agent.token:
        logger.error("硬件令牌未配置！请从管理后台获取令牌并添加到 /etc/hinana/hardware.conf")
        logger.info("示例配置:")
        logger.info("token: your_hardware_token_here")
        return
    
    # 启动心跳任务
    heartbeat_task = asyncio.create_task(agent.send_heartbeat())
    
    # 连接服务器
    await agent.connect_to_server()
    
    # 清理（通常不会执行到这里）
    heartbeat_task.cancel()
    logger.info("硬件代理服务停止")


if __name__ == '__main__':
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        logger.info("收到中断信号，停止服务")
    except Exception as e:
        logger.error(f"服务异常退出: {e}")
        sys.exit(1)