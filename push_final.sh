#!/bin/bash
set -e

cd /home/ubuntu/gush-project

# 使用新 SSH host alias
git remote set-url origin git@github.com-gush:jingjinglover4-alt/GUSH.git

echo ">>> Remote URL:"
git remote -v

# 强制推送
echo ">>> Force pushing..."
git push -u origin main --force

echo ">>> ALL DONE!"
