#!/usr/bin/env python3
"""
硬件网关数据库初始化脚本
在现有管理后台数据库中添加硬件相关表
"""

import sqlite3
import os
import sys
from datetime import datetime

def get_database_path():
    """获取数据库路径"""
    # 尝试多个可能的路径
    possible_paths = [
        '/opt/hinana-admin/instance/hinana.db',
        '/opt/hinana-admin/hinana.db',
        './instance/hinana.db',
        './hinana.db'
    ]
    
    for path in possible_paths:
        if os.path.exists(path):
            return path
    
    # 如果不存在，使用默认路径
    default_path = '/opt/hinana-admin/instance/hinana.db'
    os.makedirs(os.path.dirname(default_path), exist_ok=True)
    return default_path

def create_tables(conn):
    """创建硬件相关表"""
    cursor = conn.cursor()
    
    # 1. 硬件连接状态表
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS hardware_connections (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imei VARCHAR(20) UNIQUE NOT NULL,
        serial_number VARCHAR(50) NOT NULL,
        socketio_sid VARCHAR(100),
        ip_address VARCHAR(45),
        signal_strength INTEGER,
        network_type VARCHAR(20),
        online BOOLEAN DEFAULT 0,
        last_seen TIMESTAMP,
        connection_count INTEGER DEFAULT 0,
        firmware_version VARCHAR(50),
        hardware_version VARCHAR(50),
        orange_pi_serial VARCHAR(50),
        cpu_temperature REAL,
        memory_usage REAL,
        disk_usage REAL,
        uptime_seconds INTEGER,
        machine_id INTEGER,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (machine_id) REFERENCES machines(id)
    )
    ''')
    
    # 创建索引
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_hardware_imei ON hardware_connections(imei)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_hardware_online ON hardware_connections(online)')
    
    # 2. 远程命令日志表
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS remote_commands (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        command_id VARCHAR(50) UNIQUE NOT NULL,
        imei VARCHAR(20) NOT NULL,
        command_type VARCHAR(50) NOT NULL,
        command_data TEXT,
        priority VARCHAR(20) DEFAULT 'normal',
        status VARCHAR(20) DEFAULT 'pending',
        sent_at TIMESTAMP,
        executed_at TIMESTAMP,
        response_data TEXT,
        error_message TEXT,
        initiated_by VARCHAR(50),
        machine_id INTEGER,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (machine_id) REFERENCES machines(id)
    )
    ''')
    
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_commands_imei ON remote_commands(imei)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_commands_status ON remote_commands(status)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_commands_created ON remote_commands(created_at)')
    
    # 3. 硬件令牌表
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS hardware_tokens (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imei VARCHAR(20) UNIQUE NOT NULL,
        serial_number VARCHAR(50) NOT NULL,
        token_hash VARCHAR(64) NOT NULL,
        salt VARCHAR(32) NOT NULL,
        is_active BOOLEAN DEFAULT 1,
        revoked_at TIMESTAMP,
        revoke_reason VARCHAR(100),
        last_used_at TIMESTAMP,
        usage_count INTEGER DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        expires_at TIMESTAMP
    )
    ''')
    
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_tokens_imei ON hardware_tokens(imei)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_tokens_active ON hardware_tokens(is_active)')
    
    # 4. 硬件日志表
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS hardware_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imei VARCHAR(20) NOT NULL,
        log_level VARCHAR(20),
        component VARCHAR(50),
        message TEXT NOT NULL,
        details TEXT,
        machine_id INTEGER,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (machine_id) REFERENCES machines(id)
    )
    ''')
    
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_logs_imei ON hardware_logs(imei)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_logs_created ON hardware_logs(created_at)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_logs_level ON hardware_logs(log_level)')
    
    # 5. 网络状态历史表
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS network_status_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imei VARCHAR(20) NOT NULL,
        signal_strength INTEGER,
        network_type VARCHAR(20),
        operator VARCHAR(50),
        cell_id VARCHAR(50),
        ping_latency_ms INTEGER,
        packet_loss_rate REAL,
        bandwidth_kbps INTEGER,
        latitude REAL,
        longitude REAL,
        location_accuracy REAL,
        machine_id INTEGER,
        recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (machine_id) REFERENCES machines(id)
    )
    ''')
    
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_network_imei ON network_status_history(imei)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_network_recorded ON network_status_history(recorded_at)')
    
    # 6. 更新现有的machines表，添加4G相关字段（如果不存在）
    try:
        # 检查imei字段是否存在
        cursor.execute("PRAGMA table_info(machines)")
        columns = [col[1] for col in cursor.fetchall()]
        
        if 'imei' not in columns:
            print("在machines表中添加imei字段...")
            cursor.execute('ALTER TABLE machines ADD COLUMN imei VARCHAR(20)')
        
        if 'sim_no' not in columns:
            print("在machines表中添加sim_no字段...")
            cursor.execute('ALTER TABLE machines ADD COLUMN sim_no VARCHAR(20)')
        
        if 'firmware_version' not in columns:
            print("在machines表中添加firmware_version字段...")
            cursor.execute('ALTER TABLE machines ADD COLUMN firmware_version VARCHAR(50)')
        
        if 'last_location_update' not in columns:
            print("在machines表中添加last_location_update字段...")
            cursor.execute('ALTER TABLE machines ADD COLUMN last_location_update TIMESTAMP')
            
    except Exception as e:
        print(f"更新machines表时出错: {e}")
        # 继续执行，这些字段可能已经存在
    
    conn.commit()
    print("数据库表创建/更新完成")

def seed_initial_data(conn):
    """种子初始数据（如果需要）"""
    cursor = conn.cursor()
    
    # 检查是否已经有测试硬件令牌
    cursor.execute("SELECT COUNT(*) FROM hardware_tokens WHERE imei = '865709045268307'")
    count = cursor.fetchone()[0]
    
    if count == 0:
        print("为测试硬件创建初始令牌...")
        # 生成测试令牌（实际应由管理后台生成）
        import hashlib
        import secrets
        
        imei = '865709045268307'
        sn = 'MP0623472DF9B5F'
        secret = 'hardware-token-secret-2026'
        salt = secrets.token_hex(16)
        
        raw = f"{imei}:{sn}:{secret}:{salt}"
        token_hash = hashlib.sha256(raw.encode()).hexdigest()
        
        cursor.execute('''
        INSERT INTO hardware_tokens 
        (imei, serial_number, token_hash, salt, expires_at)
        VALUES (?, ?, ?, ?, datetime('now', '+30 days'))
        ''', (imei, sn, token_hash, salt))
        
        conn.commit()
        print(f"为IMEI {imei} 创建了测试令牌")
    
    print("初始数据检查完成")

def main():
    """主函数"""
    print("HI拿硬件网关数据库初始化")
    print("=" * 50)
    
    # 获取数据库路径
    db_path = get_database_path()
    print(f"数据库路径: {db_path}")
    
    # 连接数据库
    try:
        conn = sqlite3.connect(db_path)
        print("数据库连接成功")
    except Exception as e:
        print(f"连接数据库失败: {e}")
        sys.exit(1)
    
    try:
        # 创建表
        create_tables(conn)
        
        # 种子初始数据
        seed_initial_data(conn)
        
        # 显示表信息
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")
        tables = cursor.fetchall()
        
        print("\n数据库表列表:")
        for table in tables:
            cursor.execute(f"SELECT COUNT(*) FROM {table[0]}")
            count = cursor.fetchone()[0]
            print(f"  {table[0]}: {count} 行")
        
        print("\n数据库初始化完成!")
        
    except Exception as e:
        print(f"数据库初始化失败: {e}")
        sys.exit(1)
    finally:
        conn.close()

if __name__ == '__main__':
    main()