# HI拿4G远程控制与调试系统

基于华为E8372-821 4G模块实现的硬件远程控制、实时监控和调试系统。

## 🎯 系统目标

通过4G网络实现硬件（Orange Pi + STM32）与云端服务器的**安全、稳定、低延迟**双向通信，支持：
- ✅ **远程实时控制**：发送出货指令、查询状态、配置更新
- ✅ **远程调试监控**：查看硬件日志、系统状态、网络质量  
- ✅ **自动故障恢复**：断线重连、心跳检测、离线缓存
- ✅ **安全通信**：硬件令牌认证、TLS加密、指令签名

## 📡 系统架构

```
┌─────────────────────────────────────────────────────────────┐
│                    云端服务器 (150.158.20.232)               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │ 硬件网关服务 │  │  管理后台    │  │  小程序API   │        │
│  │  (端口5003) │  │  (端口5001)  │  │  (端口5002)  │        │
│  │ WebSocket   │◄─┤  硬件监控    │  │             │        │
│  │ 服务端      │  │  远程控制    │  │             │        │
│  └──────┬──────┘  └─────────────┘  └─────────────┘        │
│         │                                                    │
│    WSS over 4G                                               │
│         │                                                    │
└─────────┼────────────────────────────────────────────────────┘
          │
┌─────────┼────────────────────────────────────────────────────┐
│ Orange Pi 3B (硬件端)                                         │
│  ┌─────────────┐       ┌─────────────┐                     │
│  │  硬件代理服务 │◄─────►│ local_api.py │                     │
│  │ WebSocket   │ HTTP  │ (端口8080)   │                     │
│  │ 客户端       │       │ 串口通信STM32 │                     │
│  └──────┬──────┘       └─────────────┘                     │
│         │                                                    │
│    USB连接                                                   │
│         │                                                    │
│  ┌──────┴──────┐                                            │
│  │ 华为E8372-821│                                            │
│  │ 4G模块      │                                            │
│  │ IP:192.168.0.1 │                                          │
│  └─────────────┘                                            │
└─────────────────────────────────────────────────────────────┘
```

## 📁 文件结构

### 服务器端（硬件网关）
```
hardware-gateway/
├── app.py              # 主应用：Flask + SocketIO
├── config.py           # 配置管理
├── hardware_manager.py # 硬件连接管理
├── security.py         # 安全认证和加密
├── models.py           # 数据库模型（扩展现有DB）
├── requirements.txt    # Python依赖
├── .env.example        # 环境变量示例
├── hardware-gateway.service  # Systemd服务配置
├── init_database.py    # 数据库初始化
└── deploy_server.sh    # 部署脚本
```

### 硬件端（Orange Pi代理）
```
hardware-agent-package/          # 部署包
├── hardware_agent.py           # 硬件代理主程序
├── hardware.conf.example       # 配置文件示例
├── hardware-agent.service      # Systemd服务配置
└── install-on-orange-pi.sh     # 安装脚本
```

## 🚀 快速开始

### 第一阶段：服务器部署（1-2天）

1. **准备环境**：
   ```bash
   # 在服务器上安装依赖
   sudo apt update
   sudo apt install python3-pip redis-server
   sudo pip3 install virtualenv
   ```

2. **部署硬件网关**：
   ```bash
   # 本地运行部署脚本
   cd hardware-gateway
   chmod +x deploy_server.sh
   ./deploy_server.sh
   
   # 选择选项1：部署服务器端硬件网关
   ```

3. **配置Nginx**（如果需要HTTPS）：
   ```bash
   # 将生成的nginx-hw-gateway.conf添加到Nginx
   sudo cp nginx-hw-gateway.conf /etc/nginx/sites-available/
   sudo ln -s /etc/nginx/sites-available/nginx-hw-gateway.conf /etc/nginx/sites-enabled/
   sudo nginx -t && sudo systemctl reload nginx
   ```

4. **启动服务**：
   ```bash
   # 在服务器上
   sudo systemctl start hardware-gateway
   sudo systemctl enable hardware-gateway
   sudo systemctl status hardware-gateway
   ```

### 第二阶段：硬件部署（2-3天）

1. **准备硬件包**：
   ```bash
   # 生成硬件代理部署包
   ./deploy_server.sh
   # 选择选项2：生成硬件代理部署包
   
   # 将hardware-agent-package/复制到Orange Pi
   scp -r hardware-agent-package/ root@orange-pi-ip:~/
   ```

2. **在Orange Pi上安装**：
   ```bash
   # 登录Orange Pi
   cd ~/hardware-agent-package
   sudo bash install-on-orange-pi.sh
   
   # 编辑配置文件
   sudo nano /etc/hinana/hardware.conf
   ```

3. **配置硬件信息**：
   ```yaml
   # /etc/hinana/hardware.conf
   imei: "865709045268307"  # 4G模块IMEI
   sn: "MP0623472DF9B5F"    # 序列号
   token: "hw_abc123def456" # 从管理后台获取
   server_url: "wss://cdgushai.com:5003"  # 生产环境
   # server_url: "ws://150.158.20.232:5003"  # 测试环境（HTTP）
   ```

4. **启动硬件代理**：
   ```bash
   sudo systemctl start hardware-agent
   sudo systemctl enable hardware-agent
   sudo journalctl -u hardware-agent -f
   ```

### 第三阶段：管理后台集成（1-2天）

1. **扩展管理后台**：
   - 添加硬件监控页面
   - 集成远程控制界面
   - 添加实时日志查看器

2. **生成硬件令牌**：
   ```bash
   # 在管理后台添加功能，或使用脚本
   ./deploy_server.sh
   # 选择选项3：生成硬件令牌示例
   ```

## 🔐 安全机制

### 1. 认证流程
```
硬件启动 → 读取配置文件(IMEI+SN+Token) → 连接服务器WSS → 
发送注册信息 → 服务器验证令牌 → 建立安全连接 → 开始心跳
```

### 2. 多层防护
- **传输加密**：强制WSS（WebSocket over TLS）
- **硬件令牌**：每个硬件唯一，30天有效期
- **指令签名**：重要指令使用HMAC-SHA256签名
- **速率限制**：每分钟最多60条消息
- **IP白名单**：可选，限制连接来源

### 3. 令牌管理
```python
# 生成硬件令牌
def generate_hardware_token(imei, sn, secret):
    salt = secrets.token_hex(16)
    raw = f"{imei}:{sn}:{secret}:{salt}"
    token_hash = hashlib.sha256(raw.encode()).hexdigest()
    return f"hw_{token_hash[:24]}"
```

## 📡 通信协议

### 消息格式（JSON）
```json
// 硬件 → 服务器
{
  "type": "register|heartbeat|command_response|log",
  "imei": "865709045268307",
  "timestamp": "2026-04-01T13:41:00Z",
  "data": { ... }
}

// 服务器 → 硬件  
{
  "type": "command",
  "command_id": "cmd_20260401_001",
  "command_type": "dispense|query|update",
  "data": { "channel": "A0" },
  "timestamp": "2026-04-01T13:41:00Z",
  "ttl": 30
}
```

### 支持的命令类型
| 命令类型 | 用途 | 响应要求 |
|---------|------|---------|
| `dispense` | 出货指令 | 立即返回结果 |
| `query_inventory` | 查询库存 | 返回各货道状态 |
| `query_status` | 硬件状态 | 返回健康指标 |
| `update_config` | 更新配置 | 重启后生效确认 |
| `reboot` | 重启硬件 | 重启前确认 |
| `upload_logs` | 上传日志 | 分批次上传 |
| `diagnostic` | 诊断测试 | 返回测试结果 |

## 🔧 硬件代理功能

### 系统监控
- ✅ CPU温度监控
- ✅ 内存使用率
- ✅ 磁盘空间
- ✅ 4G信号强度（RSSI）
- ✅ STM32连接状态
- ✅ 系统运行时间

### 自动恢复
- ✅ 断线自动重连（指数退避）
- ✅ 心跳保活（30秒间隔）
- ✅ 命令队列（硬件离线时缓存）
- ✅ 自诊断和错误报告

### 日志管理
- ✅ 本地日志文件（/var/log/hardware-agent.log）
- ✅ 实时日志上传到服务器
- ✅ 日志级别控制（DEBUG/INFO/WARNING/ERROR）
- ✅ 日志轮转（防止磁盘写满）

## 📊 性能指标

| 指标 | 目标值 | 监控方式 |
|------|--------|----------|
| 连接成功率 | >99.5% | 连接日志分析 |
| 平均延迟 | <500ms | 心跳包时间戳差 |
| 断线重连时间 | <30秒 | 连接恢复时间 |
| 命令成功率 | >99% | 命令响应统计 |
| 7×24运行时间 | >99.9% | 系统监控 |

## 🚨 故障排除

### 常见问题

1. **连接失败**
   ```
   检查项：
   - 4G网络连通性：ping 150.158.20.232
   - 硬件令牌是否正确
   - 服务器端口5003是否开放
   - 防火墙/安全组配置
   ```

2. **指令超时**
   ```
   可能原因：
   - 网络延迟过高
   - STM32无响应
   - 本地API服务异常
   解决方案：
   - 检查信号强度
   - 重启local_api.py服务
   - 增加命令超时时间
   ```

3. **硬件离线**
   ```
   诊断步骤：
   1. SSH登录Orange Pi
   2. 检查服务状态：systemctl status hardware-agent
   3. 查看日志：journalctl -u hardware-agent -f
   4. 检查4G模块：lsusb | grep Huawei
   5. 手动测试连接：python3 -c "import socketio; ..."
   ```

### 监控命令
```bash
# 服务器端
sudo systemctl status hardware-gateway
sudo journalctl -u hardware-gateway -f
sudo netstat -tlnp | grep :5003

# 硬件端
sudo systemctl status hardware-agent
sudo journalctl -u hardware-agent -f
ping -c 4 150.158.20.232
```

## 📈 扩展计划

### 短期优化（1个月内）
1. 管理后台硬件监控面板
2. 批量命令执行功能
3. 历史数据分析和报表
4. 自动告警系统（邮件/微信）

### 中期功能（1-3个月）
1. 固件OTA升级系统
2. 边缘计算能力（本地决策）
3. 多运营商备份（双4G模块）
4. 地理位置追踪

### 长期规划（3-6个月）
1. AI异常检测
2. 预测性维护
3. 区块链操作审计
4. 5G网络升级支持

## 📝 开发记录

### 2026-04-01
- ✅ 完成硬件网关服务架构设计
- ✅ 实现服务器端WebSocket网关
- ✅ 实现硬件代理客户端
- ✅ 设计安全认证机制
- ✅ 创建部署脚本和文档
- ✅ 数据库模型设计

### 下一步
1. 实际部署测试服务器端
2. 配置Orange Pi 4G模块
3. 集成管理后台监控界面
4. 进行端到端功能测试

## 📞 支持与联系

如有问题或需要技术支持，请：
1. 查看日志文件定位问题
2. 检查网络连接和配置
3. 参考故障排除章节
4. 联系开发团队

---

**系统设计：后端架构师** 🏗️  
**版本：1.0.0**  
**最后更新：2026-04-01**