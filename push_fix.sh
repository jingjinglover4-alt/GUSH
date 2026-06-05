#!/bin/bash
set -e

cd /home/ubuntu/gush-project

# 清理遗漏的 .bak 文件
find . -name '*.bak' -delete
find . -name '*.bak2' -delete

# 重新添加
git add -A

# 修正提交
git commit --amend -m "Initial commit: GUSH backend - Django project with accounts, devices, face, operations, pages" --no-edit

# 分支重命名为 main
git branch -m main

# 强制推送
echo ">>> Force pushing to GitHub..."
git push -u origin main --force

echo ">>> DONE!"
