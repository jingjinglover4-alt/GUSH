#!/bin/bash
set -e

cd /home/ubuntu/gush-project

# 1. 清理临时文件
echo ">>> Cleaning temp files..."
find . -name '._*' -delete
find . -name '*.py.bak' -delete
find . -name '*.pyc' -delete
find . -name '__pycache__' -type d -exec rm -rf {} + 2>/dev/null || true

# 2. 创建 .gitignore
cat > .gitignore << 'GITENDOF'
__pycache__/
*.py[cod]
*.py.bak
*.so
*.egg-info/
dist/
build/
*.log
*.pot
db.sqlite3
/staticfiles/
/media/
venv/
.venv/
env/
.vscode/
.idea/
*.swp
*.swo
.DS_Store
._*
.env
.env.*
*.pid
docker-compose.override.yml
GITENDOF

echo ">>> .gitignore created"

# 3. Git 初始化
git init
git config user.email "jingjinglover4-alt@users.noreply.github.com"
git config user.name "jingjinglover4-alt"

# 4. 添加所有文件
git add .

echo ">>> Files staged:"
git status --short | head -40

# 5. 提交
git commit -m "Initial commit: GUSH backend - Django project with accounts, devices, face, operations, pages"

# 6. 设置远程仓库
git remote add origin git@github.com:jingjinglover4-alt/GUSH.git

# 7. 强制推送 (完全替换现有代码)
echo ">>> Force pushing to GitHub..."
git push -u origin main --force

echo ">>> DONE! Successfully pushed to GitHub."
