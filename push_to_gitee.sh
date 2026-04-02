#!/bin/bash
# 推送代码到Gitee的自动化脚本

cd /Users/zhaoshiyu/WorkBuddy/Claw

echo "=== Gitee代码推送脚本 ==="
echo "当前目录: $(pwd)"
echo ""

echo "1. 检查当前Git状态..."
git status
echo ""

echo "2. 检查远程仓库配置..."
git remote -v
echo ""

echo "3. 检查SSH密钥配置..."
if [ -f ~/.ssh/id_rsa_hinana.pub ]; then
    echo "✅ 找到SSH公钥: ~/.ssh/id_rsa_hinana.pub"
    echo "   公钥指纹: $(ssh-keygen -lf ~/.ssh/id_rsa_hinana.pub | awk '{print $2}')"
else
    echo "❌ 未找到SSH公钥"
fi
echo ""

echo "4. 测试SSH连接到Gitee..."
ssh_output=$(ssh -T git@gitee.com 2>&1)
if echo "$ssh_output" | grep -q "successfully authenticated"; then
    echo "✅ SSH认证成功: $ssh_output"
else
    echo "❌ SSH认证失败: $ssh_output"
    echo "   可能原因: SSH公钥未添加到Gitee账户"
    echo "   解决方案: 请将 ~/.ssh/id_rsa_hinana.pub 内容添加到 https://gitee.com/profile/sshkeys"
fi
echo ""

echo "5. 尝试推送到Gitee..."
echo "   分支: main"
echo "   远程仓库: gitee (git@gitee.com:yanxiong1/saas-vending-machine.git)"
echo ""

read -p "是否继续推送? (y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "操作已取消"
    exit 0
fi

echo "开始推送..."
if git push gitee main; then
    echo ""
    echo "✅ 推送成功！"
    echo ""
    echo "Gitee仓库地址: https://gitee.com/yanxiong1/saas-vending-machine"
    echo "GitHub备份地址: https://github.com/jingjinglover4-alt/GUSH.git"
else
    echo ""
    echo "❌ 推送失败"
    echo ""
    echo "备选方案:"
    echo "A) 使用HTTPS方法推送:"
    echo "   1. git remote remove gitee"
    echo "   2. git remote add gitee https://gitee.com/yanxiong1/saas-vending-machine.git"
    echo "   3. git push gitee main"
    echo ""
    echo "B) 配置SSH密钥后重试:"
    echo "   1. 访问 https://gitee.com/profile/sshkeys"
    echo "   2. 添加公钥: ~/.ssh/id_rsa_hinana.pub"
    echo "   3. 重新运行此脚本"
    echo ""
    echo "详细指南: 请查看 GITEE_PUSH_GUIDE.md"
fi