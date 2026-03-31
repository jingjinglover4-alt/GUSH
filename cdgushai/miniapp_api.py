#!/usr/bin/env python3
"""
HI拿智能派样 - 小程序 API 服务
端口: 5002
数据库: SQLite (/opt/hinana-admin/instance/hinana.db)
"""
from flask import Flask, request, jsonify
from flask_cors import CORS
import random
import string
import time
import sqlite3
from datetime import datetime, timedelta
import os
import traceback

app = Flask(__name__)
CORS(app)

# 数据库路径
DB_PATH = '/opt/hinana-admin/instance/hinana.db'

# 默认兑换码有效期（秒）
DEFAULT_CODE_EXPIRE_SECONDS = 60


def get_db():
    """获取SQLite连接"""
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def init_miniapp_tables():
    """初始化小程序专用表（扩展字段）"""
    conn = get_db()
    try:
        cursor = conn.cursor()

        # 为 redeem_codes 表添加 user_name / user_phone 字段（如果不存在）
        existing_cols = [row[1] for row in cursor.execute("PRAGMA table_info(redeem_codes)")]

        if 'user_name' not in existing_cols:
            cursor.execute("ALTER TABLE redeem_codes ADD COLUMN user_name VARCHAR(50) DEFAULT ''")
        if 'user_phone' not in existing_cols:
            cursor.execute("ALTER TABLE redeem_codes ADD COLUMN user_phone VARCHAR(20) DEFAULT ''")

        conn.commit()
        print("[init] 数据库扩展字段检查完成")
    except Exception as e:
        print(f"[init] 初始化失败: {e}")
    finally:
        conn.close()


def generate_unique_code(customer_id, code_length=6):
    """生成唯一兑换码"""
    conn = get_db()
    try:
        for _ in range(20):
            code = ''.join(random.choices(string.digits, k=code_length))
            cursor = conn.cursor()
            cursor.execute(
                "SELECT id FROM redeem_codes WHERE code = ? AND status = 'active'",
                (code,)
            )
            if not cursor.fetchone():
                return code
        # fallback：时间戳后6位
        return str(int(time.time()))[-code_length:]
    finally:
        conn.close()


def get_customer_config(customer_id=1):
    """获取客户配置"""
    conn = get_db()
    try:
        cursor = conn.cursor()
        cursor.execute(
            "SELECT id, name, code_expire_seconds, code_length, status FROM customers WHERE id = ?",
            (customer_id,)
        )
        return cursor.fetchone()
    finally:
        conn.close()


def check_phone_claimed_today(phone, customer_id=1):
    """检查手机号今天是否已领取"""
    conn = get_db()
    try:
        cursor = conn.cursor()
        today_str = datetime.now().strftime('%Y-%m-%d')
        cursor.execute(
            """SELECT id FROM redeem_codes
               WHERE user_phone = ? AND customer_id = ?
               AND DATE(created_at) = ?""",
            (phone, customer_id, today_str)
        )
        return cursor.fetchone() is not None
    finally:
        conn.close()


# ─────────────────────────────────────────────────────────
#  API 路由
# ─────────────────────────────────────────────────────────

@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({
        'code': 200,
        'message': 'success',
        'data': {
            'service': 'hinana-miniapp-api',
            'status': 'ok',
            'timestamp': int(time.time())
        }
    })


@app.route('/api/generate_code', methods=['POST'])
def generate_code():
    """
    生成兑换码
    请求体: { "name": "张三", "phone": "138xxxx", "machine_id": "M001", "customer_id": 1 }
    """
    try:
        data = request.get_json() or {}
        name = str(data.get('name', '')).strip()
        phone = str(data.get('phone', '')).strip()
        machine_id_str = str(data.get('machine_id', '')).strip()
        customer_id = int(data.get('customer_id', 1))

        # 参数验证
        if not name:
            return jsonify({'code': 400, 'message': '请输入姓名', 'data': None})
        if not phone or len(phone) != 11 or not phone.isdigit():
            return jsonify({'code': 400, 'message': '请输入正确的手机号', 'data': None})

        # 获取客户配置
        customer = get_customer_config(customer_id)
        if not customer or customer['status'] != 'active':
            customer_id = 1  # fallback
            customer = get_customer_config(1)

        expire_seconds = (customer['code_expire_seconds'] or DEFAULT_CODE_EXPIRE_SECONDS) if customer else DEFAULT_CODE_EXPIRE_SECONDS
        code_length = (customer['code_length'] or 6) if customer else 6

        # 检查今日是否已领取
        if check_phone_claimed_today(phone, customer_id):
            return jsonify({'code': 400, 'message': '今日已领取过，请明天再来', 'data': None})

        # 查找机器ID（数字主键）
        conn = get_db()
        machine_db_id = None
        try:
            if machine_id_str:
                cursor = conn.cursor()
                # 先按 machine_code 查
                cursor.execute("SELECT id FROM machines WHERE machine_code = ?", (machine_id_str,))
                row = cursor.fetchone()
                if row:
                    machine_db_id = row['id']
        except Exception:
            pass
        finally:
            conn.close()

        # 生成兑换码
        code = generate_unique_code(customer_id, code_length)
        now = datetime.now()
        expire_time = now + timedelta(seconds=expire_seconds)

        # 写入数据库
        conn = get_db()
        try:
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO redeem_codes
                  (code, openid, machine_id, customer_id, status, created_at, expired_at,
                   user_name, user_phone)
                VALUES (?, ?, ?, ?, 'active', ?, ?, ?, ?)
            """, (
                code,
                f'phone_{phone}',  # openid 用手机号代替（小程序需要真实openid时再改）
                machine_db_id,
                customer_id,
                now.strftime('%Y-%m-%d %H:%M:%S'),
                expire_time.strftime('%Y-%m-%d %H:%M:%S'),
                name,
                phone
            ))
            conn.commit()

            # 更新今日统计数据（claim_count）
            today = now.date()
            cursor.execute(
                "SELECT id, claim_count FROM stats WHERE customer_id = ? AND date = ?",
                (customer_id, today.strftime('%Y-%m-%d'))
            )
            row = cursor.fetchone()
            if row:
                # 更新现有记录
                cursor.execute(
                    "UPDATE stats SET claim_count = claim_count + 1 WHERE id = ?",
                    (row['id'],)
                )
            else:
                # 创建新记录
                cursor.execute(
                    "INSERT INTO stats (customer_id, date, scan_count, claim_count, redeem_count, created_at) VALUES (?, ?, 0, 1, 0, ?)",
                    (customer_id, today.strftime('%Y-%m-%d'), now.strftime('%Y-%m-%d %H:%M:%S'))
                )
            conn.commit()

            return jsonify({
                'code': 200,
                'message': 'success',
                'data': {
                    'code': code,
                    'expire_seconds': expire_seconds,
                    'expire_time': expire_time.strftime('%Y-%m-%d %H:%M:%S')
                }
            })
        finally:
            conn.close()

    except Exception as e:
        traceback.print_exc()
        return jsonify({'code': 500, 'message': '服务器繁忙，请稍后重试', 'data': None})


@app.route('/api/redeem_code', methods=['POST'])
def redeem_code():
    """
    核销兑换码（供机器端调用）
    请求体: { "code": "123456", "machine_id": "M001" }
    """
    try:
        data = request.get_json() or {}
        code = str(data.get('code', '')).strip()
        machine_id_str = str(data.get('machine_id', '')).strip()

        if not code or len(code) < 4:
            return jsonify({'code': 400, 'message': '请输入正确的兑换码', 'data': None})

        conn = get_db()
        try:
            cursor = conn.cursor()
            cursor.execute(
                "SELECT * FROM redeem_codes WHERE code = ?",
                (code,)
            )
            record = cursor.fetchone()

            if not record:
                return jsonify({'code': 404, 'message': '兑换码不存在', 'data': None})

            if record['status'] == 'used':
                return jsonify({'code': 400, 'message': '兑换码已被使用', 'data': None})

            if record['status'] == 'expired':
                return jsonify({'code': 400, 'message': '兑换码已过期', 'data': None})

            # 检查是否过期
            expire_time = datetime.strptime(record['expired_at'], '%Y-%m-%d %H:%M:%S')
            if datetime.now() > expire_time:
                cursor.execute("UPDATE redeem_codes SET status = 'expired' WHERE code = ?", (code,))
                conn.commit()
                return jsonify({'code': 400, 'message': '兑换码已过期', 'data': None})

            # 核销
            cursor.execute("""
                UPDATE redeem_codes
                SET status = 'used', used_at = ?
                WHERE code = ?
            """, (datetime.now().strftime('%Y-%m-%d %H:%M:%S'), code))
            conn.commit()

            user_name = record['user_name'] if 'user_name' in record.keys() else '用户'

            return jsonify({
                'code': 200,
                'message': '核销成功',
                'data': {
                    'user_name': user_name,
                    'redeemed_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                }
            })
        finally:
            conn.close()

    except Exception as e:
        traceback.print_exc()
        return jsonify({'code': 500, 'message': '服务器繁忙', 'data': None})


@app.route('/api/check_code', methods=['POST'])
def check_code():
    """检查兑换码状态"""
    try:
        data = request.get_json() or {}
        code = str(data.get('code', '')).strip()

        if not code:
            return jsonify({'code': 400, 'message': '请提供兑换码', 'data': None})

        conn = get_db()
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM redeem_codes WHERE code = ?", (code,))
            record = cursor.fetchone()

            if not record:
                return jsonify({'code': 404, 'message': '兑换码不存在', 'data': None})

            status = record['status']
            remain_seconds = 0

            if status == 'active':
                expire_time = datetime.strptime(record['expired_at'], '%Y-%m-%d %H:%M:%S')
                now = datetime.now()
                if now > expire_time:
                    cursor.execute("UPDATE redeem_codes SET status = 'expired' WHERE code = ?", (code,))
                    conn.commit()
                    status = 'expired'
                else:
                    remain_seconds = max(0, int((expire_time - now).total_seconds()))

            return jsonify({
                'code': 200,
                'message': 'success',
                'data': {
                    'code': record['code'],
                    'status': status,
                    'remain_seconds': remain_seconds,
                    'used_at': record['used_at']
                }
            })
        finally:
            conn.close()

    except Exception as e:
        traceback.print_exc()
        return jsonify({'code': 500, 'message': '服务器繁忙', 'data': None})


@app.route('/api/machine_info', methods=['POST'])
def machine_info():
    """获取机器信息"""
    try:
        data = request.get_json() or {}
        machine_code = str(data.get('machine_id', '')).strip()

        conn = get_db()
        try:
            cursor = conn.cursor()
            if machine_code:
                cursor.execute(
                    "SELECT * FROM machines WHERE machine_code = ?",
                    (machine_code,)
                )
                record = cursor.fetchone()
            else:
                record = None

            if not record:
                return jsonify({
                    'code': 200,
                    'message': 'success',
                    'data': {
                        'machine_id': machine_code or 'default',
                        'machine_name': '派样机',
                        'location': '未知位置',
                        'status': 'online',
                        'stock': 100
                    }
                })

            return jsonify({
                'code': 200,
                'message': 'success',
                'data': {
                    'machine_id': record['machine_code'],
                    'machine_name': record['name'] or '派样机',
                    'location': record['location'] or '未知位置',
                    'status': record['status'] or 'online'
                }
            })
        finally:
            conn.close()

    except Exception as e:
        traceback.print_exc()
        return jsonify({'code': 500, 'message': '服务器繁忙', 'data': None})


# 测试用密码
TEST_PASSWORD = 'hinana2026'


@app.route('/api/clear_test_data', methods=['POST'])
def clear_test_data():
    """
    清理测试数据（仅供测试使用）
    请求体: { "password": "hinana2026", "phone": "13800138000" }  # phone可选，不传则清空所有
    """
    try:
        data = request.get_json() or {}
        password = str(data.get('password', '')).strip()
        phone = str(data.get('phone', '')).strip()

        # 验证密码
        if password != TEST_PASSWORD:
            return jsonify({'code': 401, 'message': '密码错误', 'data': None})

        conn = get_db()
        try:
            cursor = conn.cursor()
            if phone:
                # 只删除指定手机号的记录
                cursor.execute(
                    "DELETE FROM redeem_codes WHERE user_phone = ?",
                    (phone,)
                )
                deleted = cursor.rowcount
                conn.commit()
                return jsonify({
                    'code': 200,
                    'message': f'已删除手机号 {phone} 的 {deleted} 条记录',
                    'data': {'deleted': deleted}
                })
            else:
                # 清空所有记录
                cursor.execute("SELECT COUNT(*) FROM redeem_codes")
                total = cursor.fetchone()[0]
                cursor.execute("DELETE FROM redeem_codes")
                conn.commit()
                return jsonify({
                    'code': 200,
                    'message': f'已清空所有 {total} 条记录',
                    'data': {'deleted': total}
                })
        finally:
            conn.close()

    except Exception as e:
        traceback.print_exc()
        return jsonify({'code': 500, 'message': '服务器繁忙', 'data': None})


@app.route('/api/record_scan', methods=['POST'])
def record_scan():
    """
    记录扫码事件（H5页面加载时调用）
    请求体: { "customer_id": 1, "machine_id": "M001" }  # customer_id 可选，默认1
    """
    try:
        data = request.get_json() or {}
        customer_id = int(data.get('customer_id', 1))
        machine_id_str = str(data.get('machine_id', '')).strip()
        
        conn = get_db()
        try:
            cursor = conn.cursor()
            now = datetime.now()
            today = now.date()
            
            # 更新今日统计数据（scan_count）
            cursor.execute(
                "SELECT id, scan_count FROM stats WHERE customer_id = ? AND date = ?",
                (customer_id, today.strftime('%Y-%m-%d'))
            )
            row = cursor.fetchone()
            if row:
                # 更新现有记录
                cursor.execute(
                    "UPDATE stats SET scan_count = scan_count + 1 WHERE id = ?",
                    (row['id'],)
                )
            else:
                # 创建新记录
                cursor.execute(
                    "INSERT INTO stats (customer_id, date, scan_count, claim_count, redeem_count, created_at) VALUES (?, ?, 1, 0, 0, ?)",
                    (customer_id, today.strftime('%Y-%m-%d'), now.strftime('%Y-%m-%d %H:%M:%S'))
                )
            conn.commit()
            
            return jsonify({
                'code': 200,
                'message': '扫码记录成功',
                'data': {'recorded_at': now.strftime('%Y-%m-%d %H:%M:%S')}
            })
        finally:
            conn.close()
            
    except Exception as e:
        traceback.print_exc()
        return jsonify({'code': 500, 'message': '服务器繁忙', 'data': None})


if __name__ == '__main__':
    init_miniapp_tables()
    port = int(os.environ.get('PORT', 5002))
    app.run(host='0.0.0.0', port=port, debug=False)
