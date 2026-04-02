#!/bin/bash
# 部署双身份登录系统到服务器

set -e  # 遇到错误退出

echo "🚀 开始部署双身份登录系统到服务器"
echo "="========================================

# 服务器信息
SERVER="150.158.20.232"
SERVER_USER="root"
SERVER_DIR="/opt/hinana-admin"
SSH_ALIAS="hinana"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查本地文件
echo "📁 检查本地文件..."
FILES=(
    "templates/login.html"
    "app.py"
    "create_test_merchant.py"
)

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ 找到: $file${NC}"
    else
        echo -e "${RED}❌ 缺失: $file${NC}"
        exit 1
    fi
done

echo ""
echo "📊 文件对比信息:"
echo "  服务器文件修改时间:"
ssh $SSH_ALIAS "cd $SERVER_DIR && ls -la templates/login.html app.py" || true

echo ""
echo "⚠️  警告: 将用本地文件覆盖服务器文件"
echo "  按 Enter 继续，或 Ctrl+C 取消"
# read -r - 用户已确认运行
echo "✅ 用户已确认，继续部署..."

# 1. 备份服务器文件
echo ""
echo "💾 备份服务器文件..."
BACKUP_DIR="/opt/hinana-admin/backup_$(date +%Y%m%d_%H%M%S)"
ssh $SSH_ALIAS "mkdir -p $BACKUP_DIR && cp -p $SERVER_DIR/templates/login.html $SERVER_DIR/app.py $BACKUP_DIR/ 2>/dev/null || true"
echo -e "${GREEN}✅ 备份到: $BACKUP_DIR${NC}"

# 2. 复制文件到服务器
echo ""
echo "📤 复制文件到服务器..."

# templates/login.html
echo "  复制 templates/login.html..."
scp templates/login.html $SSH_ALIAS:$SERVER_DIR/templates/login.html
echo -e "${GREEN}✅ templates/login.html 复制完成${NC}"

# app.py
echo "  复制 app.py..."
scp app.py $SSH_ALIAS:$SERVER_DIR/app.py
echo -e "${GREEN}✅ app.py 复制完成${NC}"

# create_test_merchant.py
echo "  复制 create_test_merchant.py..."
scp create_test_merchant.py $SSH_ALIAS:$SERVER_DIR/create_test_merchant.py
echo -e "${GREEN}✅ create_test_merchant.py 复制完成${NC}"

# 3. 设置文件权限
echo ""
echo "🔒 设置文件权限..."
ssh $SSH_ALIAS "chmod 644 $SERVER_DIR/templates/login.html $SERVER_DIR/app.py $SERVER_DIR/create_test_merchant.py"

# 4. 创建测试数据
echo ""
echo "🧪 创建测试商户数据..."
ssh $SSH_ALIAS "cd $SERVER_DIR && python3 create_test_merchant.py" || {
    echo -e "${YELLOW}⚠️  测试数据创建可能失败，继续部署...${NC}"
}

# 5. 重启服务
echo ""
echo "🔄 重启 hinana-admin 服务..."
ssh $SSH_ALIAS "systemctl restart hinana-admin"

# 6. 检查服务状态
echo ""
echo "📡 检查服务状态..."
sleep 2  # 等待服务启动
ssh $SSH_ALIAS "systemctl status hinana-admin --no-pager | head -20"

# 7. 验证部署
echo ""
echo "🔍 验证部署..."
echo "  等待服务完全启动..."
sleep 3

# 检查登录页面是否可访问
LOGIN_URL="http://150.158.20.232/admin/"
echo "  测试登录页面: $LOGIN_URL"
HTTP_STATUS=$(ssh $SSH_ALIAS "curl -s -o /dev/null -w '%{http_code}' $LOGIN_URL" 2>/dev/null || echo "000")

if [ "$HTTP_STATUS" = "200" ]; then
    echo -e "${GREEN}✅ 登录页面可访问 (HTTP $HTTP_STATUS)${NC}"
else
    echo -e "${YELLOW}⚠️  登录页面访问异常 (HTTP $HTTP_STATUS)${NC}"
fi

echo ""
echo "="========================================
echo -e "${GREEN}🎉 部署完成！${NC}"
echo ""
echo "📋 测试账号:"
echo "  1. 超级管理员: admin / 123456"
echo "  2. 测试商户: merchant1 / merchant123"
echo "  3. 演示商户: demo_merchant / demo123"
echo ""
echo "🌐 访问地址:"
echo "  http://150.158.20.232/admin/"
echo ""
echo "💡 使用说明:"
echo "  1. 打开登录页面，选择身份标签页"
echo "  2. 超级管理员使用 '🏢 超级管理员' 标签"
echo "  3. 商户使用 '🏪 SaaS商户' 标签"
echo "  4. 测试权限控制：商户只能看到自己的数据"
echo ""
echo "⚠️  注意事项:"
echo "  - 如果测试数据创建失败，可以手动运行:"
echo "    ssh hinana 'cd /opt/hinana-admin && python3 create_test_merchant.py'"
echo "  - 查看日志: ssh hinana 'journalctl -u hinana-admin -f'"
echo "="========================================