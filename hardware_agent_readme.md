# HI拿硬件代理安装指南

## 概述
硬件代理服务运行在Orange Pi上，通过4G模块连接云端服务器，实现远程控制派样机硬件。

## 系统要求
- Orange Pi 3B V2.1 (或其他Linux设备)
- Python 3.7+
- 网络连接（4G/WiFi）

## 快速安装
在Orange Pi上执行以下命令：

```bash
# 下载并执行一键安装脚本
curl -s http://150.158.20.232/static/deploy_hardware_agent.sh | sudo bash
```

或分步安装：

```bash
# 1. 下载安装包
cd /tmp
wget http://150.158.20.232/static/hardware-agent-package.tar.gz

# 2. 解压
tar xzf hardware-agent-package.tar.gz

# 3. 安装依赖
sudo apt-get update
sudo apt-get install -y python3-pip python3-dev
sudo pip3 install python-socketio[asyncio_client] aiohttp requests pyyaml pyserial

# 4. 部署文件
sudo mkdir -p /opt/hinana-vending
sudo cp hardware_agent.py /opt/hinana-vending/
sudo chmod +x /opt/hinana-vending/hardware_agent.py

# 5. 配置
sudo mkdir -p /etc/hinana
sudo cp hardware.conf.example /etc/hinana/hardware.conf
# 编辑配置文件（见下文）

# 6. 安装systemd服务
sudo cp hardware-agent.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable hardware-agent
sudo systemctl start hardware-agent
```

## 配置文件
编辑 `/etc/hinana/hardware.conf`：

```yaml
# HI拿硬件配置
server_url: ws://150.158.20.232:8003
imei: 865709045268307  # 4G模块IMEI
sn: MP0623472DF9B5F    # 4G模块序列号
token: hw_68b163d8516931a06465dbc0  # 硬件令牌（30天有效）
```

**重要**：请根据实际硬件修改 `imei` 和 `sn` 参数。

## 服务管理
```bash
# 启动服务
sudo systemctl start hardware-agent

# 停止服务
sudo systemctl stop hardware-agent

# 重启服务
sudo systemctl restart hardware-agent

# 查看状态
sudo systemctl status hardware-agent

# 查看日志
sudo journalctl -u hardware-agent -f
```

## 故障排除
1. **连接失败**：检查网络连接和服务器地址
2. **依赖错误**：确保已安装所有Python依赖
3. **权限问题**：使用sudo执行命令
4. **服务无法启动**：检查日志 `journalctl -u hardware-agent`

## 文件说明
- `hardware_agent.py` - 硬件代理主程序
- `hardware.conf.example` - 配置文件示例
- `hardware-agent.service` - systemd服务文件

## 技术支持
联系系统管理员或查看服务器日志。