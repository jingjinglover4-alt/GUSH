# HI拿硬件代理部署说明

## 文件说明
- `hardware_agent.py` - 硬件代理主程序
- `hardware.conf.example` - 配置文件示例
- `hardware-agent.service` - Systemd服务配置
- `install-on-orange-pi.sh` - 安装脚本

## 安装步骤
1. 将整个目录复制到Orange Pi
2. 运行安装脚本: `sudo bash install-on-orange-pi.sh`
3. 编辑配置文件: `sudo nano /etc/hinana/hardware.conf`
4. 配置以下关键信息:
   - `imei`: 4G模块IMEI (如: 865709045268307)
   - `sn`: 序列号 (如: MP0623472DF9B5F)
   - `token`: 从管理后台获取的硬件令牌
   - `server_url`: 硬件网关地址 (如: wss://150.158.20.232:5003)
5. 启动服务: `sudo systemctl start hardware-agent`

## 验证安装
1. 检查服务状态: `sudo systemctl status hardware-agent`
2. 查看日志: `sudo journalctl -u hardware-agent -f`
3. 在管理后台查看硬件是否在线

## 故障排除
1. 如果连接失败，检查网络连通性: `ping 150.158.20.232`
2. 检查4G模块是否正常工作: `lsusb | grep Huawei`
3. 验证令牌是否正确
