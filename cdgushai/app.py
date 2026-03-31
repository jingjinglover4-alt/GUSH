#!/usr/bin/env python3
"""
派样机 - 扫码落地页服务
"""
from flask import Flask, render_template, send_from_directory
import os

app = Flask(__name__)

# 配置
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_DIR = os.path.join(BASE_DIR, 'templates')
STATIC_DIR = os.path.join(BASE_DIR, 'static')

@app.route('/')
def index():
    """首页"""
    return render_template('poster.html')

@app.route('/poster')
def poster():
    """扫码落地页"""
    return render_template('poster.html')

@app.route('/static/<path:filename>')
def serve_static(filename):
    """静态文件"""
    return send_from_directory(STATIC_DIR, filename)

@app.route('/health')
def health():
    """健康检查"""
    return {'status': 'ok', 'service': 'vending-machine-landing'}

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=False)
