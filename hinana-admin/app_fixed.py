# -*- coding: utf-8 -*-
"""
HI拿智能派样SaaS管理系统 - Flask后端
"""
from flask import Flask, render_template, request, jsonify, session, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, timedelta
import hashlib
import random
import string
import os

app = Flask(__name__, static_url_path='/admin/static')
app.config['SECRET_KEY'] = 'hinana-secret-key-2026'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///hinana.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# 路由前缀
ADMIN_PREFIX = '/admin'

# ==================== 数据库模型 ====================

class Admin(db.Model):
    """管理员账号"""
    __tablename__ = 'admins'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)
    role = db.Column(db.String(20), default='admin')  # admin, customer
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.now)

    def set_password(self, password):
        self.password_hash = hashlib.sha256(password.encode()).hexdigest()

    def check_password(self, password):
        return self.password_hash == hashlib.sha256(password.encode()).hexdigest()


class Customer(db.Model):
    """客户配置"""
    __tablename__ = 'customers'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)  # 客户名称
    logo_url = db.Column(db.String(255))  # Logo URL
    bg_image_url = db.Column(db.String(255))  # 背景图URL
    qrcode_url = db.Column(db.String(255))  # 二维码URL
    slogan = db.Column(db.String(200))  # 广告语
    app_name = db.Column(db.String(50))  # 应用名称

    # 微信公众号配置
    wx_appid = db.Column(db.String(100))  # 公众号AppID
    wx_appsecret = db.Column(db.String(100))  # 公众号AppSecret

    # 小程序配置
    mp_appid = db.Column(db.String(100))  # 小程序AppID
    mp_appsecret = db.Column(db.String(100))  # 小程序AppSecret

    # 企业微信配置
    ww_corpid = db.Column(db.String(100))  # 企业ID
    ww_agentid = db.Column(db.String(50))  # 应用AgentID
    ww_secret = db.Column(db.String(100))  # 应用Secret

    # 兑换码配置
    code_expire_seconds = db.Column(db.Integer, default=60)  # 有效期(秒)
    code_length = db.Column(db.Integer, default=6)  # 码长度

    status = db.Column(db.String(20), default='active')  # active, frozen
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)

    admins = db.relationship('Admin', backref='customer', lazy=True)
    redeem_codes = db.relationship('RedeemCode', backref='customer', lazy=True)
    user_records = db.relationship('UserRecord', backref='customer', lazy=True)
    machines = db.relationship('Machine', backref='customer', lazy=True)


class RedeemCode(db.Model):
    """兑换码"""
    __tablename__ = 'redeem_codes'
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(10), unique=True, nullable=False, index=True)
    openid = db.Column(db.String(100), index=True)  # 微信用户ID
    machine_id = db.Column(db.Integer, db.ForeignKey('machines.id'), nullable=True)
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=False)
    status = db.Column(db.String(20), default='pending')  # pending, used, expired
    created_at = db.Column(db.DateTime, default=datetime.now)
    expired_at = db.Column(db.DateTime)  # 过期时间
    used_at = db.Column(db.DateTime)  # 使用时间
    used_machine_id = db.Column(db.Integer)  # 使用时的机器ID


class UserRecord(db.Model):
    """用户领取记录"""
    __tablename__ = 'user_records'
    id = db.Column(db.Integer, primary_key=True)
    openid = db.Column(db.String(100), nullable=False, index=True)
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=False)
    nickname = db.Column(db.String(100))  # 用户昵称
    phone = db.Column(db.String(20))  # 手机号
    claim_count = db.Column(db.Integer, default=0)  # 领取次数
    last_claim_at = db.Column(db.DateTime)  # 最后领取时间
    first_claim_at = db.Column(db.DateTime)  # 首次领取时间
    can_claim = db.Column(db.Boolean, default=True)  # 是否可领取
    created_at = db.Column(db.DateTime, default=datetime.now)


class Machine(db.Model):
    """机器管理"""
    __tablename__ = 'machines'
    id = db.Column(db.Integer, primary_key=True)
    machine_code = db.Column(db.String(50), unique=True, nullable=False)  # 机器编号
    name = db.Column(db.String(100))  # 机器名称
    location = db.Column(db.String(200))  # 位置
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=False)
    status = db.Column(db.String(20), default='online')  # online, offline
    last_heartbeat = db.Column(db.DateTime)  # 最后心跳时间
    created_at = db.Column(db.DateTime, default=datetime.now)


class Stats(db.Model):
    """数据统计"""
    __tablename__ = 'stats'
    id = db.Column(db.Integer, primary_key=True)
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=False)
    date = db.Column(db.Date, nullable=False)
    scan_count = db.Column(db.Integer, default=0)  # 扫码次数
    claim_count = db.Column(db.Integer, default=0)  # 领取次数
    redeem_count = db.Column(db.Integer, default=0)  # 核销次数
    created_at = db.Column(db.DateTime, default=datetime.now)


# ==================== 辅助函数 ====================

def generate_code(length=6):
    """生成随机码"""
    return ''.join(random.choices(string.digits, k=length))


def init_db():
    """初始化数据库"""
    with app.app_context():
        db.create_all()
        # 创建默认管理员
        if not Admin.query.filter_by(username='admin').first():
            admin = Admin(username='admin', role='admin')
            admin.set_password('123456')
            db.session.add(admin)
            db.session.commit()
            print("默认管理员已创建: admin / 123456")

        # 创建默认客户
        if not Customer.query.first():
            customer = Customer(
                name='高效传媒',
                app_name='HI拿',
                slogan='智能派样 · 精准触达 · 品效合一',
                code_expire_seconds=60,
                code_length=6
            )
            db.session.add(customer)
            db.session.commit()
            print("默认客户已创建: 高效传媒")


# ==================== 页面路由 ====================

@app.route(f'{ADMIN_PREFIX}/')
def index():
    """首页/登录页"""
    if 'admin_id' in session:
        return redirect(url_for('dashboard'))
    return render_template('login.html')


@app.route(f'{ADMIN_PREFIX}/login', methods=['POST'])
def login():
    """登录处理"""
    data = request.get_json()
    username = data.get('username', '').strip()
    password = data.get('password', '')

    admin = Admin.query.filter_by(username=username).first()

    if admin and admin.check_password(password):
        session['admin_id'] = admin.id
        session['admin_name'] = admin.username
        session['customer_id'] = admin.customer_id
        session['role'] = admin.role
        return jsonify({'success': True, 'message': '登录成功'})

    return jsonify({'success': False, 'message': '用户名或密码错误'})


@app.route(f'{ADMIN_PREFIX}/logout')
def logout():
    """登出"""
    session.clear()
    return redirect(url_for('index'))


@app.route(f'{ADMIN_PREFIX}/dashboard')
def dashboard():
    """仪表盘"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))

    customer_id = session.get('customer_id')

    # 获取统计数据
    today = datetime.now().date()

    if customer_id:
        # 客户视图
        total_codes = RedeemCode.query.filter_by(customer_id=customer_id).count()
        used_codes = RedeemCode.query.filter_by(customer_id=customer_id, status='used').count()
        total_users = UserRecord.query.filter_by(customer_id=customer_id).count()
        active_machines = Machine.query.filter_by(customer_id=customer_id, status='online').count()

        # 今日数据
        today_stats = Stats.query.filter_by(customer_id=customer_id, date=today).first()
    else:
        # 管理员视图
        total_codes = RedeemCode.query.count()
        used_codes = RedeemCode.query.filter_by(status='used').count()
        total_users = UserRecord.query.count()
        active_machines = Machine.query.filter_by(status='online').count()
        today_stats = None

    return render_template('dashboard.html',
        total_codes=total_codes,
        used_codes=used_codes,
        total_users=total_users,
        active_machines=active_machines,
        today_stats=today_stats
    )


@app.route(f'{ADMIN_PREFIX}/customers')
def customers_page():
    """客户管理"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template('customers.html')


@app.route(f'{ADMIN_PREFIX}/codes')
def codes_page():
    """兑换码管理"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template('codes.html')


@app.route(f'{ADMIN_PREFIX}/machines')
def machines_page():
    """机器管理"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template('machines.html')


@app.route(f'{ADMIN_PREFIX}/users')
def users_page():
    """用户记录"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template('users.html')


@app.route(f'{ADMIN_PREFIX}/settings')
def settings_page():
    """系统设置"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template('settings.html')


# ==================== 增强版中控台相关路由 ====================

@app.route(f'{ADMIN_PREFIX}/control')
def control_panel():
    """增强版中控台"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template('dashboard_enhanced.html',
        current_time=datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        server_ip="150.158.20.232",
        service_ports={"派样机首页": 5000, "管理后台": 5001, "小程序API": 5002}
    )


# 简化的API接口（完整的apis.py需要另外导入）
@app.route(f'{ADMIN_PREFIX}/api/service_status')
def api_service_status():
    """获取服务状态"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})
    
    try:
        return jsonify({
            'success': True,
            'data': {
                'hinana-admin': {'status': 'running', 'port': 5001},
                'vending-app': {'status': 'running', 'port': 5000},
                'miniapp-api': {'status': 'running', 'port': 5002}
            }
        })
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})


# ==================== 启动 ====================

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5001, debug=True)