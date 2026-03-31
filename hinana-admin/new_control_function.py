# ==================== 增强版中控台相关路由 ====================

@app.route(f'{ADMIN_PREFIX}/control')
def control_panel():
    """增强版中控台"""
    if 'admin_id' not in session:
        return redirect(url_for('index'))
    
    # 获取当前服务状态
    service_status = {}
    try:
        # 使用系统命令检查服务状态
        services = {
            'hinana-admin': '管理后台',
            'vending-app': '派样机应用',
            'miniapp-api': '小程序API'
        }
        
        for service_name, display_name in services.items():
            result = subprocess.run(
                ['systemctl', 'is-active', service_name],
                capture_output=True, text=True, timeout=5
            )
            status = result.stdout.strip()
            if status == 'active':
                service_status[display_name] = {
                    'status': 'running',
                    'color': 'success',  # bootstrap success class
                    'icon': 'check-circle'
                }
            else:
                service_status[display_name] = {
                    'status': 'stopped',
                    'color': 'danger',  # bootstrap danger class
                    'icon': 'x-circle'
                }
    except Exception as e:
        # 如果获取失败，使用默认值
        for display_name in ['管理后台', '派样机应用', '小程序API']:
            service_status[display_name] = {
                'status': 'unknown',
                'color': 'secondary',
                'icon': 'help-circle'
            }
    
    return render_template('dashboard_enhanced.html',
        current_time=datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        server_ip="150.158.20.232",
        service_ports={"派样机首页": 5000, "管理后台": 5001, "小程序API": 5002},
        service_status=service_status  # 添加这个变量
    )