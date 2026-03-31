#!/usr/bin/env python3
"""
HI拿智能派样SaaS系统 - 中控台API路由模块
此模块需要添加到现有app.py中，为中控台提供数据接口
"""

import json
import sqlite3
import subprocess
import time
from datetime import datetime, timedelta
import psutil
import os
from flask import jsonify, request

def register_control_apis(app):
    """
    为中控台注册API路由
    """
    
    # 创建数据库连接
    def get_db():
        conn = sqlite3.connect(app.config['DATABASE'])
        conn.row_factory = sqlite3.Row
        return conn
    
    # API: 服务状态
    @app.route('/admin/api/service_status', methods=['GET'])
    def api_service_status():
        """获取系统服务状态"""
        try:
            services = []
            
            # 检查各个服务
            service_definitions = [
                {
                    'name': 'hinana-admin',
                    'port': 5001,
                    'description': '管理后台服务',
                    'systemd_service': 'hinana-admin'
                },
                {
                    'name': 'vending-app',
                    'port': 5000,
                    'description': '派样机首页服务',
                    'systemd_service': 'vending-app'
                },
                {
                    'name': 'miniapp-api',
                    'port': 5002,
                    'description': '小程序API服务',
                    'systemd_service': 'miniapp-api'
                },
                {
                    'name': 'nginx',
                    'port': '80/443',
                    'description': 'Web服务器',
                    'systemd_service': 'nginx'
                }
            ]
            
            for service_def in service_definitions:
                service_name = service_def['name']
                service_port = service_def['port']
                
                # 检查systemd服务状态
                try:
                    result = subprocess.run(
                        ['systemctl', 'is-active', service_def['systemd_service']],
                        capture_output=True,
                        text=True,
                        timeout=5
                    )
                    status = result.stdout.strip()
                    
                    if status == 'active':
                        service_status = 'active'
                        # 获取进程信息
                        pid_result = subprocess.run(
                            ['systemctl', 'show', '-p', 'MainPID', '--value', service_def['systemd_service']],
                            capture_output=True,
                            text=True,
                            timeout=3
                        )
                        pid = pid_result.stdout.strip()
                        
                        if pid and pid.isdigit() and int(pid) > 0:
                            try:
                                process = psutil.Process(int(pid))
                                cpu_percent = process.cpu_percent(interval=0.1)
                                memory_info = process.memory_info()
                                memory_mb = memory_info.rss / 1024 / 1024
                                
                                # 获取启动时间
                                create_time = datetime.fromtimestamp(process.create_time())
                                uptime = datetime.now() - create_time
                                
                                uptime_str = format_timedelta(uptime)
                                cpu_str = f"{cpu_percent:.1f}%"
                                mem_str = f"{memory_mb:.1f}MB"
                            except:
                                cpu_str = "N/A"
                                mem_str = "N/A"
                                uptime_str = "N/A"
                        else:
                            cpu_str = "N/A"
                            mem_str = "N/A"
                            uptime_str = "N/A"
                    else:
                        service_status = 'inactive'
                        cpu_str = "0%"
                        mem_str = "0MB"
                        uptime_str = "N/A"
                        
                except Exception as e:
                    service_status = 'failed'
                    cpu_str = "N/A"
                    mem_str = "N/A"
                    uptime_str = "N/A"
                
                services.append({
                    'name': service_name,
                    'description': service_def['description'],
                    'status': service_status,
                    'port': service_port,
                    'cpu': cpu_str,
                    'mem': mem_str,
                    'uptime': uptime_str
                })
            
            # 计算总体状态
            active_count = len([s for s in services if s['status'] == 'active'])
            total_count = len(services)
            health = 'healthy' if active_count == total_count else 'degraded' if active_count > 0 else 'down'
            
            return jsonify({
                'success': True,
                'services': services,
                'overall': {
                    'active': active_count,
                    'total': total_count,
                    'health': health
                },
                'timestamp': datetime.now().isoformat()
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'获取服务状态失败: {str(e)}'
            }), 500
    
    # API: 客户统计数据
    @app.route('/admin/api/customer_stats', methods=['GET'])
    def api_customer_stats_extra():
        """获取客户统计数据"""
        try:
            conn = get_db()
            cursor = conn.cursor()
            
            # 获取客户总数
            cursor.execute("SELECT COUNT(*) FROM customers WHERE status='active'")
            total_customers = cursor.fetchone()[0]
            
            # 获取活跃客户数（最近30天有活动的）
            thirty_days_ago = (datetime.now() - timedelta(days=30)).strftime('%Y-%m-%d')
            cursor.execute("""
                SELECT COUNT(DISTINCT customer_id) 
                FROM user_records 
                WHERE created_at >= ? 
                AND customer_id IS NOT NULL
            """, (thirty_days_ago,))
            active_customers = cursor.fetchone()[0] or 0
            
            # 获取机器总数
            cursor.execute("SELECT COUNT(*) FROM machines")
            total_machines = cursor.fetchone()[0]
            
            # 获取兑换总数
            cursor.execute("SELECT COUNT(*) FROM user_records")
            total_redeems = cursor.fetchone()[0]
            
            # 获取今日兑换数
            today = datetime.now().strftime('%Y-%m-%d')
            cursor.execute("SELECT COUNT(*) FROM user_records WHERE DATE(created_at) = ?", (today,))
            today_redeems = cursor.fetchone()[0] or 0
            
            # 获取7天营收（模拟数据）
            revenue_7d = calculate_7d_revenue(cursor)
            
            conn.close()
            
            return jsonify({
                'success': True,
                'total_customers': total_customers,
                'active_customers': active_customers,
                'total_machines': total_machines,
                'total_redeems': total_redeems,
                'today_redeems': today_redeems,
                'revenue_7d': revenue_7d,
                'updated_at': datetime.now().isoformat()
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'获取客户统计数据失败: {str(e)}'
            }), 500
    
    # API: 硬件状态
    @app.route('/admin/api/hardware_status', methods=['GET'])
    def api_hardware_status():
        """获取硬件状态信息"""
        try:
            # 模拟硬件状态（实际项目中需要与硬件通信）
            hardware_data = {
                'stm32': {
                    'connected': True,
                    'last_seen': (datetime.now() - timedelta(minutes=2)).strftime('%Y-%m-%d %H:%M:%S'),
                    'version': 'v1.0.1',
                    'channels': 50,
                    'temperature': '45°C',
                    'voltage': '5.1V'
                },
                'orange_pi': {
                    'connected': True,
                    'ip': '192.168.1.100',
                    'last_ping': '2秒前',
                    'load': '0.8',
                    'temperature': '65°C',
                    'uptime': '5天12小时'
                },
                'machines': []
            }
            
            # 从数据库获取机器信息
            conn = get_db()
            cursor = conn.cursor()
            
            cursor.execute("SELECT id, name, location, status, created_at FROM machines")
            machines = cursor.fetchall()
            
            for machine in machines:
                machine_id = machine['id']
                machine_name = machine['name']
                
                # 获取该机器的最新兑换记录
                cursor.execute("""
                    SELECT MAX(created_at) as last_redeem 
                    FROM user_records 
                    WHERE machine_id = ?
                """, (machine_id,))
                last_redeem_result = cursor.fetchone()
                last_redeem = last_redeem_result['last_redeem'] if last_redeem_result['last_redeem'] else None
                
                # 模拟库存信息
                stock = 50  # 默认库存为50
                
                # 模拟在线状态（基于最近活动时间）
                if last_redeem:
                    last_redeem_time = datetime.strptime(last_redeem, '%Y-%m-%d %H:%M:%S')
                    hours_since_last = (datetime.now() - last_redeem_time).total_seconds() / 3600
                    status = 'online' if hours_since_last < 24 else 'offline'
                else:
                    status = machine['status'] or 'inactive'
                
                hardware_data['machines'].append({
                    'id': machine_id,
                    'name': machine_name,
                    'location': machine['location'],
                    'status': status,
                    'last_redeem': format_timestamp(last_redeem) if last_redeem else '从未兑换',
                    'stock': stock,
                    'created_at': machine['created_at']
                })
            
            conn.close()
            
            return jsonify({
                'success': True,
                'data': hardware_data,
                'timestamp': datetime.now().isoformat()
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'获取硬件状态失败: {str(e)}'
            }), 500
    
    # API: 系统信息
    @app.route('/admin/api/system_info', methods=['GET'])
    def api_system_info():
        """获取系统信息"""
        try:
            import socket
            
            # 获取主机信息
            hostname = socket.gethostname()
            
            # 获取系统负载
            load_avg = os.getloadavg()
            cpu_load = f"{load_avg[0]:.1f}% (1分钟)"
            
            # 获取内存使用
            mem = psutil.virtual_memory()
            memory_used = f"{mem.used / 1024 / 1024 / 1024:.1f}GB / {mem.total / 1024 / 1024 / 1024:.1f}GB ({mem.percent}%)"
            
            # 获取磁盘使用
            disk = psutil.disk_usage('/')
            disk_used = f"{disk.used / 1024 / 1024 / 1024:.1f}GB / {disk.total / 1024 / 1024 / 1024:.1f}GB ({disk.percent}%)"
            
            # 获取系统运行时间
            boot_time = psutil.boot_time()
            uptime_seconds = time.time() - boot_time
            uptime = format_timedelta(timedelta(seconds=uptime_seconds))
            
            # 获取最后备份时间（如果有备份目录）
            last_backup = '从未备份'
            backup_dir = '/opt/hinana-backups'
            if os.path.exists(backup_dir):
                try:
                    backup_files = [f for f in os.listdir(backup_dir) if f.endswith('.tar.gz')]
                    if backup_files:
                        backup_files.sort(reverse=True)
                        last_backup = backup_files[0].replace('hinana-backup-', '').replace('.tar.gz', '')
                except:
                    pass
            
            system_info = {
                'server': '150.158.20.232',
                'domain': 'cdgush.com',
                'hostname': hostname,
                'os': get_os_info(),
                'cpu_load': cpu_load,
                'memory_used': memory_used,
                'disk_used': disk_used,
                'uptime': uptime,
                'last_backup': last_backup,
                'python_version': f"{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}",
                'current_time': datetime.now().isoformat()
            }
            
            return jsonify({
                'success': True,
                'system_info': system_info,
                'timestamp': datetime.now().isoformat()
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'获取系统信息失败: {str(e)}'
            }), 500
    
    # API: 最近活动
    @app.route('/admin/api/recent_activities', methods=['GET'])
    def api_recent_activities():
        """获取最近活动记录"""
        try:
            conn = get_db()
            cursor = conn.cursor()
            
            # 获取最近的活动记录（包括兑换、登录、操作等）
            activities = []
            
            # 获取最近的兑换记录
            cursor.execute("""
                SELECT ur.id, ur.phone, ur.code, ur.machine_id, ur.created_at,
                       c.name as customer_name, m.name as machine_name
                FROM user_records ur
                LEFT JOIN customers c ON ur.customer_id = c.id
                LEFT JOIN machines m ON ur.machine_id = m.id
                ORDER BY ur.created_at DESC
                LIMIT 10
            """)
            
            redeem_records = cursor.fetchall()
            for record in redeem_records:
                activities.append({
                    'id': record['id'],
                    'type': 'redeem',
                    'user': record['phone'] or '匿名用户',
                    'machine': record['machine_name'] or f"机器#{record['machine_id']}",
                    'time': format_timestamp(record['created_at']),
                    'details': f"兑换码: {record['code']}",
                    'customer': record['customer_name']
                })
            
            # 如果有客户登录记录表，可以添加登录活动
            # cursor.execute("SELECT * FROM login_logs ORDER BY login_time DESC LIMIT 5")
            
            conn.close()
            
            # 添加系统级别的活动
            system_activities = [
                {
                    'id': len(activities) + 1,
                    'type': 'system',
                    'user': '管理员',
                    'machine': '服务器',
                    'time': format_timestamp(datetime.now() - timedelta(hours=2)),
                    'details': '系统检查完成'
                },
                {
                    'id': len(activities) + 2,
                    'type': 'backup',
                    'user': '自动任务',
                    'machine': '备份服务',
                    'time': format_timestamp(datetime.now() - timedelta(days=1)),
                    'details': '系统备份成功'
                }
            ]
            
            activities.extend(system_activities)
            activities.sort(key=lambda x: datetime.strptime(x['time'], '%Y-%m-%d %H:%M:%S') if x['time'] != '刚刚' else datetime.now(), reverse=True)
            
            return jsonify({
                'success': True,
                'activities': activities[:10],  # 只返回最新的10条
                'count': len(activities),
                'updated_at': datetime.now().isoformat()
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'获取最近活动失败: {str(e)}'
            }), 500
    
    # API: 重启服务
    @app.route('/admin/api/restart_service', methods=['POST'])
    def api_restart_service():
        """重启指定服务"""
        try:
            data = request.get_json()
            service_name = data.get('service')
            
            if not service_name:
                return jsonify({
                    'success': False,
                    'message': '请指定要重启的服务名称'
                }), 400
            
            # 检查服务是否存在
            valid_services = ['hinana-admin', 'vending-app', 'miniapp-api']
            if service_name not in valid_services:
                return jsonify({
                    'success': False,
                    'message': f'无效的服务名称: {service_name}. 有效服务: {", ".join(valid_services)}'
                }), 400
            
            # 执行重启命令
            try:
                result = subprocess.run(
                    ['systemctl', 'restart', service_name],
                    capture_output=True,
                    text=True,
                    timeout=30
                )
                
                if result.returncode == 0:
                    return jsonify({
                        'success': True,
                        'message': f'{service_name} 服务重启成功',
                        'output': result.stdout
                    })
                else:
                    return jsonify({
                        'success': False,
                        'message': f'{service_name} 服务重启失败',
                        'error': result.stderr
                    })
                    
            except subprocess.TimeoutExpired:
                return jsonify({
                    'success': False,
                    'message': f'{service_name} 服务重启超时'
                }), 408
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'重启服务失败: {str(e)}'
            }), 500
    
    # API: 重启所有服务
    @app.route('/admin/api/restart_all', methods=['POST'])
    def api_restart_all():
        """重启所有HI拿相关服务"""
        try:
            services = ['miniapp-api', 'vending-app', 'hinana-admin']
            results = []
            
            for service in services:
                try:
                    result = subprocess.run(
                        ['systemctl', 'restart', service],
                        capture_output=True,
                        text=True,
                        timeout=10
                    )
                    
                    results.append({
                        'service': service,
                        'success': result.returncode == 0,
                        'output': result.stdout,
                        'error': result.stderr
                    })
                    
                    # 短暂延迟，避免同时重启
                    time.sleep(2)
                    
                except Exception as e:
                    results.append({
                        'service': service,
                        'success': False,
                        'error': str(e)
                    })
            
            success_count = len([r for r in results if r['success']])
            total_count = len(results)
            
            return jsonify({
                'success': success_count == total_count,
                'message': f'成功重启 {success_count}/{total_count} 个服务',
                'results': results,
                'timestamp': datetime.now().isoformat()
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'重启所有服务失败: {str(e)}'
            }), 500
    
    # API: 测试硬件连接
    @app.route('/admin/api/test_hardware', methods=['GET'])
    def api_test_hardware():
        """测试硬件连接"""
        try:
            # 检查Orange Pi连接状态（通过ping）
            orange_pi_ip = '192.168.1.100'  # 需要根据实际配置修改
            
            try:
                ping_result = subprocess.run(
                    ['ping', '-c', '1', '-W', '2', orange_pi_ip],
                    capture_output=True,
                    text=True,
                    timeout=5
                )
                
                orange_pi_status = 'connected' if ping_result.returncode == 0 else 'disconnected'
                
            except:
                orange_pi_status = 'timeout'
            
            # 模拟STM32连接检查
            stm32_status = 'connected'  # 实际项目中需要实现串口通信检查
            
            return jsonify({
                'success': True,
                'message': f'硬件连接测试完成',
                'orange_pi': orange_pi_status,
                'stm32': stm32_status,
                'test_time': datetime.now().isoformat()
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'硬件连接测试失败: {str(e)}'
            }), 500
    
    # API: 生成兑换码
    @app.route('/admin/api/generate_codes', methods=['POST'])
    def api_generate_codes():
        """批量生成兑换码"""
        try:
            data = request.get_json()
            count = int(data.get('count', 10))
            
            if count < 1 or count > 1000:
                return jsonify({
                    'success': False,
                    'message': '兑换码数量必须在1-1000之间'
                }), 400
            
            import random
            import string
            
            conn = get_db()
            cursor = conn.cursor()
            
            codes_generated = 0
            for i in range(count):
                # 生成6位随机数字兑换码
                code = ''.join(random.choices(string.digits, k=6))
                
                # 生成失效时间（默认60秒后）
                expires_at = datetime.now() + timedelta(seconds=60)
                
                try:
                    cursor.execute("""
                        INSERT INTO redeem_codes (code, expires_at, status, created_at)
                        VALUES (?, ?, 'active', ?)
                    """, (code, expires_at.strftime('%Y-%m-%d %H:%M:%S'), datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
                    
                    codes_generated += 1
                except sqlite3.IntegrityError:
                    # 代码已存在，跳过
                    continue
            
            conn.commit()
            conn.close()
            
            return jsonify({
                'success': True,
                'message': f'成功生成 {codes_generated} 个兑换码',
                'count': codes_generated,
                'generated_at': datetime.now().isoformat()
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'生成兑换码失败: {str(e)}'
            }), 500
    
    # API: 导出兑换码
    @app.route('/admin/api/export_codes', methods=['GET'])
    def api_export_codes():
        """导出兑换码为CSV文件"""
        try:
            conn = get_db()
            cursor = conn.cursor()
            
            cursor.execute("""
                SELECT code, expires_at, status, created_at 
                FROM redeem_codes 
                WHERE status='active'
                ORDER BY created_at DESC
                LIMIT 100
            """)
            
            codes = cursor.fetchall()
            conn.close()
            
            # 生成CSV内容
            csv_content = "兑换码,失效时间,状态,创建时间\n"
            for code in codes:
                csv_content += f"{code['code']},{code['expires_at']},{code['status']},{code['created_at']}\n"
            
            from flask import Response
            return Response(
                csv_content,
                mimetype="text/csv",
                headers={
                    "Content-disposition": f"attachment; filename=redeem_codes_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
                }
            )
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'导出兑换码失败: {str(e)}'
            }), 500
    
    # API: 系统备份
    # API: 获取兑换码列表
    @app.route("/admin/api/codes", methods=["GET"])
    def api_get_codes():
        """获取兑换码列表"""
        try:
            from flask import request, jsonify
            import sqlite3
            conn = sqlite3.connect("instance/hinana.db")
            conn.row_factory = sqlite3.Row
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM redeem_codes ORDER BY created_at DESC LIMIT 50")
            rows = cursor.fetchall()
            codes = [dict(row) for row in rows]
            conn.close()
            return jsonify({"success": True, "data": codes})
        except Exception as e:
            return jsonify({"success": False, "message": str(e)}), 500

    @app.route("/admin/api/codes/delete", methods=["POST"])
    def api_delete_codes():
        """删除兑换码"""
        try:
            from flask import request, jsonify
            import sqlite3
            data = request.get_json()
            phone_numbers = data.get("phone_numbers") if data else None
            
            if not phone_numbers or not isinstance(phone_numbers, list):
                return jsonify({"success": False, "message": "缺少手机号参数或参数格式不正确"}), 400
            
            conn = sqlite3.connect("instance/hinana.db")
            cursor = conn.cursor()
            
            # 批量删除兑换码
            count = 0
            for phone in phone_numbers:
                cursor.execute("DELETE FROM redeem_codes WHERE user_phone = ?", (phone,))
                count += cursor.rowcount
            
            conn.commit()
            conn.close()
            return jsonify({"success": True, "message": f"删除成功，共删除{count}条记录"})
        except Exception as e:
            return jsonify({"success": False, "message": str(e)}), 500
    def api_backup():
        """执行系统备份"""
        try:
            # 创建备份目录
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            backup_dir = f'/opt/hinana-backup-{timestamp}'
            
            os.makedirs(backup_dir, exist_ok=True)
            
            # 备份数据库
            db_path = app.config['DATABASE']
            if os.path.exists(db_path):
                import shutil
                shutil.copy2(db_path, os.path.join(backup_dir, 'hinana.db'))
            
            # 备份配置文件
            config_files = [
                '/opt/hinana-admin/api.py',
                '/opt/hinana-admin/app.py',
                '/opt/hinana-admin/requirements.txt',
                '/www/server/panel/vhost/nginx/cdgushai.com.conf'
            ]
            
            for config_file in config_files:
                if os.path.exists(config_file):
                    try:
                        shutil.copy2(config_file, os.path.join(backup_dir, os.path.basename(config_file)))
                    except:
                        pass
            
            # 备份模板文件
            templates_dir = '/opt/hinana-admin/templates'
            if os.path.exists(templates_dir):
                tar_file = os.path.join(backup_dir, 'templates.tar.gz')
                subprocess.run(['tar', '-czf', tar_file, '-C', templates_dir, '.'], check=True)
            
            # 创建备份信息文件
            backup_info = {
                'backup_time': datetime.now().isoformat(),
                'backup_dir': backup_dir,
                'files_backed_up': len([f for f in os.listdir(backup_dir) if os.path.isfile(os.path.join(backup_dir, f))]),
                'system_version': '1.0.0',
                'notes': '自动备份'
            }
            
            with open(os.path.join(backup_dir, 'backup_info.json'), 'w') as f:
                json.dump(backup_info, f, indent=2)
            
            # 创建压缩包
            tar_file = f'/opt/hinana-backup-{timestamp}.tar.gz'
            subprocess.run(['tar', '-czf', tar_file, '-C', backup_dir, '.'], check=True)
            
            # 清理原始备份目录
            shutil.rmtree(backup_dir)
            
            return jsonify({
                'success': True,
                'message': '系统备份成功',
                'backup_path': tar_file,
                'backup_time': datetime.now().isoformat(),
                'backup_size': f"{os.path.getsize(tar_file) / 1024 / 1024:.2f} MB"
            })
            
        except Exception as e:
            return jsonify({
                'success': False,
                'message': f'系统备份失败: {str(e)}'
            }), 500
    
    # API: 服务日志
    @app.route('/admin/api/logs/<service_name>', methods=['GET'])
    def api_logs(service_name):
        """获取服务日志"""
        try:
            # 服务日志路径映射
            log_paths = {
                'hinana-admin': '/var/log/hinana-admin.log',
                'vending-app': '/var/log/vending-app.log',
                'miniapp-api': '/var/log/miniapp-api.log',
                'nginx': '/var/log/nginx/error.log',
                'system': '/var/log/syslog'
            }
            
            log_path = log_paths.get(service_name)
            if not log_path or not os.path.exists(log_path):
                return f"服务 {service_name} 的日志文件不存在", 404
            
            # 读取日志文件最后1000行
            with open(log_path, 'r') as f:
                lines = f.readlines()
                recent_lines = lines[-1000:] if len(lines) > 1000 else lines
                return "".join(recent_lines)
            
        except Exception as e:
            return f"读取日志失败: {str(e)}", 500
    
    print("中控台API路由注册完成")
    return app

# 辅助函数
import sys

def get_os_info():
    """获取操作系统信息"""
    try:
        with open('/etc/os-release') as f:
            lines = f.readlines()
            for line in lines:
                if line.startswith('PRETTY_NAME='):
                    return line.split('=')[1].strip().strip('"')
    except:
        pass
    return 'Linux'

def format_timedelta(td):
    """格式化时间差为可读字符串"""
    if not td:
        return "N/A"
    
    total_seconds = int(td.total_seconds())
    days, remainder = divmod(total_seconds, 86400)
    hours, remainder = divmod(remainder, 3600)
    minutes, seconds = divmod(remainder, 60)
    
    parts = []
    if days > 0:
        parts.append(f"{days}天")
    if hours > 0:
        parts.append(f"{hours}小时")
    if minutes > 0 and days == 0:  # 如果天数>0，不显示分钟
        parts.append(f"{minutes}分钟")
    if seconds > 0 and days == 0 and hours == 0:
        parts.append(f"{seconds}秒")
    
    return "".join(parts) if parts else "0秒"

def format_timestamp(timestamp_str):
    """格式化时间戳为相对时间"""
    if not timestamp_str:
        return "从未"
    
    try:
        if isinstance(timestamp_str, str):
            timestamp = datetime.strptime(timestamp_str, '%Y-%m-%d %H:%M:%S')
        else:
            timestamp = timestamp_str
        
        now = datetime.now()
        diff = now - timestamp
        
        if diff.total_seconds() < 60:
            return "刚刚"
        elif diff.total_seconds() < 3600:
            minutes = int(diff.total_seconds() / 60)
            return f"{minutes}分钟前"
        elif diff.total_seconds() < 86400:
            hours = int(diff.total_seconds() / 3600)
            return f"{hours}小时前"
        elif diff.days < 30:
            return f"{diff.days}天前"
        else:
            return timestamp.strftime('%Y-%m-%d %H:%M')
    except:
        return timestamp_str

def calculate_7d_revenue(cursor):
    """计算7天营收（模拟）"""
    try:
        # 这里可以根据实际业务逻辑计算营收
        # 模拟数据：7天营收约356.8元
        return 356.80
    except:
        return 0.00