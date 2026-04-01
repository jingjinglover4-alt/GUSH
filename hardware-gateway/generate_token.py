#!/usr/bin/env python3
"""
硬件令牌生成脚本
使用方式: python generate_token.py <imei> <serial_number> [--redis-url <url>] [--secret <secret>]
"""

import sys
import os
import argparse
from datetime import datetime, timedelta

# 添加当前目录到Python路径以便导入本地模块
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

def main():
    parser = argparse.ArgumentParser(description='生成硬件认证令牌')
    parser.add_argument('imei', help='硬件IMEI（15位数字）')
    parser.add_argument('sn', help='硬件序列号')
    parser.add_argument('--redis-url', default='redis://localhost:6379/0', 
                       help='Redis连接URL（默认: redis://localhost:6379/0）')
    parser.add_argument('--secret', default='hardware-token-secret-2026',
                       help='令牌生成密钥（默认: hardware-token-secret-2026）')
    parser.add_argument('--expire-days', type=int, default=30,
                       help='令牌有效期天数（默认: 30）')
    parser.add_argument('--output-config', action='store_true',
                       help='输出硬件配置文件片段')
    
    args = parser.parse_args()
    
    # 验证IMEI格式（15位数字）
    if not args.imei.isdigit() or len(args.imei) != 15:
        print(f"错误: IMEI必须是15位数字，收到: {args.imei}")
        sys.exit(1)
    
    try:
        # 导入所需模块
        import redis
        import hashlib
        import secrets
        
        # 连接到Redis
        print(f"连接Redis: {args.redis_url}")
        redis_client = redis.Redis.from_url(args.redis_url, decode_responses=True)
        
        # 测试Redis连接
        redis_client.ping()
        print("Redis连接成功")
        
        # 生成令牌（使用与hardware_manager.py相同的逻辑）
        salt = secrets.token_hex(8)
        raw = f"{args.imei}:{args.sn}:{args.secret}"
        token_hash = hashlib.sha256(f"{raw}:{salt}".encode()).hexdigest()
        token = f"hw_{token_hash[:24]}"  # 格式: hw_<24字符哈希>
        
        # 存储到Redis，有效期30天
        token_key = f"hardware_token:{args.imei}"
        redis_client.setex(token_key, timedelta(days=args.expire_days), token)
        
        print("\n" + "="*50)
        print("硬件令牌生成成功!")
        print("="*50)
        print(f"IMEI: {args.imei}")
        print(f"序列号: {args.sn}")
        print(f"令牌: {token}")
        print(f"有效期: {args.expire_days}天")
        print(f"Redis键: {token_key}")
        
        # 同时存储到数据库（可选）
        try:
            import sqlite3
            # 尝试找到数据库路径
            db_path = '/opt/hinana-admin/instance/hinana.db'
            if os.path.exists(db_path):
                conn = sqlite3.connect(db_path)
                cursor = conn.cursor()
                
                # 检查表是否存在
                cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='hardware_tokens'")
                if cursor.fetchone():
                    # 插入或更新令牌
                    cursor.execute('''
                    INSERT OR REPLACE INTO hardware_tokens 
                    (imei, serial_number, token_hash, salt, expires_at, is_active, created_at)
                    VALUES (?, ?, ?, ?, datetime('now', ?), 1, datetime('now'))
                    ''', (args.imei, args.sn, token_hash, salt, f"+{args.expire_days} days"))
                    
                    conn.commit()
                    conn.close()
                    print(f"令牌已存储到数据库: {db_path}")
        except Exception as db_error:
            print(f"注意: 数据库存储失败（可忽略）: {db_error}")
        
        # 如果需要，输出配置文件片段
        if args.output_config:
            print("\n" + "="*50)
            print("硬件配置文件片段:")
            print("="*50)
            print(f"""# 硬件标识
imei: "{args.imei}"
sn: "{args.sn}"

# 服务器连接  
server_url: "wss://cdgushai.com:5003"
token: "{token}"

# 本地API配置
local_api_url: "http://localhost:8080"
""")
        
        print("\n使用说明:")
        print(f"1. 在硬件配置文件(/etc/hinana/hardware.conf)中设置: token: \"{token}\"")
        print(f"2. 令牌将在 {args.expire_days} 天后过期")
        print(f"3. 可通过Redis删除令牌: redis-cli DEL {token_key}")
        
    except redis.exceptions.ConnectionError as e:
        print(f"Redis连接失败: {e}")
        print("请确保Redis服务正在运行，或使用 --redis-url 参数指定正确的Redis地址")
        sys.exit(1)
    except Exception as e:
        print(f"生成令牌时出错: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main()
