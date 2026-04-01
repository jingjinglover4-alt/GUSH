# HI拿4G远程控制系统部署指南

## 系统架构

- **硬件网关服务器**：运行在150.158.20.232:8003（HTTP WebSocket），Nginx代理5003端口（WSS）
- **硬件代理**：运行在Orange Pi上，连接服务器，执行远程命令
- **管理后台**：现有管理后台可查看硬件状态和发送命令

## 第一部分：服务器端部署（已完成）

### 1. 硬件网关服务
- 服务已部署在：`/opt/hardware-gateway/`
- 端口：8003（内部），5003（外部SSL）
- Systemd服务：`hardware-gateway`
- 状态：**已启动并运行**

### 2. Redis服务
- 状态：**已启动并运行**

### 3. 数据库扩展
- 已添加5张硬件相关表到现有数据库
- 测试硬件令牌已插入（IMEI: 865709045268307, SN: MP0623472DF9B5F）

### 4. Nginx配置
- 配置文件：`/www/server/panel/vhost/nginx/hardware-gateway.conf`
- 外部访问：`wss://cdgushai.com:5003`（SSL）
- **注意**：当前Nginx配置可能未生效，请检查端口监听情况

## 第二部分：Orange Pi硬件代理部署

### 1. 准备部署包
部署包已生成：`hardware-agent-package.tar.gz`
包含文件：
- `hardware_agent.py` - 硬件代理主程序
- `hardware.conf.example` - 配置文件示例（已预配置）
- `hardware-agent.service` - Systemd服务配置
- `install-on-orange-pi.sh` - 安装脚本
- `README.md` - 详细说明

### 2. 传输到Orange Pi
将部署包复制到Orange Pi（任选一种方式）：

**方式A：通过SCP传输**
```bash
# 从本地计算机执行
scp hardware-agent-package.tar.gz root@orange-pi-ip:/tmp/
```

**方式B：通过USB闪存盘**
1. 将`hardware-agent-package.tar.gz`复制到U盘
2. 插入Orange Pi，挂载U盘
3. 复制文件到`/tmp/`

**方式C：通过SD卡**
1. 将文件复制到SD卡（通过读卡器）
2. 插入Orange Pi
3. 复制文件

### 3. 安装硬件代理
在Orange Pi上执行：

```bash
# 进入临时目录
cd /tmp

# 解压部署包
tar xzf hardware-agent-package.tar.gz

# 进入目录
cd hardware-agent-package

# 运行安装脚本
sudo bash install-on-orange-pi.sh
```

安装脚本将：
1. 创建目录：`/opt/hinana-vending/`，`/etc/hinana/`
2. 复制文件到相应位置
3. 安装Python依赖（websockets, requests, pyyaml, pyserial）
4. 启用Systemd服务

### 4. 配置硬件信息
配置文件已预置以下关键信息：
- IMEI: `865709045268307`
- SN: `MP0623472DF9B5F`
- 令牌: `hw_6494e75d8dc12fabad4f0c9310`
- 服务器地址: `ws://150.158.20.232:8003`

**如需修改配置**：
```bash
sudo nano /etc/hinana/hardware.conf
```

重要检查项：
- `modem_device` - 4G模块设备路径（默认`/dev/ttyUSB2`）
- `stm32_device` - STM32串口设备路径（默认`/dev/ttyUSB0`）

### 5. 启动服务
```bash
# 启动服务
sudo systemctl start hardware-agent

# 设置开机自启
sudo systemctl enable hardware-agent

# 检查状态
sudo systemctl status hardware-agent

# 查看日志
sudo journalctl -u hardware-agent -f
```

## 第三部分：验证与测试

### 1. 检查硬件连接状态
在服务器上查看硬件是否在线：
```bash
# 查看Redis中的令牌
redis-cli GET 'hardware_token:865709045268307'

# 查看硬件连接
redis-cli KEYS 'hardware_active:*'
```

### 2. 发送测试命令
通过管理后台或直接API发送测试命令：

**HTTP API示例**：
```bash
curl -X POST http://localhost:8003/api/command \
  -H "Content-Type: application/json" \
  -d '{
    "imei": "865709045268307",
    "command_type": "system_info",
    "command_data": "{}"
  }'
```

### 3. 监控日志
**服务器端**：
```bash
journalctl -u hardware-gateway -f
```

**Orange Pi端**：
```bash
journalctl -u hardware-agent -f
```

## 第四部分：故障排除

### 常见问题

1. **连接失败**
   - 检查网络连通性：`ping 150.158.20.232`
   - 检查端口开放：`telnet 150.158.20.232 8003`
   - 查看防火墙设置

2. **认证失败**
   - 确认令牌正确：`hw_6494e75d8dc12fabad4f0c9310`
   - 检查Redis中令牌是否存在
   - 验证IMEI和SN匹配

3. **串口通信失败**
   - 检查设备权限：`ls -la /dev/ttyUSB*`
   - 添加用户到dialout组：`sudo usermod -a -G dialout $USER`
   - 检查波特率设置

4. **4G模块未检测到**
   - 检查USB连接：`lsusb | grep Huawei`
   - 查看内核日志：`dmesg | grep ttyUSB`
   - 尝试不同设备路径：`/dev/ttyUSB0`、`/dev/ttyUSB1`

### 日志位置
- 服务器网关日志：`/var/log/hardware-gateway.log`
- 硬件代理日志：`/var/log/hardware-agent.log`
- Systemd日志：`journalctl -u service-name`

## 第五部分：后续开发

### 1. 管理后台集成
将硬件监控和控制界面集成到现有管理后台：
- 添加硬件状态页面
- 实现远程命令发送界面
- 添加实时日志查看功能

### 2. 安全性增强
- 启用WSS（WebSocket Secure）连接
- 实现双向证书认证
- 添加命令签名验证

### 3. 功能扩展
- 实时视频流传输
- 远程文件传输
- 批量硬件管理
- 自动化运维脚本

## 技术支持

- 服务器IP：150.158.20.232
- SSH别名：`ssh hinana`
- 数据库路径：`/opt/hinana-admin/instance/hinana.db`
- 项目代码：`/Users/zhaoshiyu/WorkBuddy/Claw/hardware-gateway/`

**重要提醒**：
1. 生产环境请启用SSL（WSS）
2. 定期更新硬件令牌
3. 监控硬件连接状态
4. 备份数据库和配置文件

---

*部署完成时间：2026年4月1日*
*版本：v1.0.0*