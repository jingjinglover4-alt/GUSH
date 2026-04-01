#!/bin/bash
# HI拿硬件网关服务器部署脚本

set -e  # 出错时退出

echo "========== HI拿硬件网关服务器部署 =========="
echo "目标服务器: 150.158.20.232"
echo "服务端口: 5003"
echo "==========================================="

# 配置变量
SERVER_IP="150.158.20.232"
SERVER_USER="root"
SERVICE_NAME="hardware-gateway"
INSTALL_DIR="/opt/hardware-gateway"
LOG_DIR="/var/log"
CONFIG_DIR="/etc/hinana"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查本地文件
check_local_files() {
    print_info "检查本地文件..."
    
    local required_files=(
        "app.py"
        "config.py"
        "hardware_manager.py"
        "security.py"
        "models.py"
        "requirements.txt"
        ".env.example"
        "hardware-gateway.service"
        "init_database.py"
    )
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            print_error "缺少文件: $file"
            exit 1
        fi
    done
    
    print_info "本地文件检查完成"
}

# 准备部署包
prepare_deployment_package() {
    print_info "准备部署包..."
    
    # 创建临时目录
    TEMP_DIR=$(mktemp -d)
    DEPLOY_DIR="$TEMP_DIR/$SERVICE_NAME"
    
    mkdir -p "$DEPLOY_DIR"
    
    # 复制文件
    cp app.py config.py hardware_manager.py security.py models.py "$DEPLOY_DIR/"
    cp requirements.txt .env.example "$DEPLOY_DIR/"
    cp hardware-gateway.service "$DEPLOY_DIR/"
    cp init_database.py "$DEPLOY_DIR/"
    
    # 创建部署配置
    cat > "$DEPLOY_DIR/deploy_config.json" << EOF
{
    "service_name": "$SERVICE_NAME",
    "install_dir": "$INSTALL_DIR",
    "server_ip": "$SERVER_IP",
    "deploy_time": "$(date -Iseconds)",
    "version": "1.0.0"
}
EOF
    
    # 创建安装脚本
    cat > "$DEPLOY_DIR/install.sh" << 'EOF'
#!/bin/bash
# 硬件网关安装脚本（在服务器上运行）

set -e

INSTALL_DIR="/opt/hardware-gateway"
SERVICE_NAME="hardware-gateway"

echo "安装硬件网关服务到: $INSTALL_DIR"

# 创建目录
mkdir -p "$INSTALL_DIR"
mkdir -p "/var/log"

# 复制文件
cp -r . "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/"*.py

# 安装Python依赖
echo "安装Python依赖..."
cd "$INSTALL_DIR"
if command -v pip3 &> /dev/null; then
    pip3 install -r requirements.txt
else
    echo "警告: pip3未找到，尝试使用pip"
    pip install -r requirements.txt
fi

# 初始化数据库
echo "初始化数据库..."
python3 "$INSTALL_DIR/init_database.py"

# 配置环境变量
if [ ! -f "$INSTALL_DIR/.env" ]; then
    echo "复制环境变量示例文件..."
    cp "$INSTALL_DIR/.env.example" "$INSTALL_DIR/.env"
    echo "请编辑 $INSTALL_DIR/.env 文件配置您的设置"
fi

# 安装Systemd服务
echo "配置Systemd服务..."
cp "$INSTALL_DIR/hardware-gateway.service" /etc/systemd/system/
systemctl daemon-reload
systemctl enable $SERVICE_NAME

echo "安装完成!"
echo "下一步:"
echo "1. 编辑配置文件: nano $INSTALL_DIR/.env"
echo "2. 启动服务: systemctl start $SERVICE_NAME"
echo "3. 检查状态: systemctl status $SERVICE_NAME"
echo "4. 查看日志: journalctl -u $SERVICE_NAME -f"
EOF
    
    chmod +x "$DEPLOY_DIR/install.sh"
    
    print_info "部署包准备完成: $DEPLOY_DIR"
    echo "$DEPLOY_DIR"
}

# 部署到服务器
deploy_to_server() {
    local deploy_dir="$1"
    
    print_info "部署到服务器 $SERVER_IP..."
    
    # 检查SSH连接
    if ! ssh -o BatchMode=yes -o ConnectTimeout=5 $SERVER_USER@$SERVER_IP "echo 'SSH连接测试成功'" &> /dev/null; then
        print_error "SSH连接失败，请检查网络和密钥配置"
        exit 1
    fi
    
    # 创建远程目录
    ssh $SERVER_USER@$SERVER_IP "mkdir -p /tmp/deploy"
    
    # 上传文件
    print_info "上传文件..."
    scp -r "$deploy_dir" $SERVER_USER@$SERVER_IP:/tmp/deploy/
    
    # 在服务器上执行安装
    print_info "在服务器上执行安装..."
    ssh $SERVER_USER@$SERVER_IP "cd /tmp/deploy/$SERVICE_NAME && sudo bash install.sh"
    
    print_info "部署完成!"
}

# 配置Nginx（如果需要）
configure_nginx() {
    print_info "配置Nginx代理..."
    
    # 创建Nginx配置
    NGINX_CONFIG=$(cat << EOF
# 硬件网关WebSocket代理
server {
    listen 5003 ssl;
    server_name hardware-gateway.local;
    
    # SSL证书（需要配置）
    ssl_certificate /path/to/ssl/cert.pem;
    ssl_certificate_key /path/to/ssl/key.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    
    # WebSocket代理
    location / {
        proxy_pass http://127.0.0.1:8003;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        
        # 超时设置
        proxy_read_timeout 3600s;
        proxy_send_timeout 3600s;
        proxy_connect_timeout 75s;
    }
    
    # 健康检查
    location /api/health {
        proxy_pass http://127.0.0.1:8003/api/health;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF
)
    
    # 保存Nginx配置到本地
    echo "$NGINX_CONFIG" > "nginx-hw-gateway.conf"
    
    print_info "Nginx配置已生成: nginx-hw-gateway.conf"
    print_warn "请手动将此配置添加到Nginx并重新加载"
}

# 生成硬件令牌
generate_hardware_token() {
    print_info "生成硬件令牌示例..."
    
    cat > "generate_token.py" << 'EOF'
#!/usr/bin/env python3
import hashlib
import secrets

def generate_token(imei, sn, secret):
    """生成硬件令牌"""
    salt = secrets.token_hex(16)
    raw = f"{imei}:{sn}:{secret}:{salt}"
    token_hash = hashlib.sha256(raw.encode()).hexdigest()
    token = f"hw_{token_hash[:24]}"
    return token, salt

# 测试硬件信息
imei = "865709045268307"
sn = "MP0623472DF9B5F"
secret = "hardware-token-secret-2026"

token, salt = generate_token(imei, sn, secret)

print("硬件令牌生成示例:")
print(f"IMEI: {imei}")
print(f"SN: {sn}")
print(f"令牌: {token}")
print(f"Salt: {salt}")
print("\nSQL插入语句:")
print(f"INSERT INTO hardware_tokens (imei, serial_number, token_hash, salt, expires_at)")
print(f"VALUES ('{imei}', '{sn}', '{hashlib.sha256(f'{imei}:{sn}:{secret}:{salt}'.encode()).hexdigest()}', '{salt}', datetime('now', '+30 days'));")
EOF
    
    python3 generate_token.py
    print_info "令牌生成脚本已保存: generate_token.py"
}

# 创建硬件代理部署包
create_hardware_agent_package() {
    print_info "创建硬件代理部署包..."
    
    AGENT_DIR="hardware-agent-package"
    mkdir -p "$AGENT_DIR"
    
    # 复制硬件代理文件
    cp hardware_agent.py "$AGENT_DIR/"
    cp hardware.conf.example "$AGENT_DIR/"
    cp hardware-agent.service "$AGENT_DIR/"
    
    # 创建安装脚本
    cat > "$AGENT_DIR/install-on-orange-pi.sh" << 'EOF'
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
    sudo pip3 install "python-socketio[asyncio_client]" requests pyyaml pyserial
else
    echo "警告: pip3未找到，尝试使用pip"
    sudo pip install "python-socketio[asyncio_client]" requests pyyaml pyserial
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
EOF
    
    chmod +x "$AGENT_DIR/install-on-orange-pi.sh"
    
    # 创建部署说明
    cat > "$AGENT_DIR/README.md" << 'EOF'
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
EOF
    
    print_info "硬件代理部署包已创建: $AGENT_DIR/"
    print_info "将此目录复制到Orange Pi并运行安装脚本"
}

# 主函数
main() {
    echo "选择部署选项:"
    echo "1. 部署服务器端硬件网关"
    echo "2. 生成硬件代理部署包"
    echo "3. 生成硬件令牌示例"
    echo "4. 生成Nginx配置"
    echo "5. 全部执行"
    echo -n "请选择 [1-5]: "
    read choice
    
    case $choice in
        1)
            check_local_files
            deploy_dir=$(prepare_deployment_package)
            deploy_to_server "$deploy_dir"
            ;;
        2)
            create_hardware_agent_package
            ;;
        3)
            generate_hardware_token
            ;;
        4)
            configure_nginx
            ;;
        5)
            check_local_files
            deploy_dir=$(prepare_deployment_package)
            deploy_to_server "$deploy_dir"
            create_hardware_agent_package
            generate_hardware_token
            configure_nginx
            ;;
        *)
            print_error "无效选择"
            exit 1
            ;;
    esac
    
    print_info "部署流程完成!"
    print_info "请按照生成的说明完成后续配置"
}

# 执行主函数
main "$@"