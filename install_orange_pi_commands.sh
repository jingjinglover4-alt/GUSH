#!/bin/bash
# HI拿硬件代理安装命令 - 在Orange Pi终端中逐条执行

echo "=== HI拿硬件代理安装命令 === "
echo "请将以下命令逐条复制到Orange Pi终端中执行"
echo ""

echo "# 1. 下载安装包"
echo "cd /tmp"
echo "wget http://150.158.20.232/static/hardware-agent-package.tar.gz"
echo ""

echo "# 2. 解压安装包"  
echo "tar xzf hardware-agent-package.tar.gz"
echo "cd /tmp"
echo ""

echo "# 3. 安装依赖"
echo "sudo apt-get update"
echo "sudo apt-get install -y python3-pip python3-dev"
echo "sudo pip3 install python-socketio[asyncio_client] aiohttp requests pyyaml pyserial"
echo ""

echo "# 4. 验证依赖安装"
echo "python3 -c \"import socketio, aiohttp, requests, yaml, serial; print('所有依赖安装成功')\""
echo ""

echo "# 5. 部署文件"
echo "sudo mkdir -p /opt/hinana-vending"
echo "sudo cp /tmp/hardware_agent.py /opt/hinana-vending/"
echo "sudo chmod +x /opt/hinana-vending/hardware_agent.py"
echo ""

echo "# 6. 配置"
echo "sudo mkdir -p /etc/hinana"
echo "sudo cp /tmp/hardware.conf.example /etc/hinana/hardware.conf"
echo ""

echo "# 7. 编辑配置文件（重要！）"
echo "echo '请编辑配置文件，填写正确的硬件参数：'"
echo "echo 'sudo nano /etc/hinana/hardware.conf'"
echo "echo '需要修改的配置项：'"
echo "echo '  imei: \"865709045268307\"     # 4G模块IMEI'"
echo "echo '  sn: \"MP0623472DF9B5F\"       # 4G模块序列号'"
echo "echo '  server_url: \"ws://150.158.20.232:8003\"'"
echo "echo '  token: \"hw_68b163d8516931a06465dbc0\"'"
echo ""

echo "# 8. 安装systemd服务"
echo "sudo cp /tmp/hardware-agent.service /etc/systemd/system/"
echo "sudo systemctl daemon-reload"
echo "sudo systemctl enable hardware-agent"
echo "sudo systemctl start hardware-agent"
echo ""

echo "# 9. 检查状态"
echo "sudo systemctl status hardware-agent"
echo ""

echo "# 10. 查看日志"
echo "sudo journalctl -u hardware-agent -f --no-pager"
echo ""

echo "=== 安装完成 ==="
echo "如果遇到问题："
echo "1. 检查网络连接：ping 150.158.20.232"
echo "2. 检查依赖安装：python3 -c 'import socketio; print(socketio.__version__)'"
echo "3. 查看详细日志：sudo journalctl -u hardware-agent -n 50"