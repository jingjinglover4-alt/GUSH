#!/bin/bash
# Orange Pi硬件代理安装脚本

set -e

echo "安装HI拿硬件代理服务到Orange Pi"

# 创建目录
sudo mkdir -p /opt/hinana-vending
sudo mkdir -p /etc/hinana
sudo mkdir -p /var/log

# 复制文件
sudo cp hardware_agent.py /opt/hinana-vending/
sudo cp hardware-agent.service /etc/systemd/system/

# 配置硬件
if [ ! -f /etc/hinana/hardware.conf ]; then
    echo "创建硬件配置文件..."
    sudo cp hardware.conf.example /etc/hinana/hardware.conf
    echo "请编辑 /etc/hinana/hardware.conf 配置您的硬件信息"
    echo "重要: 需要设置正确的IMEI、SN和令牌"
fi

# 安装Python依赖
echo "安装Python依赖..."
if command -v pip3 &> /dev/null; then
    sudo pip3 install websockets requests pyyaml pyserial
else
    echo "警告: pip3未找到，尝试使用pip"
    sudo pip install websockets requests pyyaml pyserial
fi

# 启用服务
echo "启用硬件代理服务..."
sudo systemctl daemon-reload
sudo systemctl enable hardware-agent

echo "安装完成!"
echo "下一步:"
echo "1. 编辑配置文件: sudo nano /etc/hinana/hardware.conf"
echo "2. 配置正确的IMEI、SN和令牌"
echo "3. 启动服务: sudo systemctl start hardware-agent"
echo "4. 检查状态: sudo systemctl status hardware-agent"
echo "5. 查看日志: sudo journalctl -u hardware-agent -f"
