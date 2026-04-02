# -*- coding: utf-8 -*-
"""
HI拿智能派样SaaS管理系统 - Flask后端
"""
import json
from flask import Flask, render_template, request, jsonify, session, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, timedelta
import hashlib
from werkzeug.security import generate_password_hash, check_password_hash
import random
import string
import os
import requests

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
    __tablename__ = 'admin_users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)
    role = db.Column(db.String(20), default='admin')  # admin, customer
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.now)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        # 先尝试标准的check_password_hash（支持scrypt和pbkdf2）
        if check_password_hash(self.password_hash, password):
            return True
        # 向后兼容：如果密码哈希是旧的SHA256格式，也允许验证
        # SHA256哈希是64位十六进制字符串
        if len(self.password_hash) == 64 and all(c in '0123456789abcdefABCDEF' for c in self.password_hash):
            import hashlib
            return self.password_hash == hashlib.sha256(password.encode()).hexdigest()
        return False


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
    user_phone = db.Column(db.String(20))  # 用户手机号


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
    # 4G设备信息
    imei = db.Column(db.String(20))  # 4G模块IMEI
    sim_no = db.Column(db.String(20))  # SIM卡号
    firmware_version = db.Column(db.String(50))  # 固件版本
    # 位置信息
    latitude = db.Column(db.Float)  # 纬度
    longitude = db.Column(db.Float)  # 经度
    location_address = db.Column(db.Text)  # 地址描述
    last_location_update = db.Column(db.DateTime)  # 最后位置更新时间


class Channel(db.Model):
    """货道配置"""
    __tablename__ = 'channels'
    id = db.Column(db.Integer, primary_key=True)
    machine_id = db.Column(db.Integer, db.ForeignKey('machines.id'), nullable=False)
    channel_no = db.Column(db.Integer, nullable=False)  # 货道编号 0-59
    product_name = db.Column(db.String(100), default='')
    product_image = db.Column(db.String(255), default='')
    max_qty = db.Column(db.Integer, default=5)
    unit_price = db.Column(db.Float, default=0)
    low_stock_threshold = db.Column(db.Integer, default=2)
    status = db.Column(db.String(20), default='normal')  # normal, disabled
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)


class Inventory(db.Model):
    """货道实时库存"""
    __tablename__ = 'inventory'
    id = db.Column(db.Integer, primary_key=True)
    channel_id = db.Column(db.Integer, db.ForeignKey('channels.id'), nullable=False, unique=True)
    current_qty = db.Column(db.Integer, default=0)
    last_updated = db.Column(db.DateTime, default=datetime.now)


class ReplenishmentLog(db.Model):
    """补货记录"""
    __tablename__ = 'replenishment_logs'
    id = db.Column(db.Integer, primary_key=True)
    channel_id = db.Column(db.Integer, db.ForeignKey('channels.id'), nullable=False)
    operator_id = db.Column(db.Integer, db.ForeignKey('admin_users.id'))
    operator_name = db.Column(db.String(50), default='')
    before_qty = db.Column(db.Integer, default=0)
    after_qty = db.Column(db.Integer, default=0)
    quantity_added = db.Column(db.Integer, default=0)
    method = db.Column(db.String(20), default='manual')  # manual, device
    notes = db.Column(db.Text, default='')
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
    login_type = data.get('login_type', '').strip().lower()  # 'admin' 或 'merchant'

    admin = Admin.query.filter_by(username=username).first()

    if admin and admin.check_password(password):
        # 检查登录类型是否匹配
        if login_type:
            if login_type == 'admin':
                # 管理员登录：必须是admin角色
                if admin.role != 'admin':
                    return jsonify({'success': False, 'message': '该账号不是超级管理员账号'})
            elif login_type == 'merchant':
                # 商户登录：必须是customer角色且有customer_id
                if admin.role != 'customer':
                    return jsonify({'success': False, 'message': '该账号不是商户账号'})
                if not admin.customer_id:
                    return jsonify({'success': False, 'message': '商户账号未关联客户，请联系管理员'})
            else:
                return jsonify({'success': False, 'message': '无效的登录类型'})
        
        session['admin_id'] = admin.id
        session['admin_name'] = admin.username
        session['customer_id'] = admin.customer_id
        session['role'] = admin.role
        session['login_type'] = login_type if login_type else 'auto'
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


# ==================== API接口 ====================

@app.route(f'{ADMIN_PREFIX}/api/customers', methods=['GET'])
def api_get_customers():
    """获取客户列表"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    if session['role'] == 'admin':
        customers = Customer.query.all()
    else:
        customers = [Customer.query.get(session['customer_id'])]

    return jsonify({
        'success': True,
        'data': [{'id': c.id, 'name': c.name, 'app_name': c.app_name,
                  'status': c.status, 'created_at': c.created_at.strftime('%Y-%m-%d %H:%M')}
                 for c in customers]
    })


@app.route(f'{ADMIN_PREFIX}/api/customer/<int:cid>', methods=['GET'])
def api_get_customer(cid):
    """获取客户详情"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    customer = Customer.query.get(cid)
    if not customer:
        return jsonify({'success': False, 'message': '客户不存在'})

    return jsonify({
        'success': True,
        'data': {
            'id': customer.id,
            'name': customer.name,
            'logo_url': customer.logo_url,
            'bg_image_url': customer.bg_image_url,
            'qrcode_url': customer.qrcode_url,
            'slogan': customer.slogan,
            'app_name': customer.app_name,
            'wx_appid': customer.wx_appid,
            'mp_appid': customer.mp_appid,
            'ww_corpid': customer.ww_corpid,
            'ww_agentid': customer.ww_agentid,
            'code_expire_seconds': customer.code_expire_seconds,
            'code_length': customer.code_length,
            'status': customer.status
        }
    })


@app.route(f'{ADMIN_PREFIX}/api/customer/<int:cid>', methods=['PUT'])
def api_update_customer(cid):
    """更新客户配置"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    customer = Customer.query.get(cid)
    if not customer:
        return jsonify({'success': False, 'message': '客户不存在'})

    data = request.get_json()

    # 可更新的字段
    fields = ['name', 'logo_url', 'bg_image_url', 'qrcode_url', 'slogan',
              'app_name', 'wx_appid', 'wx_appsecret', 'mp_appid', 'mp_appsecret',
              'ww_corpid', 'ww_agentid', 'ww_secret',
              'code_expire_seconds', 'code_length', 'status']

    for field in fields:
        if field in data:
            setattr(customer, field, data[field])

    db.session.commit()
    return jsonify({'success': True, 'message': '更新成功'})


@app.route(f'{ADMIN_PREFIX}/api/customer', methods=['POST'])
def api_create_customer():
    """新增客户"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    data = request.get_json()
    if not data or not data.get('name'):
        return jsonify({'success': False, 'message': '客户名称不能为空'})

    # 检查名称是否重复
    if Customer.query.filter_by(name=data['name']).first():
        return jsonify({'success': False, 'message': '客户名称已存在'})

    customer = Customer(
        name=data['name'],
        app_name=data.get('app_name', ''),
        slogan=data.get('slogan', ''),
        logo_url=data.get('logo_url', ''),
        bg_image_url=data.get('bg_image_url', ''),
        qrcode_url=data.get('qrcode_url', ''),
        wx_appid=data.get('wx_appid', ''),
        wx_appsecret=data.get('wx_appsecret', ''),
        mp_appid=data.get('mp_appid', ''),
        mp_appsecret=data.get('mp_appsecret', ''),
        ww_corpid=data.get('ww_corpid', ''),
        ww_agentid=data.get('ww_agentid', ''),
        ww_secret=data.get('ww_secret', ''),
        code_expire_seconds=data.get('code_expire_seconds', 60),
        code_length=data.get('code_length', 6),
        status=data.get('status', 'active')
    )

    db.session.add(customer)
    db.session.commit()

    return jsonify({'success': True, 'message': '创建成功', 'data': {'id': customer.id}})


@app.route(f'{ADMIN_PREFIX}/api/customer/<int:cid>', methods=['DELETE'])
def api_delete_customer(cid):
    """删除客户"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    customer = Customer.query.get(cid)
    if not customer:
        return jsonify({'success': False, 'message': '客户不存在'})

    # 检查是否有关联数据
    if customer.machines:
        return jsonify({'success': False, 'message': '该客户有关联机器，请先删除机器'})

    db.session.delete(customer)
    db.session.commit()

    return jsonify({'success': True, 'message': '删除成功'})


@app.route(f'{ADMIN_PREFIX}/api/customer/<int:cid>/toggle-status', methods=['PUT'])
def api_toggle_customer_status(cid):
    """切换客户状态（冻结/解冻）"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    customer = Customer.query.get(cid)
    if not customer:
        return jsonify({'success': False, 'message': '客户不存在'})

    customer.status = 'frozen' if customer.status == 'active' else 'active'
    db.session.commit()

    return jsonify({
        'success': True,
        'message': '已解冻' if customer.status == 'active' else '已冻结',
        'data': {'status': customer.status}
    })


@app.route(f'{ADMIN_PREFIX}/api/customer-stats', methods=['GET'])
def api_customer_stats():
    """获取客户统计"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    total = Customer.query.count()
    active = Customer.query.filter_by(status='active').count()
    frozen = Customer.query.filter_by(status='frozen').count()

    # 各客户的派样数统计
    stats = db.session.query(
        Customer.id,
        Customer.name,
        Customer.status,
        db.func.count(RedeemCode.id).label('code_count')
    ).outerjoin(RedeemCode, Customer.id == RedeemCode.customer_id
    ).group_by(Customer.id).all()

    customer_stats = [{
        'id': s.id,
        'name': s.name,
        'status': s.status,
        'code_count': s.code_count
    } for s in stats]

    return jsonify({
        'success': True,
        'data': {
            'total': total,
            'active': active,
            'frozen': frozen,
            'customers': customer_stats
        }
    })


@app.route(f'{ADMIN_PREFIX}/api/codes', methods=['GET'])
def api_get_codes():
    """获取兑换码列表"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    customer_id = session.get('customer_id')
    status = request.args.get('status', '')
    page = int(request.args.get('page', 1))
    limit = int(request.args.get('limit', 20))

    query = RedeemCode.query
    if customer_id:
        query = query.filter_by(customer_id=customer_id)
    if status:
        query = query.filter_by(status=status)

    total = query.count()
    codes = query.order_by(RedeemCode.created_at.desc()).offset((page-1)*limit).limit(limit).all()

    return jsonify({
        'success': True,
        'total': total,
        'page': page,
        'data': [{
            'id': c.id,
            'code': c.code,
            'status': c.status,
            'phone': c.user_phone,
            'openid': c.openid,
            'created_at': c.created_at.strftime('%Y-%m-%d %H:%M:%S'),
            'expired_at': c.expired_at.strftime('%Y-%m-%d %H:%M:%S') if c.expired_at else '',
            'used_at': c.used_at.strftime('%Y-%m-%d %H:%M:%S') if c.used_at else ''
        } for c in codes]
    })


@app.route(f'{ADMIN_PREFIX}/api/codes/delete', methods=['POST'])
def api_delete_codes():
    """删除兑换码（物理删除）"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    data = request.get_json()
    phone_numbers = data.get('phone_numbers', [])

    if not phone_numbers:
        return jsonify({'success': False, 'message': '请选择要删除的记录'})

    # 物理删除
    deleted_count = RedeemCode.query.filter(
        RedeemCode.phone.in_(phone_numbers)
    ).delete(synchronize_session=False)

    db.session.commit()

    return jsonify({
        'success': True,
        'message': f'已删除 {deleted_count} 条记录',
        'deleted_count': deleted_count
    })


@app.route(f'{ADMIN_PREFIX}/api/machines', methods=['GET'])
def api_get_machines():
    """获取机器列表"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    customer_id = session.get('customer_id')

    query = Machine.query
    if customer_id:
        query = query.filter_by(customer_id=customer_id)

    machines = query.all()

    return jsonify({
        'success': True,
        'data': [{
            'id': m.id,
            'machine_code': m.machine_code,
            'name': m.name,
            'location': m.location,
            'status': m.status,
            'imei': m.imei or '',
            'sim_no': m.sim_no or '',
            'firmware_version': m.firmware_version or '',
            'last_heartbeat': m.last_heartbeat.strftime('%Y-%m-%d %H:%M:%S') if m.last_heartbeat else ''
        } for m in machines]
    })


@app.route(f'{ADMIN_PREFIX}/api/machine/<int:machine_id>/device-info', methods=['GET'])
def api_get_machine_device_info(machine_id):
    """获取机器设备信息"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    machine = Machine.query.get(machine_id)
    if not machine:
        return jsonify({'success': False, 'message': '机器不存在'})

    return jsonify({
        'success': True,
        'imei': machine.imei or '',
        'sim_no': machine.sim_no or '',
        'firmware_version': machine.firmware_version or ''
    })


@app.route(f'{ADMIN_PREFIX}/api/machine/<int:machine_id>/device-info', methods=['PUT'])
def api_update_machine_device_info(machine_id):
    """更新机器设备信息"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    machine = Machine.query.get(machine_id)
    if not machine:
        return jsonify({'success': False, 'message': '机器不存在'})

    data = request.get_json()
    machine.imei = data.get('imei', '')
    machine.sim_no = data.get('sim_no', '')
    machine.firmware_version = data.get('firmware_version', '')
    db.session.commit()

    return jsonify({
        'success': True,
        'message': '保存成功',
        'imei': machine.imei,
        'sim_no': machine.sim_no,
        'firmware_version': machine.firmware_version
    })


@app.route(f'{ADMIN_PREFIX}/api/machine/<int:machine_id>/channels', methods=['GET'])
def api_get_machine_channels(machine_id):
    """获取机器货道列表"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    machine = Machine.query.get(machine_id)
    if not machine:
        return jsonify({'success': False, 'message': '机器不存在'})

    channels = Channel.query.filter_by(machine_id=machine_id).all()
    # 按货道名称排序 (A0, A1... A9, B0...)
    def sort_key(x):
        # "A0" -> (0, 0), "B5" -> (1, 5)
        if x.channel_no and len(x.channel_no) >= 2:
            row = ord(x.channel_no[0].upper()) - ord('A')
            col = int(x.channel_no[1]) if x.channel_no[1].isdigit() else 0
            return (row, col)
        return (0, 0)
    channels.sort(key=sort_key)

    # 获取库存信息
    channel_ids = [ch.id for ch in channels]
    inventory_map = {}
    if channel_ids:
        inv_records = Inventory.query.filter(Inventory.channel_id.in_(channel_ids)).all()
        inventory_map = {inv.channel_id: inv.current_qty for inv in inv_records}

    return jsonify({
        'success': True,
        'data': [{
            'id': ch.id,
            'channel_no': ch.channel_no,
            'product_name': ch.product_name,
            'product_image': ch.product_image,
            'max_qty': ch.max_qty,
            'current_qty': inventory_map.get(ch.id, 0),
            'unit_price': ch.unit_price,
            'low_stock_threshold': ch.low_stock_threshold,
            'status': ch.status
        } for ch in channels]
    })


@app.route(f'{ADMIN_PREFIX}/api/channel/<int:channel_id>', methods=['PUT'])
def api_update_channel(channel_id):
    """更新货道配置"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    channel = Channel.query.get(channel_id)
    if not channel:
        return jsonify({'success': False, 'message': '货道不存在'})

    data = request.get_json()
    channel.product_name = data.get('product_name', channel.product_name)
    channel.product_image = data.get('product_image', channel.product_image)
    channel.max_qty = data.get('max_qty', channel.max_qty)
    channel.unit_price = data.get('unit_price', channel.unit_price)
    channel.low_stock_threshold = data.get('low_stock_threshold', channel.low_stock_threshold)
    channel.status = data.get('status', channel.status)
    db.session.commit()

    return jsonify({'success': True, 'message': '更新成功'})


@app.route(f'{ADMIN_PREFIX}/api/channel/<int:channel_id>/replenish', methods=['POST'])
def api_channel_replenish(channel_id):
    """货道补货"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    channel = Channel.query.get(channel_id)
    if not channel:
        return jsonify({'success': False, 'message': '货道不存在'})

    data = request.get_json()
    add_qty = data.get('quantity', 0)
    notes = data.get('notes', '')

    if add_qty <= 0:
        return jsonify({'success': False, 'message': '补货数量必须大于0'})

    # 获取或创建库存记录
    inv = Inventory.query.filter_by(channel_id=channel_id).first()
    before_qty = inv.current_qty if inv else 0

    if inv:
        inv.current_qty = min(inv.current_qty + add_qty, channel.max_qty)
    else:
        inv = Inventory(channel_id=channel_id, current_qty=min(add_qty, channel.max_qty))
        db.session.add(inv)

    after_qty = inv.current_qty

    # 记录日志
    log = ReplenishmentLog(
        channel_id=channel_id,
        operator_id=session.get('admin_id'),
        operator_name=session.get('username', '未知'),
        before_qty=before_qty,
        after_qty=after_qty,
        quantity_added=after_qty - before_qty,
        method='manual',
        notes=notes
    )
    db.session.add(log)
    db.session.commit()

    return jsonify({
        'success': True,
        'message': f'补货成功，当前库存：{after_qty}',
        'before_qty': before_qty,
        'after_qty': after_qty
    })


@app.route(f'{ADMIN_PREFIX}/api/channel/<int:channel_id>/inventory', methods=['PUT'])
def api_set_channel_inventory(channel_id):
    """设置货道库存"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    channel = Channel.query.get(channel_id)
    if not channel:
        return jsonify({'success': False, 'message': '货道不存在'})

    data = request.get_json()
    new_qty = max(0, min(data.get('current_qty', 0), channel.max_qty))

    inv = Inventory.query.filter_by(channel_id=channel_id).first()
    before_qty = inv.current_qty if inv else 0

    if inv:
        inv.current_qty = new_qty
        inv.last_updated = datetime.now()
    else:
        inv = Inventory(channel_id=channel_id, current_qty=new_qty)
        db.session.add(inv)

    db.session.commit()

    return jsonify({
        'success': True,
        'before_qty': before_qty,
        'current_qty': new_qty
    })


@app.route(f'{ADMIN_PREFIX}/api/channel/<int:channel_id>/logs', methods=['GET'])
def api_channel_logs(channel_id):
    """获取货道补货记录"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    channel = Channel.query.get(channel_id)
    if not channel:
        return jsonify({'success': False, 'message': '货道不存在'})

    logs = ReplenishmentLog.query.filter_by(channel_id=channel_id).order_by(
        ReplenishmentLog.created_at.desc()
    ).limit(50).all()

    return jsonify({
        'success': True,
        'data': [{
            'id': log.id,
            'operator_name': log.operator_name,
            'before_qty': log.before_qty,
            'after_qty': log.after_qty,
            'quantity_added': log.quantity_added,
            'method': log.method,
            'notes': log.notes,
            'created_at': log.created_at.strftime('%Y-%m-%d %H:%M:%S') if log.created_at else ''
        } for log in logs]
    })


@app.route(f'{ADMIN_PREFIX}/api/stats', methods=['GET'])
def api_get_stats():
    """获取统计数据"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'message': '未登录'})

    customer_id = session.get('customer_id')
    days = int(request.args.get('days', 7))

    query = Stats.query
    if customer_id:
        query = query.filter_by(customer_id=customer_id)

    stats = query.order_by(Stats.date.desc()).limit(days).all()

    return jsonify({
        'success': True,
        'data': [{
            'date': s.date.strftime('%Y-%m-%d'),
            'scan_count': s.scan_count,
            'claim_count': s.claim_count,
            'redeem_count': s.redeem_count
        } for s in stats]
    })


# ==================== 机器端API ====================

@app.route(f'{ADMIN_PREFIX}/api/redeem/verify', methods=['POST'])
def api_verify_code():
    """验证兑换码（机器端调用）"""
    data = request.get_json()
    code = data.get('code', '').strip()
    machine_id = data.get('machine_id')
    machine_code = data.get('machine_code')

    # 查找机器
    machine = None
    if machine_code:
        machine = Machine.query.filter_by(machine_code=machine_code).first()
    elif machine_id:
        machine = Machine.query.get(machine_id)

    if not machine:
        return jsonify({'success': False, 'message': '机器未注册'})

    # 查找兑换码
    redeem_code = RedeemCode.query.filter_by(code=code, customer_id=machine.customer_id).first()

    if not redeem_code:
        return jsonify({'success': False, 'message': '兑换码无效'})

    # 检查状态
    if redeem_code.status == 'used':
        return jsonify({'success': False, 'message': '兑换码已使用'})

    if redeem_code.status == 'expired' or (redeem_code.expired_at and datetime.now() > redeem_code.expired_at):
        return jsonify({'success': False, 'message': '兑换码已过期'})

    # 验证成功，返回发货指令
    redeem_code.status = 'used'
    redeem_code.used_at = datetime.now()
    redeem_code.used_machine_id = machine.id
    user_phone = db.Column(db.String(20))  # 用户手机号
    db.session.commit()

    # 更新统计数据
    today = datetime.now().date()
    stats = Stats.query.filter_by(customer_id=machine.customer_id, date=today).first()
    if stats:
        stats.redeem_count += 1
    else:
        stats = Stats(customer_id=machine.customer_id, date=today, redeem_count=1)
        db.session.add(stats)
    db.session.commit()

    return jsonify({
        'success': True,
        'message': '验证成功',
        'action': 'dispense'  # 机器收到此指令后发货
    })


@app.route(f'{ADMIN_PREFIX}/api/machine/heartbeat', methods=['POST'])
def api_machine_heartbeat():
    """机器心跳"""
    data = request.get_json()
    machine_code = data.get('machine_code')

    machine = Machine.query.filter_by(machine_code=machine_code).first()
    if machine:
        machine.last_heartbeat = datetime.now()
        machine.status = 'online'
        db.session.commit()
        return jsonify({'success': True, 'message': '心跳成功'})

    return jsonify({'success': False, 'message': '机器未注册'})


# ==================== 用户API ====================

@app.route(f'{ADMIN_PREFIX}/api/users', methods=['GET'])
def api_users():
    """获取用户列表"""
    page = int(request.args.get('page', 1))
    limit = int(request.args.get('limit', 20))
    keyword = request.args.get('keyword', '')
    
    query = db.session.query(
        RedeemCode.openid,
        db.func.count(RedeemCode.id).label('claim_count'),
        db.func.sum(db.cast(RedeemCode.status == 'used', db.Integer)).label('redeem_count'),
        db.func.max(RedeemCode.created_at).label('last_claim_at')
    ).group_by(RedeemCode.openid)
    
    if keyword:
        query = query.filter(RedeemCode.openid.like(f'%{keyword}%'))
    
    total = query.count()
    users = query.offset((page - 1) * limit).limit(limit).all()
    
    return jsonify({
        'success': True,
        'data': [{
            'openid': u.openid,
            'claim_count': u.claim_count,
            'redeem_count': u.redeem_count or 0,
            'last_claim_at': u.last_claim_at.strftime('%Y-%m-%d %H:%M') if u.last_claim_at else None
        } for u in users],
        'total': total,
        'total_claims': RedeemCode.query.count(),
        'total_redeems': RedeemCode.query.filter_by(status='used').count()
    })

# ============ 货物可视化页面 ============
@app.route(f"{ADMIN_PREFIX}/inventory-visualization")
def inventory_visualization():
    """货物可视化页面"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template("inventory_visualization.html")


# ============ 内容管理 API ============
@app.route(f"{ADMIN_PREFIX}/content")
def content_page():
    return render_template("content.html")

@app.route(f"{ADMIN_PREFIX}/api/content/config")
def get_content_config():
    try:
        # 使用原生SQL获取配置
        result = db.session.execute(db.text("SELECT section, config FROM content_config"))
        config = {}
        for row in result:
            section, cfg_json = row[0], row[1]
            config[section] = json.loads(cfg_json) if cfg_json else {}
        return jsonify({"success": True, "config": config})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500

@app.route(f"{ADMIN_PREFIX}/api/content/save", methods=["POST"])
def save_content_config():
    try:
        data = request.get_json()
        section = data.get("section")
        config = data.get("config", {})
        if not section:
            return jsonify({"success": False, "error": "缺少section参数"}), 400
        config_json = json.dumps(config, ensure_ascii=False)
        # SQLite UPSERT
        db.session.execute(
            db.text("""
                INSERT INTO content_config (section, config, updated_at) 
                VALUES (:section, :config, datetime('now')) 
                ON CONFLICT(section) DO UPDATE SET config = :config, updated_at = datetime('now')
            """),
            {"section": section, "config": config_json}
        )
        db.session.commit()
        return jsonify({"success": True, "message": "保存成功"})
    except Exception as e:
        db.session.rollback()
        return jsonify({"success": False, "error": str(e)}), 500


# ==================== 硬件控制 API ====================

# 硬件网关配置
HARDWARE_GATEWAY_URL = "http://localhost:8003"  # 硬件网关服务地址
HARDWARE_GATEWAY_TOKEN = "admin-demo-token"  # 硬件网关管理令牌

@app.route(f'{ADMIN_PREFIX}/hardware')
def hardware_control():
    """硬件控制面板"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template('hardware.html')


@app.route(f'{ADMIN_PREFIX}/api/hardware', methods=['GET'])
def api_hardware_list():
    """获取硬件连接列表（从硬件网关获取）"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'error': '未授权'}), 401
    
    try:
        # 调用硬件网关API获取硬件列表
        headers = {'Authorization': HARDWARE_GATEWAY_TOKEN}
        response = requests.get(
            f'{HARDWARE_GATEWAY_URL}/api/hardware',
            headers=headers,
            timeout=5
        )
        if response.status_code == 200:
            return jsonify({'success': True, 'data': response.json()})
        else:
            return jsonify({'success': False, 'error': f'硬件网关错误: {response.status_code}'}), 500
    except Exception as e:
        return jsonify({'success': False, 'error': f'连接硬件网关失败: {str(e)}'}), 500


@app.route(f'{ADMIN_PREFIX}/api/hardware/<imei>/status', methods=['GET'])
def api_hardware_status(imei):
    """获取硬件状态"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'error': '未授权'}), 401
    
    try:
        headers = {'Authorization': HARDWARE_GATEWAY_TOKEN}
        response = requests.get(
            f'{HARDWARE_GATEWAY_URL}/api/hardware/{imei}/status',
            headers=headers,
            timeout=5
        )
        if response.status_code == 200:
            return jsonify({'success': True, 'data': response.json()})
        elif response.status_code == 404:
            return jsonify({'success': False, 'error': '硬件未找到'}), 404
        else:
            return jsonify({'success': False, 'error': f'硬件网关错误: {response.status_code}'}), 500
    except Exception as e:
        return jsonify({'success': False, 'error': f'连接硬件网关失败: {str(e)}'}), 500


@app.route(f'{ADMIN_PREFIX}/api/hardware/<imei>/command', methods=['POST'])
def api_hardware_command(imei):
    """发送命令到硬件"""
    if 'admin_id' not in session:
        return jsonify({'success': False, 'error': '未授权'}), 401
    
    try:
        data = request.get_json()
        if not data:
            return jsonify({'success': False, 'error': '无效的JSON数据'}), 400
        
        # 添加管理员信息
        data['initiated_by'] = f'admin:{session.get("admin_id")}'
        
        headers = {'Authorization': HARDWARE_GATEWAY_TOKEN}
        response = requests.post(
            f'{HARDWARE_GATEWAY_URL}/api/hardware/{imei}/command',
            json=data,
            headers=headers,
            timeout=10
        )
        
        if response.status_code == 200:
            return jsonify({'success': True, 'data': response.json()})
        elif response.status_code == 404:
            return jsonify({'success': False, 'error': '硬件未找到'}), 404
        else:
            return jsonify({'success': False, 'error': f'硬件网关错误: {response.status_code}'}), 500
    except Exception as e:
        return jsonify({'success': False, 'error': f'连接硬件网关失败: {str(e)}'}), 500


# ==================== 启动 ====================

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5001, debug=True)


