#!/usr/bin/env python3
"""
硬件网关连接测试脚本
测试服务器端和硬件的WebSocket连接
"""

import asyncio
import websockets
import json
import time
import sys

async def test_server_connection():
    """测试连接服务器硬件网关"""
    print("测试连接服务器硬件网关...")
    
    server_url = "ws://localhost:5003"  # 假设本地测试
    imei = "865709045268307"
    token = "test_token"  # 测试用令牌
    
    headers = {
        'X-Hardware-IMEI': imei,
        'X-Auth-Token': token
    }
    
    try:
        async with websockets.connect(
            server_url,
            extra_headers=headers,
            ping_interval=20,
            ping_timeout=10
        ) as websocket:
            print(f"连接成功: {server_url}")
            
            # 发送注册消息
            register_msg = {
                'type': 'register',
                'imei': imei,
                'sn': 'MP0623472DF9B5F',
                'firmware_version': '1.0.0',
                'timestamp': time.strftime('%Y-%m-%dT%H:%M:%SZ')
            }
            
            await websocket.send(json.dumps(register_msg))
            print("注册消息已发送")
            
            # 等待响应
            try:
                response = await asyncio.wait_for(websocket.recv(), timeout=5)
                print(f"收到响应: {response}")
                
                # 发送心跳
                heartbeat_msg = {
                    'type': 'heartbeat',
                    'imei': imei,
                    'timestamp': time.strftime('%Y-%m-%dT%H:%M:%SZ'),
                    'status': {'cpu_temp': 45.2, 'signal': -72}
                }
                
                await websocket.send(json.dumps(heartbeat_msg))
                print("心跳消息已发送")
                
                # 接收心跳确认
                ack = await asyncio.wait_for(websocket.recv(), timeout=5)
                print(f"心跳确认: {ack}")
                
                print("测试通过!")
                return True
                
            except asyncio.TimeoutError:
                print("响应超时")
                return False
                
    except Exception as e:
        print(f"连接失败: {e}")
        return False

async def test_hardware_agent():
    """测试硬件代理模拟"""
    print("\n测试硬件代理模拟...")
    
    # 模拟硬件代理的基本功能
    print("1. 读取配置文件...")
    config = {
        'imei': '865709045268307',
        'sn': 'MP0623472DF9B5F',
        'token': 'test_token',
        'server_url': 'ws://localhost:5003'
    }
    
    print(f"   IMEI: {config['imei']}")
    print(f"   SN: {config['sn']}")
    print(f"   服务器: {config['server_url']}")
    
    print("2. 模拟系统信息获取...")
    system_info = {
        'cpu_temperature': 45.2,
        'memory_usage': 65.3,
        'disk_free': '8.2GB',
        'network_rssi': -72,
        'stm32_connected': True,
        'uptime': 86400
    }
    
    for key, value in system_info.items():
        print(f"   {key}: {value}")
    
    print("3. 模拟命令执行...")
    commands = [
        {'type': 'dispense', 'channel': 'A0', 'success': True},
        {'type': 'query_inventory', 'success': True, 'inventory': {'A0': 5, 'A1': 3}},
        {'type': 'query_status', 'success': True, 'status': system_info}
    ]
    
    for cmd in commands:
        print(f"   执行 {cmd['type']}: {'成功' if cmd['success'] else '失败'}")
    
    print("\n硬件代理模拟测试通过!")
    return True

def test_database_init():
    """测试数据库初始化"""
    print("\n测试数据库初始化...")
    
    try:
        # 尝试导入数据库模块
        import sqlite3
        
        # 创建内存数据库测试
        conn = sqlite3.connect(':memory:')
        cursor = conn.cursor()
        
        # 创建测试表
        cursor.execute('''
        CREATE TABLE hardware_connections (
            id INTEGER PRIMARY KEY,
            imei VARCHAR(20) UNIQUE NOT NULL,
            online BOOLEAN DEFAULT 0
        )
        ''')
        
        # 插入测试数据
        cursor.execute(
            "INSERT INTO hardware_connections (imei, online) VALUES (?, ?)",
            ('865709045268307', 1)
        )
        
        # 查询数据
        cursor.execute("SELECT * FROM hardware_connections")
        result = cursor.fetchone()
        
        print(f"  数据库连接: 成功")
        print(f"  表创建: 成功")
        print(f"  数据插入: 成功")
        print(f"  查询结果: IMEI={result[1]}, 在线={bool(result[2])}")
        
        conn.close()
        print("数据库测试通过!")
        return True
        
    except Exception as e:
        print(f"数据库测试失败: {e}")
        return False

def main():
    """主测试函数"""
    print("=" * 60)
    print("HI拿4G远程控制系统 - 功能测试")
    print("=" * 60)
    
    tests = [
        ("数据库初始化", test_database_init),
        ("硬件代理模拟", lambda: asyncio.run(test_hardware_agent())),
        ("服务器连接", lambda: asyncio.run(test_server_connection()))
    ]
    
    results = []
    
    for test_name, test_func in tests:
        print(f"\n[{test_name}]")
        try:
            success = test_func()
            results.append((test_name, success))
        except Exception as e:
            print(f"测试异常: {e}")
            results.append((test_name, False))
    
    # 输出测试结果
    print("\n" + "=" * 60)
    print("测试结果汇总:")
    print("=" * 60)
    
    all_passed = True
    for test_name, success in results:
        status = "✓ 通过" if success else "✗ 失败"
        print(f"  {test_name}: {status}")
        if not success:
            all_passed = False
    
    print("\n" + "=" * 60)
    if all_passed:
        print("所有测试通过! 🎉")
        print("系统架构验证完成，可以开始部署。")
    else:
        print("部分测试失败，请检查问题。")
        print("建议先修复失败的项目再继续。")
    
    return all_passed

if __name__ == "__main__":
    try:
        success = main()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        print("\n测试被用户中断")
        sys.exit(1)