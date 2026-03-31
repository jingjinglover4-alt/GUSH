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
            'hinana-admin': {'name': '管理后台', 'port': 5001},
            'vending-app': {'name': '派样机应用', 'port': 5000},
            'miniapp-api': {'name': '小程序API', 'port': 5002}
        }
        
        for service_name, info in services.items():
            result = subprocess.run(
                ['systemctl', 'is-active', service_name],
                capture_output=True, text=True, timeout=5
            )
            status = result.stdout.strip()
            if status == 'active':
                service_status[info['name']] = {
                    'status': 'running',
                    'color': 'success',
                    'icon': 'check-circle',
                    'port': info['port'],
                    'ports': f'端口: {info["port"]}',
                    'description': '服务运行正常'
                }
            else:
                service_status[info['name']] = {
                    'status': 'stopped',
                    'color': 'danger',
                    'icon': 'x-circle',
                    'port': info['port'],
                    'ports': f'端口: {info["port"]}',
                    'description': '服务已停止'
                }
    except Exception as e:
        # 如果获取失败，使用默认值
        for name, port in {'管理后台': 5001, '派样机应用': 5000, '小程序API': 5002}.items():
            service_status[name] = {
                'status': 'unknown',
                'color': 'secondary',
                'icon': 'help-circle',
                'port': port,
                'ports': f'端口: {port}',
                'description': '状态未知'
            }
    
    return render_template('dashboard_enhanced.html',
        current_time=datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        server_ip="150.158.20.232",
        service_ports={"派样机首页": 5000, "管理后台": 5001, "小程序API": 5002},
        service_status=service_status
    )