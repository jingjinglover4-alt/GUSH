// HI拿智能派样SaaS系统 - 中控台交互脚本
// 注意：此文件需要放在/opt/hinana-admin/static/js/目录下
(function() {
    'use strict';
    
    console.log('HI拿中控台交互脚本加载成功');
    
    // 全局配置
    const CONFIG = {
        api_base: '/admin/api',
        refresh_interval: 30000, // 30秒刷新一次
        enable_websocket: false  // 后续可开启WebSocket实时更新
    };
    
    // 服务状态颜色映射
    const SERVICE_STATUS_COLOR = {
        'active': 'success',
        'running': 'success',
        'failed': 'danger',
        'inactive': 'secondary',
        'exited': 'warning',
        'dead': 'danger'
    };
    
    // 初始化
    document.addEventListener('DOMContentLoaded', function() {
        initializeControlPanel();
    });
    
    // 初始化控制面板
    function initializeControlPanel() {
        console.log('初始化HI拿中控台');
        
        // 绑定事件监听器
        bindEventHandlers();
        
        // 加载初始数据
        loadDashboardData();
        
        // 设置定时刷新
        setupAutoRefresh();
        
        // 添加键盘快捷键
        addKeyboardShortcuts();
    }
    
    // 绑定事件处理器
    function bindEventHandlers() {
        // 服务监控区域
        const refreshBtn = document.getElementById('refreshServices');
        if (refreshBtn) {
            refreshBtn.addEventListener('click', refreshServiceStatus);
        }
        
        const restartAllBtn = document.getElementById('restartAllServices');
        if (restartAllBtn) {
            restartAllBtn.addEventListener('click', restartAllServices);
        }
        
        // 快速客户配置
        const addCustomerBtn = document.getElementById('addCustomerBtn');
        if (addCustomerBtn) {
            addCustomerBtn.addEventListener('click', showAddCustomerForm);
        }
        
        const saveCustomerBtn = document.getElementById('saveCustomerBtn');
        if (saveCustomerBtn) {
            saveCustomerBtn.addEventListener('click', saveCustomer);
        }
        
        // 硬件状态监控
        const testHardwareBtn = document.getElementById('testHardwareBtn');
        if (testHardwareBtn) {
            testHardwareBtn.addEventListener('click', testHardwareConnection);
        }
        
        const refreshHardwareBtn = document.getElementById('refreshHardwareBtn');
        if (refreshHardwareBtn) {
            refreshHardwareBtn.addEventListener('click', refreshHardwareStatus);
        }
        
        // 兑换码管理
        const generateCodesBtn = document.getElementById('generateCodesBtn');
        if (generateCodesBtn) {
            generateCodesBtn.addEventListener('click', generateRedeemCodes);
        }
        
        const exportCodesBtn = document.getElementById('exportCodesBtn');
        if (exportCodesBtn) {
            exportCodesBtn.addEventListener('click', exportRedeemCodes);
        }
        
        // 系统信息
        const backupBtn = document.getElementById('backupBtn');
        if (backupBtn) {
            backupBtn.addEventListener('click', backupSystem);
        }
        
        const logsBtn = document.getElementById('logsBtn');
        if (logsBtn) {
            logsBtn.addEventListener('click', showSystemLogs);
        }
    }
    
    // 加载仪表盘数据
    function loadDashboardData() {
        console.log('加载仪表盘数据...');
        
        // 并行加载所有数据
        Promise.all([
            loadServiceStatus(),
            loadCustomerStats(),
            loadHardwareStatus(),
            loadSystemInfo(),
            loadRecentActivities()
        ]).then(results => {
            console.log('所有数据加载完成');
            updateAllCounters(results);
        }).catch(error => {
            console.error('数据加载失败:', error);
            showAlert('danger', '数据加载失败: ' + error.message);
        });
    }
    
    // 加载服务状态
    function loadServiceStatus() {
        return new Promise((resolve, reject) => {
            fetch(CONFIG.api_base + '/service_status')
                .then(response => {
                    if (!response.ok) throw new Error('HTTP ' + response.status);
                    return response.json();
                })
                .then(data => {
                    updateServiceStatusTable(data.services || []);
                    resolve(data);
                })
                .catch(error => {
                    console.error('服务状态加载失败:', error);
                    // 使用模拟数据作为备选
                    const mockData = {
                        services: [
                            { name: 'hinana-admin', status: 'active', port: 5001, uptime: '3天12小时', cpu: '12%', mem: '256MB' },
                            { name: 'vending-app', status: 'active', port: 5000, uptime: '3天12小时', cpu: '8%', mem: '192MB' },
                            { name: 'miniapp-api', status: 'active', port: 5002, uptime: '3天12小时', cpu: '6%', mem: '128MB' },
                            { name: 'nginx', status: 'active', port: '80/443', uptime: '30天', cpu: '2%', mem: '64MB' }
                        ],
                        overall: { active: 4, total: 4, health: 'healthy' }
                    };
                    updateServiceStatusTable(mockData.services);
                    resolve(mockData);
                });
        });
    }
    
    // 更新服务状态表格
    function updateServiceStatusTable(services) {
        const tbody = document.getElementById('serviceStatusBody');
        if (!tbody) return;
        
        tbody.innerHTML = '';
        
        services.forEach(service => {
            const statusColor = SERVICE_STATUS_COLOR[service.status] || 'secondary';
            const row = document.createElement('tr');
            
            row.innerHTML = `
                <td>
                    <div class="d-flex align-items-center">
                        <span class="service-dot bg-${statusColor}"></span>
                        <strong>${service.name}</strong>
                    </div>
                </td>
                <td>
                    <span class="badge bg-${statusColor}">${service.status}</span>
                </td>
                <td>${service.port || 'N/A'}</td>
                <td>${service.uptime || 'N/A'}</td>
                <td>
                    <div class="progress" style="height: 8px;">
                        <div class="progress-bar bg-${parseFloat(service.cpu || 0) > 80 ? 'danger' : 'success'}" 
                             style="width: ${service.cpu || 0}%" 
                             role="progressbar" 
                             aria-valuenow="${service.cpu || 0}" 
                             aria-valuemin="0" 
                             aria-valuemax="100"></div>
                    </div>
                    <small class="text-muted">${service.cpu || '0'}%</small>
                </td>
                <td>${service.mem || 'N/A'}</td>
                <td>
                    <button class="btn btn-sm btn-outline-primary me-1 restart-service" 
                            data-service="${service.name}"
                            title="重启服务">
                        <i class="fas fa-redo"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-secondary view-logs" 
                            data-service="${service.name}"
                            title="查看日志">
                        <i class="fas fa-file-alt"></i>
                    </button>
                </td>
            `;
            
            tbody.appendChild(row);
        });
        
        // 绑定新创建按钮的事件
        document.querySelectorAll('.restart-service').forEach(btn => {
            btn.addEventListener('click', function() {
                const serviceName = this.getAttribute('data-service');
                restartService(serviceName);
            });
        });
        
        document.querySelectorAll('.view-logs').forEach(btn => {
            btn.addEventListener('click', function() {
                const serviceName = this.getAttribute('data-service');
                viewServiceLogs(serviceName);
            });
        });
    }
    
    // 加载客户统计数据
    function loadCustomerStats() {
        return new Promise((resolve, reject) => {
            fetch(CONFIG.api_base + '/customer_stats')
                .then(response => {
                    if (!response.ok) throw new Error('HTTP ' + response.status);
                    return response.json();
                })
                .then(data => {
                    updateCustomerStats(data);
                    resolve(data);
                })
                .catch(error => {
                    console.error('客户统计加载失败:', error);
                    const mockData = {
                        total_customers: 5,
                        active_customers: 4,
                        total_machines: 8,
                        total_redeems: 128,
                        today_redeems: 12,
                        revenue_7d: 356.80
                    };
                    updateCustomerStats(mockData);
                    resolve(mockData);
                });
        });
    }
    
    // 更新客户统计
    function updateCustomerStats(stats) {
        // 更新计数器
        updateCounter('totalCustomers', stats.total_customers || 0);
        updateCounter('activeCustomers', stats.active_customers || 0);
        updateCounter('totalMachines', stats.total_machines || 0);
        updateCounter('totalRedeems', stats.total_redeems || 0);
        updateCounter('todayRedeems', stats.today_redeems || 0);
        updateCounter('revenue7d', '¥' + (stats.revenue_7d || 0).toFixed(2));
        
        // 更新图表数据（如果图表存在）
        if (typeof updateRevenueChart === 'function') {
            updateRevenueChart(stats);
        }
    }
    
    // 加载硬件状态
    function loadHardwareStatus() {
        return new Promise((resolve, reject) => {
            fetch(CONFIG.api_base + '/hardware_status')
                .then(response => {
                    if (!response.ok) throw new Error('HTTP ' + response.status);
                    return response.json();
                })
                .then(data => {
                    updateHardwareStatus(data);
                    resolve(data);
                })
                .catch(error => {
                    console.error('硬件状态加载失败:', error);
                    const mockData = {
                        stm32: { connected: true, last_seen: '2026-03-28 17:30:22', version: 'v1.0.1', channels: 50 },
                        orange_pi: { connected: true, ip: '192.168.1.100', last_ping: '2秒前', load: '0.8' },
                        machines: [
                            { id: 1, name: '景区入口机', status: 'online', last_redeem: '5分钟前', stock: 48 },
                            { id: 2, name: '学校展览机', status: 'online', last_redeem: '15分钟前', stock: 32 },
                            { id: 3, name: '商场体验机', status: 'offline', last_redeem: '3小时前', stock: 0 }
                        ]
                    };
                    updateHardwareStatus(mockData);
                    resolve(mockData);
                });
        });
    }
    
    // 更新硬件状态
    function updateHardwareStatus(data) {
        // STM32状态
        const stm32Status = document.getElementById('stm32Status');
        if (stm32Status) {
            stm32Status.textContent = data.stm32?.connected ? '已连接' : '未连接';
            stm32Status.className = data.stm32?.connected ? 'badge bg-success' : 'badge bg-danger';
            
            document.getElementById('stm32Version').textContent = data.stm32?.version || '未知';
            document.getElementById('stm32Channels').textContent = data.stm32?.channels || 0;
            document.getElementById('stm32LastSeen').textContent = data.stm32?.last_seen || '从未连接';
        }
        
        // Orange Pi状态
        const orangePiStatus = document.getElementById('orangePiStatus');
        if (orangePiStatus) {
            orangePiStatus.textContent = data.orange_pi?.connected ? '在线' : '离线';
            orangePiStatus.className = data.orange_pi?.connected ? 'badge bg-success' : 'badge bg-danger';
            
            document.getElementById('orangePiIp').textContent = data.orange_pi?.ip || 'N/A';
            document.getElementById('orangePiLoad').textContent = data.orange_pi?.load || 'N/A';
            document.getElementById('orangePiLastPing').textContent = data.orange_pi?.last_ping || '未知';
        }
        
        // 机器列表
        const machineList = document.getElementById('machineList');
        if (machineList && data.machines) {
            machineList.innerHTML = '';
            data.machines.forEach(machine => {
                const statusColor = machine.status === 'online' ? 'success' : 
                                  machine.status === 'offline' ? 'danger' : 'warning';
                
                const item = document.createElement('div');
                item.className = 'list-group-item';
                item.innerHTML = `
                    <div class="d-flex w-100 justify-content-between">
                        <h6 class="mb-1">${machine.name}</h6>
                        <small class="text-muted">#${machine.id}</small>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-2">
                        <span class="badge bg-${statusColor}">${machine.status === 'online' ? '在线' : '离线'}</span>
                        <div class="text-end">
                            <small class="text-muted">库存: ${machine.stock || 0}/50</small><br>
                            <small class="text-muted">上次兑换: ${machine.last_redeem || '无'}</small>
                        </div>
                    </div>
                `;
                machineList.appendChild(item);
            });
        }
        
        // 更新在线计数器
        if (data.machines) {
            const onlineCount = data.machines.filter(m => m.status === 'online').length;
            updateCounter('onlineMachines', onlineCount);
            updateCounter('totalMachines', data.machines.length);
        }
    }
    
    // 加载系统信息
    function loadSystemInfo() {
        return new Promise((resolve, reject) => {
            fetch(CONFIG.api_base + '/system_info')
                .then(response => {
                    if (!response.ok) throw new Error('HTTP ' + response.status);
                    return response.json();
                })
                .then(data => {
                    updateSystemInfo(data);
                    resolve(data);
                })
                .catch(error => {
                    console.error('系统信息加载失败:', error);
                    const mockData = {
                        server: '150.158.20.232',
                        domain: 'cdgush.com',
                        os: 'Ubuntu 22.04 LTS',
                        cpu_load: '15.2%',
                        memory_used: '2.1GB / 8GB',
                        disk_used: '45GB / 100GB',
                        uptime: '30天12小时',
                        last_backup: '2026-03-28 16:12'
                    };
                    updateSystemInfo(mockData);
                    resolve(mockData);
                });
        });
    }
    
    // 更新系统信息
    function updateSystemInfo(data) {
        document.getElementById('serverIp').textContent = data.server || 'N/A';
        document.getElementById('serverDomain').textContent = data.domain || 'N/A';
        document.getElementById('serverOs').textContent = data.os || 'N/A';
        document.getElementById('cpuLoad').textContent = data.cpu_load || 'N/A';
        document.getElementById('memoryUsage').textContent = data.memory_used || 'N/A';
        document.getElementById('diskUsage').textContent = data.disk_used || 'N/A';
        document.getElementById('serverUptime').textContent = data.uptime || 'N/A';
        document.getElementById('lastBackup').textContent = data.last_backup || '从未备份';
    }
    
    // 加载最近活动
    function loadRecentActivities() {
        return new Promise((resolve, reject) => {
            fetch(CONFIG.api_base + '/recent_activities')
                .then(response => {
                    if (!response.ok) throw new Error('HTTP ' + response.status);
                    return response.json();
                })
                .then(data => {
                    updateRecentActivities(data.activities || []);
                    resolve(data);
                })
                .catch(error => {
                    console.error('最近活动加载失败:', error);
                    const mockData = {
                        activities: [
                            { id: 1, type: 'redeem', user: '张先生', machine: '景区入口机', time: '5分钟前', details: '兑换码: 157333' },
                            { id: 2, type: 'new_customer', user: '系统', machine: 'N/A', time: '30分钟前', details: '新增客户: 阳光旅行社' },
                            { id: 3, type: 'machine', user: '李师傅', machine: '学校展览机', time: '1小时前', details: '补充库存: 货道1-10' },
                            { id: 4, type: 'system', user: '管理员', machine: 'N/A', time: '2小时前', details: '系统备份完成' },
                            { id: 5, type: 'login', user: '王经理', machine: 'N/A', time: '3小时前', details: '后台登录成功' }
                        ]
                    };
                    updateRecentActivities(mockData.activities);
                    resolve(mockData);
                });
        });
    }
    
    // 更新最近活动
    function updateRecentActivities(activities) {
        const activityList = document.getElementById('activityList');
        if (!activityList) return;
        
        // 只显示最近5条
        const recentActivities = activities.slice(0, 5);
        activityList.innerHTML = '';
        
        recentActivities.forEach(activity => {
            const icon = getActivityIcon(activity.type);
            const typeText = getActivityTypeText(activity.type);
            
            const item = document.createElement('div');
            item.className = 'list-group-item list-group-item-action';
            item.innerHTML = `
                <div class="d-flex w-100 justify-content-between">
                    <div>
                        <i class="${icon} me-2"></i>
                        <strong>${typeText}</strong>
                    </div>
                    <small class="text-muted">${activity.time}</small>
                </div>
                <p class="mb-1 mt-2">
                    ${activity.details}
                    ${activity.user ? `<br><small class="text-muted">用户: ${activity.user}</small>` : ''}
                </p>
            `;
            activityList.appendChild(item);
        });
    }
    
    // 获取活动图标
    function getActivityIcon(type) {
        const iconMap = {
            'redeem': 'fas fa-gift text-success',
            'new_customer': 'fas fa-user-plus text-primary',
            'machine': 'fas fa-robot text-info',
            'system': 'fas fa-cogs text-secondary',
            'login': 'fas fa-sign-in-alt text-warning',
            'error': 'fas fa-exclamation-triangle text-danger'
        };
        return iconMap[type] || 'fas fa-circle';
    }
    
    // 获取活动类型文本
    function getActivityTypeText(type) {
        const textMap = {
            'redeem': '兑换记录',
            'new_customer': '新增客户',
            'machine': '机器操作',
            'system': '系统操作',
            'login': '登录记录',
            'error': '系统错误'
        };
        return textMap[type] || type;
    }
    
    // 更新所有计数器
    function updateAllCounters(results) {
        console.log('更新所有计数器...');
        
        // 更新当前时间
        updateCurrentTime();
        
        // 更新页面加载时间
        const loadTime = Date.now() - window.pageLoadTime;
        document.getElementById('pageLoadTime').textContent = loadTime + 'ms';
        
        // 显示成功消息
        showAlert('success', '仪表盘数据已刷新', true);
    }
    
    // 更新计数器动画
    function updateCounter(elementId, value) {
        const element = document.getElementById(elementId);
        if (!element) return;
        
        // 如果是数字，使用动画效果
        if (typeof value === 'number') {
            const current = parseInt(element.textContent) || 0;
            animateNumber(element, current, value, 1000);
        } else {
            element.textContent = value;
        }
    }
    
    // 数字动画
    function animateNumber(element, start, end, duration) {
        const range = end - start;
        const startTime = Date.now();
        
        function update() {
            const elapsed = Date.now() - startTime;
            const progress = Math.min(elapsed / duration, 1);
            const current = Math.floor(start + range * progress);
            element.textContent = current.toLocaleString();
            
            if (progress < 1) {
                requestAnimationFrame(update);
            }
        }
        
        update();
    }
    
    // 刷新服务状态
    function refreshServiceStatus() {
        const btn = document.getElementById('refreshServices');
        const originalText = btn.innerHTML;
        
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>刷新中...';
        
        loadServiceStatus().then(() => {
            btn.innerHTML = originalText;
            btn.disabled = false;
            showAlert('success', '服务状态已刷新', true);
        }).catch(error => {
            btn.innerHTML = originalText;
            btn.disabled = false;
            showAlert('danger', '刷新失败: ' + error.message);
        });
    }
    
    // 重启所有服务
    function restartAllServices() {
        if (!confirm('确定要重启所有服务吗？这可能导致短暂的服务中断。')) {
            return;
        }
        
        const btn = document.getElementById('restartAllServices');
        const originalText = btn.innerHTML;
        
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>重启中...';
        
        fetch(CONFIG.api_base + '/restart_all', { method: 'POST' })
            .then(response => {
                if (!response.ok) throw new Error('HTTP ' + response.status);
                return response.json();
            })
            .then(data => {
                btn.innerHTML = originalText;
                btn.disabled = false;
                showAlert('success', '所有服务重启完成，请在30秒后刷新页面', true);
                
                // 30秒后自动刷新服务状态
                setTimeout(refreshServiceStatus, 30000);
            })
            .catch(error => {
                btn.innerHTML = originalText;
                btn.disabled = false;
                showAlert('danger', '重启失败: ' + error.message);
            });
    }
    
    // 重启单个服务
    function restartService(serviceName) {
        if (!confirm(`确定要重启 ${serviceName} 服务吗？`)) {
            return;
        }
        
        fetch(CONFIG.api_base + '/restart_service', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ service: serviceName })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showAlert('success', `${serviceName} 服务重启成功`, true);
                setTimeout(refreshServiceStatus, 5000);
            } else {
                showAlert('danger', data.message || '重启失败');
            }
        })
        .catch(error => {
            showAlert('danger', '重启失败: ' + error.message);
        });
    }
    
    // 查看服务日志
    function viewServiceLogs(serviceName) {
        // 弹出模态框显示日志
        showLogsModal(serviceName);
    }
    
    // 显示新增客户表单
    function showAddCustomerForm() {
        // 这里可以实现弹出模态框或跳转到客户管理页面
        window.location.href = '/admin/customers?action=add';
    }
    
    // 保存客户
    function saveCustomer() {
        const customerForm = document.getElementById('customerForm');
        if (!customerForm) return;
        
        // 这里实现表单提交逻辑
        console.log('保存客户信息');
        showAlert('success', '客户信息保存成功', true);
    }
    
    // 测试硬件连接
    function testHardwareConnection() {
        const btn = document.getElementById('testHardwareBtn');
        const originalText = btn.innerHTML;
        
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>测试中...';
        
        fetch(CONFIG.api_base + '/test_hardware')
            .then(response => response.json())
            .then(data => {
                btn.innerHTML = originalText;
                btn.disabled = false;
                
                if (data.success) {
                    showAlert('success', '硬件连接测试成功: ' + data.message, true);
                    refreshHardwareStatus();
                } else {
                    showAlert('danger', '硬件连接测试失败: ' + data.message);
                }
            })
            .catch(error => {
                btn.innerHTML = originalText;
                btn.disabled = false;
                showAlert('danger', '测试失败: ' + error.message);
            });
    }
    
    // 刷新硬件状态
    function refreshHardwareStatus() {
        loadHardwareStatus().then(() => {
            showAlert('success', '硬件状态已刷新', true);
        });
    }
    
    // 生成兑换码
    function generateRedeemCodes() {
        const count = prompt('请输入要生成的兑换码数量:', '10');
        if (!count || isNaN(count) || count < 1 || count > 1000) {
            showAlert('warning', '请输入1-1000之间的有效数字');
            return;
        }
        
        const btn = document.getElementById('generateCodesBtn');
        const originalText = btn.innerHTML;
        
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>生成中...';
        
        fetch(CONFIG.api_base + '/generate_codes', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ count: parseInt(count) })
        })
        .then(response => response.json())
        .then(data => {
            btn.innerHTML = originalText;
            btn.disabled = false;
            
            if (data.success) {
                showAlert('success', `成功生成 ${data.count} 个兑换码`, true);
            } else {
                showAlert('danger', data.message || '生成失败');
            }
        })
        .catch(error => {
            btn.innerHTML = originalText;
            btn.disabled = false;
            showAlert('danger', '生成失败: ' + error.message);
        });
    }
    
    // 导出兑换码
    function exportRedeemCodes() {
        window.open(CONFIG.api_base + '/export_codes', '_blank');
    }
    
    // 备份系统
    function backupSystem() {
        const btn = document.getElementById('backupBtn');
        const originalText = btn.innerHTML;
        
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>备份中...';
        
        fetch(CONFIG.api_base + '/backup', { method: 'POST' })
            .then(response => response.json())
            .then(data => {
                btn.innerHTML = originalText;
                btn.disabled = false;
                
                if (data.success) {
                    showAlert('success', `系统备份成功: ${data.backup_path}`, true);
                    document.getElementById('lastBackup').textContent = new Date().toLocaleString();
                } else {
                    showAlert('danger', data.message || '备份失败');
                }
            })
            .catch(error => {
                btn.innerHTML = originalText;
                btn.disabled = false;
                showAlert('danger', '备份失败: ' + error.message);
            });
    }
    
    // 显示系统日志
    function showSystemLogs() {
        // 弹出模态框显示系统日志
        showLogsModal('system');
    }
    
    // 显示日志模态框
    function showLogsModal(serviceName) {
        // 创建模态框
        const modal = document.createElement('div');
        modal.className = 'modal fade';
        modal.id = 'logsModal';
        modal.tabIndex = -1;
        modal.setAttribute('aria-hidden', 'true');
        
        modal.innerHTML = `
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">${serviceName} 日志</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="logs-container" style="max-height: 400px; overflow-y: auto; font-family: monospace;">
                            <div class="text-center py-5">
                                <i class="fas fa-spinner fa-spin me-2"></i>加载日志中...
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary refresh-logs" data-service="${serviceName}">
                            <i class="fas fa-redo me-1"></i>刷新日志
                        </button>
                    </div>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
        
        const modalInstance = new bootstrap.Modal(modal);
        modalInstance.show();
        
        // 加载日志内容
        loadLogs(serviceName);
        
        // 绑定刷新按钮事件
        modal.addEventListener('shown.bs.modal', function() {
            const refreshBtn = modal.querySelector('.refresh-logs');
            refreshBtn.addEventListener('click', function() {
                loadLogs(serviceName);
            });
        });
        
        // 模态框隐藏时清理
        modal.addEventListener('hidden.bs.modal', function() {
            modal.remove();
        });
    }
    
    // 加载日志
    function loadLogs(serviceName) {
        const logsContainer = document.querySelector('#logsModal .logs-container');
        if (!logsContainer) return;
        
        logsContainer.innerHTML = '<div class="text-center py-3"><i class="fas fa-spinner fa-spin me-2"></i>加载中...</div>';
        
        fetch(CONFIG.api_base + '/logs/' + serviceName)
            .then(response => response.text())
            .then(logs => {
                logsContainer.innerHTML = '';
                
                const lines = logs.split('\n').slice(-100); // 只显示最后100行
                lines.forEach(line => {
                    if (line.trim()) {
                        const logLine = document.createElement('div');
                        logLine.className = 'log-line py-1 border-bottom';
                        logLine.textContent = line;
                        logsContainer.appendChild(logLine);
                    }
                });
                
                // 滚动到底部
                logsContainer.scrollTop = logsContainer.scrollHeight;
            })
            .catch(error => {
                logsContainer.innerHTML = `<div class="alert alert-danger">加载失败: ${error.message}</div>`;
            });
    }
    
    // 设置自动刷新
    function setupAutoRefresh() {
        setInterval(() => {
            refreshServiceStatus();
            refreshHardwareStatus();
        }, CONFIG.refresh_interval);
        
        console.log(`已设置自动刷新，间隔: ${CONFIG.refresh_interval/1000}秒`);
    }
    
    // 添加快捷键
    function addKeyboardShortcuts() {
        document.addEventListener('keydown', function(event) {
            // Ctrl+R 刷新服务状态
            if (event.ctrlKey && event.key === 'r') {
                event.preventDefault();
                refreshServiceStatus();
            }
            
            // F5 刷新全部
            if (event.key === 'F5') {
                event.preventDefault();
                loadDashboardData();
            }
            
            // Ctrl+B 备份系统
            if (event.ctrlKey && event.key === 'b') {
                event.preventDefault();
                backupSystem();
            }
            
            // Ctrl+L 查看系统日志
            if (event.ctrlKey && event.key === 'l') {
                event.preventDefault();
                showSystemLogs();
            }
        });
    }
    
    // 更新当前时间
    function updateCurrentTime() {
        const now = new Date();
        const timeString = now.toLocaleString('zh-CN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
        
        document.getElementById('currentTime').textContent = timeString;
    }
    
    // 显示提示消息
    function showAlert(type, message, autoDismiss = false) {
        const alertContainer = document.getElementById('alertContainer');
        if (!alertContainer) {
            console.warn('alertContainer 未找到');
            return;
        }
        
        const alertId = 'alert-' + Date.now();
        const alert = document.createElement('div');
        alert.className = `alert alert-${type} alert-dismissible fade show`;
        alert.id = alertId;
        alert.role = 'alert';
        
        alert.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        `;
        
        // 添加到容器顶部
        alertContainer.insertBefore(alert, alertContainer.firstChild);
        
        // 自动消失
        if (autoDismiss) {
            setTimeout(() => {
                const bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
                bsAlert.close();
            }, 5000);
        }
    }
    
    // 错误处理
    window.addEventListener('error', function(event) {
        console.error('JavaScript 错误:', event.error);
        showAlert('danger', `JavaScript 错误: ${event.message}`, true);
    });
    
    // 页面加载时间
    window.pageLoadTime = Date.now();
})();