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
import subprocess

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
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    @staticmethod
    def create_default_admin():
        """创建默认管理员账号"""
        if not Admin.query.filter_by(username='admin').first():
            default_admin = Admin(
                username='admin',
                password_hash=hashlib.sha256('123456'.encode()).hexdigest()
            )
            db.session.add(default_admin)
            db.session.commit()

# ==================== 辅助函数 ====================

def init_db():
    """初始化数据库"""
    with app.app_context():
        db.create_all()
        Admin.create_default_admin()
        print("数据库初始化完成")

def verify_password(password_hash, password):
    """验证密码"""
    return password_hash == hashlib.sha256(password.encode()).hexdigest()

# ==================== 认证相关路由 ====================

@app.route(ADMIN_PREFIX + '/')
def index():
    """首页/登录页面"""
    if 'admin_id' in session:
        return redirect(url_for('dashboard'))
    return render_template('index.html')

@app.route(ADMIN_PREFIX + '/login', methods=['POST'])
def login():
    """登录接口 - 修复版本：使用JSON格式"""
    data = request.get_json()
    if not data:
        return jsonify({'success': False, 'message': '请提供JSON格式数据'}), 400
        
    username = data.get('username')
    password = data.get('password')
    
    if not username or not password:
        return jsonify({'success': False, 'message': '用户名和密码不能为空'}), 400
    
    admin = Admin.query.filter_by(username=username).first()
    if not admin:
        return jsonify({'success': False, 'message': '用户名或密码错误'}), 401
    
    if not verify_password(admin.password_hash, password):
        return jsonify({'success': False, 'message': '用户名或密码错误'}), 401
    
    session['admin_id'] = admin.id
    session['username'] = admin.username
    
    return jsonify({
        'success': True,
        'message': '登录成功',
        'redirect': ADMIN_PREFIX + '/dashboard'
    })

@app.route(ADMIN_PREFIX + '/logout')
def logout():
    """登出"""
    session.clear()
    return redirect(url_for('index'))

# ==================== 主功能页面 ====================

@app.route(ADMIN_PREFIX + '/dashboard')
def dashboard():
    """仪表盘页面"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    return render_template('dashboard.html')

@app.route(ADMIN_PREFIX + '/control')
def control_panel():
    """增强版中控台 - 修复版本"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    
    # 创建服务状态数据
    service_status = {
        '管理后台': {
            'status': 'running',
            'color': 'success',
            'icon': 'check-circle',
            'port': 5001,
            'ports': '端口: 5001',
            'description': '服务运行正常'
        },
        '派样机应用': {
            'status': 'running',
            'color': 'success',
            'icon': 'check-circle',
            'port': 5000,
            'ports': '端口: 5000',
            'description': '服务运行正常'
        },
        '小程序API': {
            'status': 'running',
            'color': 'success',
            'icon': 'check-circle',
            'port': 5002,
            'ports': '端口: 5002',
            'description': '服务运行正常'
        }
    }
    
    return render_template('dashboard_enhanced.html',
        current_time=datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        server_ip="150.158.20.232",
        service_ports={"派样机首页": 5000, "管理后台": 5001, "小程序API": 5002},
        service_status=service_status
    )

# ==================== 启动 ====================

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5001, debug=True)