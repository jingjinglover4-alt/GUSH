# ============ 库存管理 API（步骤2）============

# --- 机器扩展字段API ---
@app.route('/admin/api/machine/<int:mid>/device-info', methods=['PUT'])
def api_update_machine_device_info(mid):
    """更新机器4G设备信息"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'error': 'unauthorized'}), 401
    
    data = request.get_json()
    if not data:
        return jsonify({'success': False, 'error': 'no data'})
    
    db = get_db()
    machine = db.execute('SELECT id FROM machines WHERE id = ?', (mid,)).fetchone()
    if not machine:
        db.close()
        return jsonify({'success': False, 'error': 'machine not found'})
    
    fields = ['imei', 'sim_no', 'firmware_version']
    updates = []
    values = []
    for f in fields:
        if f in data:
            updates.append(f + ' = ?')
            values.append(data[f])
    
    if updates:
        values.append(mid)
        db.execute('UPDATE machines SET ' + ', '.join(updates) + ' WHERE id = ?', values)
        db.commit()
    
    db.close()
    return jsonify({'success': True})

# --- 货道配置API ---
@app.route('/admin/api/machine/<int:mid>/channels', methods=['GET'])
def api_get_machine_channels(mid):
    """获取机器的货道配置和库存"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'error': 'unauthorized'}), 401
    
    db = get_db()
    channels = db.execute('''
        SELECT c.*, COALESCE(i.current_qty, 0) as current_qty, 
               COALESCE(i.last_updated, c.created_at) as last_updated
        FROM channels c
        LEFT JOIN inventory i ON c.id = i.channel_id
        WHERE c.machine_id = ?
        ORDER BY c.channel_no
    ''', (mid,)).fetchall()
    db.close()
    
    return jsonify({
        'success': True,
        'data': [{
            'id': c['id'],
            'channel_no': c['channel_no'],
            'product_name': c['product_name'],
            'product_image': c['product_image'],
            'max_qty': c['max_qty'],
            'current_qty': c['current_qty'],
            'unit_price': c['unit_price'],
            'low_stock_threshold': c['low_stock_threshold'],
            'status': c['status'],
            'last_updated': c['last_updated'],
            'fill_rate': round(c['current_qty'] / c['max_qty'] * 100) if c['max_qty'] > 0 else 0
        } for c in channels]
    })

@app.route('/admin/api/machine/<int:mid>/channels', methods=['POST'])
def api_create_machine_channels(mid):
    """为机器批量创建货道配置（默认4个）"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'error': 'unauthorized'}), 401
    
    db = get_db()
    machine = db.execute('SELECT id FROM machines WHERE id = ?', (mid,)).fetchone()
    if not machine:
        db.close()
        return jsonify({'success': False, 'error': 'machine not found'})
    
    # 检查是否已有货道
    existing = db.execute('SELECT COUNT(*) as cnt FROM channels WHERE machine_id = ?', (mid,)).fetchone()
    if existing['cnt'] > 0:
        db.close()
        return jsonify({'success': False, 'error': 'channels already exist'})
    
    # 默认创建4个货道
    channel_ids = []
    for i in range(1, 5):
        cursor = db.execute('''
            INSERT INTO channels (machine_id, channel_no, product_name, max_qty, low_stock_threshold)
            VALUES (?, ?, ?, ?, ?)
        ''', (mid, i, f'商品{i}号', 50, 10))
        channel_ids.append(cursor.lastrowid)
        
        # 创建库存记录
        db.execute('INSERT INTO inventory (channel_id, current_qty) VALUES (?, ?)', (cursor.lastrowid, 30))
    
    db.commit()
    db.close()
    
    return jsonify({'success': True, 'data': {'created': 4}})

@app.route('/admin/api/channel/<int:cid>', methods=['PUT'])
def api_update_channel(cid):
    """更新货道配置"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'error': 'unauthorized'}), 401
    
    data = request.get_json()
    if not data:
        return jsonify({'success': False, 'error': 'no data'})
    
    db = get_db()
    channel = db.execute('SELECT id FROM channels WHERE id = ?', (cid,)).fetchone()
    if not channel:
        db.close()
        return jsonify({'success': False, 'error': 'channel not found'})
    
    fields = ['product_name', 'product_image', 'max_qty', 'unit_price', 'low_stock_threshold', 'status']
    updates = []
    values = []
    for f in fields:
        if f in data:
            updates.append(f + ' = ?')
            values.append(data[f])
    
    updates.append('updated_at = CURRENT_TIMESTAMP')
    
    if updates:
        values.append(cid)
        db.execute('UPDATE channels SET ' + ', '.join(updates) + ' WHERE id = ?', values)
        db.commit()
    
    db.close()
    return jsonify({'success': True})

# --- 库存操作API ---
@app.route('/admin/api/channel/<int:cid>/replenish', methods=['POST'])
def api_replenish_channel(cid):
    """补货操作"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'error': 'unauthorized'}), 401
    
    data = request.get_json()
    if not data or 'quantity' not in data:
        return jsonify({'success': False, 'error': 'quantity required'})
    
    db = get_db()
    channel = db.execute('SELECT * FROM channels WHERE id = ?', (cid,)).fetchone()
    if not channel:
        db.close()
        return jsonify({'success': False, 'error': 'channel not found'})
    
    # 获取当前库存
    inv = db.execute('SELECT current_qty FROM inventory WHERE channel_id = ?', (cid,)).fetchone()
    before_qty = inv['current_qty'] if inv else 0
    quantity = int(data['quantity'])
    after_qty = min(before_qty + quantity, channel['max_qty'])  # 不超过最大容量
    
    # 更新库存
    db.execute('UPDATE inventory SET current_qty = ?, last_updated = CURRENT_TIMESTAMP WHERE channel_id = ?', 
               (after_qty, cid))
    
    # 记录补货日志
    operator_name = db.execute('SELECT username FROM admin_users WHERE id = ?', (session['user_id'],)).fetchone()
    operator_name = operator_name['username'] if operator_name else 'unknown'
    
    db.execute('''
        INSERT INTO replenishment_logs (channel_id, operator_id, operator_name, before_qty, after_qty, quantity_added, method, notes)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ''', (cid, session['user_id'], operator_name, before_qty, after_qty, quantity, 'manual', data.get('notes', '')))
    
    db.commit()
    db.close()
    
    return jsonify({
        'success': True,
        'data': {
            'before_qty': before_qty,
            'after_qty': after_qty,
            'added': quantity
        }
    })

@app.route('/admin/api/channel/<int:cid>/inventory', methods=['PUT'])
def api_update_inventory(cid):
    """直接设置库存（手动调整）"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'error': 'unauthorized'}), 401
    
    data = request.get_json()
    if not data or 'current_qty' not in data:
        return jsonify({'success': False, 'error': 'current_qty required'})
    
    db = get_db()
    channel = db.execute('SELECT max_qty FROM channels WHERE id = ?', (cid,)).fetchone()
    if not channel:
        db.close()
        return jsonify({'success': False, 'error': 'channel not found'})
    
    new_qty = min(int(data['current_qty']), channel['max_qty'])
    
    inv = db.execute('SELECT current_qty FROM inventory WHERE channel_id = ?', (cid,)).fetchone()
    before_qty = inv['current_qty'] if inv else 0
    
    if inv:
        db.execute('UPDATE inventory SET current_qty = ?, last_updated = CURRENT_TIMESTAMP WHERE channel_id = ?', (new_qty, cid))
    else:
        db.execute('INSERT INTO inventory (channel_id, current_qty) VALUES (?, ?)', (cid, new_qty))
    
    # 记录调整日志
    operator_name = db.execute('SELECT username FROM admin_users WHERE id = ?', (session['user_id'],)).fetchone()
    operator_name = operator_name['username'] if operator_name else 'unknown'
    
    db.execute('''
        INSERT INTO replenishment_logs (channel_id, operator_id, operator_name, before_qty, after_qty, quantity_added, method, notes)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ''', (cid, session['user_id'], operator_name, before_qty, new_qty, new_qty - before_qty, 'manual', data.get('notes', '库存调整')))
    
    db.commit()
    db.close()
    
    return jsonify({'success': True, 'data': {'current_qty': new_qty}})

@app.route('/admin/api/channel/<int:cid>/logs', methods=['GET'])
def api_get_channel_logs(cid):
    """获取货道补货记录"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'error': 'unauthorized'}), 401
    
    db = get_db()
    logs = db.execute('''
        SELECT * FROM replenishment_logs 
        WHERE channel_id = ?
        ORDER BY created_at DESC
        LIMIT 50
    ''', (cid,)).fetchall()
    db.close()
    
    return jsonify({
        'success': True,
        'data': [{
            'id': log['id'],
            'before_qty': log['before_qty'],
            'after_qty': log['after_qty'],
            'quantity_added': log['quantity_added'],
            'operator_name': log['operator_name'],
            'method': log['method'],
            'notes': log['notes'],
            'created_at': log['created_at']
        } for log in logs]
    })

# --- 设备数据上报API（4G设备调用）---
@app.route('/api/device/inventory-report', methods=['POST'])
def api_device_inventory_report():
    """设备定期上报库存（4G模块调用，无需登录）"""
    data = request.get_json()
    if not data or 'imei' not in data:
        return jsonify({'success': False, 'error': 'imei required'}), 400
    
    db = get_db()
    
    # 通过IMEI查找机器
    machine = db.execute('SELECT id FROM machines WHERE imei = ?', (data['imei'],)).fetchone()
    if not machine:
        db.close()
        return jsonify({'success': False, 'error': 'machine not found'}), 404
    
    machine_id = machine['id']
    
    # 更新机器最后上报时间
    db.execute('UPDATE machines SET last_inventory_report = CURRENT_TIMESTAMP WHERE id = ?', (machine_id,))
    
    # 更新各货道库存
    if 'channels' in data:
        for ch in data['channels']:
            channel = db.execute('SELECT id, max_qty FROM channels WHERE machine_id = ? AND channel_no = ?', 
                               (machine_id, ch['no'])).fetchone()
            if channel:
                qty = min(int(ch['qty']), channel['max_qty'])
                inv = db.execute('SELECT id FROM inventory WHERE channel_id = ?', (channel['id'],)).fetchone()
                if inv:
                    db.execute('UPDATE inventory SET current_qty = ?, last_updated = CURRENT_TIMESTAMP WHERE channel_id = ?', 
                              (qty, channel['id']))
                else:
                    db.execute('INSERT INTO inventory (channel_id, current_qty) VALUES (?, ?)', (channel['id'], qty))
    
    db.commit()
    db.close()
    
    return jsonify({'success': True, 'message': 'inventory updated'})

# --- 全局库存统计API ---
@app.route('/admin/api/inventory/all-stats', methods=['GET'])
def api_inventory_all_stats():
    """获取所有机器的库存统计（仪表盘用）"""
    if 'user_id' not in session:
        return jsonify({'success': False, 'error': 'unauthorized'}), 401
    
    db = get_db()
    
    # 统计各状态货道数
    stats = db.execute('''
        SELECT 
            COUNT(*) as total_channels,
            SUM(CASE WHEN i.current_qty >= c.low_stock_threshold THEN 1 ELSE 0 END) as normal_channels,
            SUM(CASE WHEN i.current_qty < c.low_stock_threshold AND i.current_qty > 0 THEN 1 ELSE 0 END) as low_stock_channels,
            SUM(CASE WHEN i.current_qty = 0 OR i.current_qty IS NULL THEN 1 ELSE 0 END) as empty_channels,
            SUM(i.current_qty) as total_qty
        FROM channels c
        LEFT JOIN inventory i ON c.id = i.channel_id
    ''').fetchone()
    
    # 低库存告警列表
    alerts = db.execute('''
        SELECT c.id, c.channel_no, c.product_name, c.machine_id, m.name as machine_name,
               i.current_qty, c.low_stock_threshold, c.max_qty
        FROM channels c
        LEFT JOIN inventory i ON c.id = i.channel_id
        LEFT JOIN machines m ON c.machine_id = m.id
        WHERE i.current_qty < c.low_stock_threshold OR i.current_qty IS NULL OR i.current_qty = 0
        ORDER BY CASE WHEN i.current_qty IS NULL OR i.current_qty = 0 THEN 0 ELSE 1 END, i.current_qty ASC
        LIMIT 20
    ''').fetchall()
    
    db.close()
    
    return jsonify({
        'success': True,
        'data': {
            'total_channels': stats['total_channels'],
            'normal_channels': stats['normal_channels'] or 0,
            'low_stock_channels': stats['low_stock_channels'] or 0,
            'empty_channels': stats['empty_channels'] or 0,
            'total_qty': stats['total_qty'] or 0,
            'alerts': [{
                'channel_id': a['id'],
                'channel_no': a['channel_no'],
                'product_name': a['product_name'],
                'machine_id': a['machine_id'],
                'machine_name': a['machine_name'],
                'current_qty': a['current_qty'] or 0,
                'low_stock_threshold': a['low_stock_threshold'],
                'max_qty': a['max_qty'],
                'level': 'critical' if (a['current_qty'] or 0) == 0 else 'warning'
            } for a in alerts]
        }
    })
