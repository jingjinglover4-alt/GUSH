#!/bin/bash
echo "🧪 HI拿系统前置验证脚本"
echo "======================================"

# 检查服务状态
echo "1. 检查后台服务状态..."
ssh hinana "systemctl status hinana-admin --no-pager | head -3" 2>&1 | grep "active (running)"
if [ $? -eq 0 ]; then
    echo "✅ 服务运行正常"
else
    echo "❌ 服务未运行或状态异常"
    exit 1
fi

# 测试表单登录功能
echo "2. 测试表单登录功能（基础登录）..."
response=$(ssh hinana "curl -s -X POST http://localhost:5001/admin/login -d 'username=admin&password=123456' -w '%{http_code}' -o /dev/null" 2>&1)
if [ "$response" = "302" ]; then
    echo "✅ 表单登录成功（返回302重定向）"
else
    echo "❌ 表单登录失败，状态码: $response"
    
    # 获取详细错误
    ssh hinana "curl -s -X POST http://localhost:5001/admin/login -d 'username=admin&password=123456' | head -50" 2>&1 | tail -10
    exit 1
fi

# 测试登录重定向
echo "3. 测试登录后重定向..."
redirect_url=$(ssh hinana "curl -s -X POST http://localhost:5001/admin/login -d 'username=admin&password=123456' -w '%{redirect_url}' -o /dev/null" 2>&1)
if [[ "$redirect_url" == */admin/dashboard* ]]; then
    echo "✅ 登录成功重定向路径正确: $redirect_url"
else
    echo "❌ 重定向路径不正确: $redirect_url"
fi

# 测试中控台页面访问
echo "4. 测试中控台页面..."
ctrl_status=$(ssh hinana "curl -s -o /dev/null -w '%{http_code}' http://localhost:5001/admin/control" 2>&1)
if [ "$ctrl_status" = "200" ]; then
    echo "✅ 中控台页面可访问"
else
    echo "⚠️  中控台页面返回状态码: $ctrl_status"
fi

# 检查数据库字段一致性
echo "5. 检查数据库字段一致性..."
db_fields=$(ssh hinana "cd /opt/hinana-admin && sqlite3 instance/hinana.db '.schema admin_users' 2>&1 | grep -i password")
if [[ "$db_fields" == *password_hash* ]]; then
    echo "✅ 数据库字段正确（password_hash）"
else
    echo "❌ 数据库字段异常: $db_fields"
fi

# 检查代码中使用正确的字段名
echo "6. 检查代码字段名匹配..."
code_login=$(ssh hinana "grep -n \"user\\['password\\|user\\[\\\"password\" /opt/hinana-admin/app.py" 2>&1)
if [[ -z "$code_login" ]]; then
    echo "✅ 代码字段名正确（已修复为password_hash）"
else
    echo "❌ 代码中仍在使用旧字段名:"
    echo "$code_login"
fi

# 验证密码哈希格式
echo "7. 验证密码哈希格式..."
password_hash=$(ssh hinana "cd /opt/hinana-admin && sqlite3 instance/hinana.db 'SELECT password_hash FROM admin_users WHERE username=\"admin\" LIMIT 1;' 2>&1")
if [[ "$password_hash" == scrypt:* ]]; then
    echo "✅ 密码哈希为Werkzeug scrypt格式"
elif [[ "$password_hash" == pbkdf2:* ]]; then
    echo "✅ 密码哈希为Werkzeug pbkdf2格式"
else
    echo "⚠️  警告：密码哈希格式异常：$password_hash"
    echo "   可能需要用generate_password_hash('123456')重新生成"
fi

echo ""
echo "======================================"
echo "验证完成！所有核心功能均已检查"
echo ""
echo "📋 每次更新前必查关键项："
echo "  1. 登录API格式兼容性（表单+JSON）"
echo "  2. 数据库字段名一致性（password_hash vs password）"
echo "  3. 密码哈希格式（Werkzeug scrypt/pbkdf2）"
echo "  4. 登录重定向（302 -> /admin/dashboard）"
echo "  5. 中控台页面可访问性（HTTP 200）"