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

## 第二部分：硬件令牌管理

### 1. 生成新的硬件令牌
**重要**：部署前必须为每个硬件生成唯一的令牌，不要使用示例令牌。

在服务器上运行令牌生成脚本：

```bash
cd /opt/hardware-gateway

# 为硬件生成令牌（使用实际IMEI和SN）
python3 generate_token.py 865709045268307 MP0623472DF9B5F --redis-url redis://localhost:6379/0

# 或使用自定义参数
python3 generate_token.py <IMEI> <SN> --secret <your-secret> --expire-days 30 --output-config
```

**参数说明**：
- `<IMEI>`：15位数字IMEI（如：865709045268307）
- `<SN>`：硬件序列号（如：MP0623472DF9B5F）
- `--secret`：令牌生成密钥（默认：hardware-token-secret-2026）
- `--expire-days`：令牌有效期（默认：30天）
- `--output-config`：输出配置文件片段

**输出示例**：
```
硬件令牌生成成功!
==================================================
IMEI: 865709045268307
序列号: MP0623472DF9B5F
令牌: hw_5f8a3c9e1b7d2a4f6c8e9b0a
有效期: 30天
Redis键: hardware_token:865709045268307
```

### 2. 更新硬件配置文件
在Orange Pi上编辑配置文件 `/etc/hinana/hardware.conf`：

```yaml
# 硬件标识
imei: "865709045268307"
sn: "MP0623472DF9B5F"

# 服务器连接  
server_url: "wss://cdgushai.com:5003"  # 生产环境（SSL）
# server_url: "ws://150.158.20.232:5003"  # 测试环境（HTTP）
token: "hw_5f8a3c9e1b7d2a4f6c8e9b0a"  # ← 替换为生成的令牌

# 本地API配置
local_api_url: "http://localhost:8080"
```

### 3. 令牌管理命令

**查看现有令牌**：
```bash
redis-cli KEYS 'hardware_token:*'
redis-cli GET 'hardware_token:865709045268307'
```

**删除令牌**：
```bash
redis-cli DEL 'hardware_token:865709045268307'
```

**更新令牌**：重新运行生成脚本，会自动覆盖旧令牌。

### 4. 数据库令牌同步
令牌也会自动保存到SQLite数据库 `hardware_tokens` 表中，可通过管理后台查看：
```sql
SELECT imei, serial_number, expires_at FROM hardware_tokens WHERE is_active = 1;
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
   - 确认已为硬件生成令牌：`python3 generate_token.py <IMEI> <SN>`
   - 检查Redis中令牌是否存在：`redis-cli GET 'hardware_token:<IMEI>'`
   - 验证硬件配置文件中的令牌与Redis中一致
   - 确认IMEI和SN匹配
   - 令牌可能已过期（默认30天），重新生成令牌

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