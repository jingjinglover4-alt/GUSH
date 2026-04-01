#!/bin/bash
# 创建HI拿管理系统完整代码备份

set -e

# 设置变量
PROJECT_ROOT="/Users/zhaoshiyu/WorkBuddy/Claw"
BACKUP_DIR="${PROJECT_ROOT}/code_backup_$(date +%Y%m%d_%H%M)"
BACKUP_TAR="${PROJECT_ROOT}/hinana_code_backup_$(date +%Y%m%d_%H%M).tar.gz"

# 创建备份目录
mkdir -p "${BACKUP_DIR}"

echo "开始备份HI拿管理系统代码..."
echo "项目根目录: ${PROJECT_ROOT}"
echo "备份目录: ${BACKUP_DIR}"
echo "压缩包: ${BACKUP_TAR}"

# 复制核心代码目录
echo "1. 复制核心代码目录..."
cp -r "${PROJECT_ROOT}/cdgushai" "${BACKUP_DIR}/"
cp -r "${PROJECT_ROOT}/hinana-admin" "${BACKUP_DIR}/"
cp -r "${PROJECT_ROOT}/hinana-miniapp" "${BACKUP_DIR}/"
cp -r "${PROJECT_ROOT}/templates" "${BACKUP_DIR}/"
cp -r "${PROJECT_ROOT}/static" "${BACKUP_DIR}/"
cp -r "${PROJECT_ROOT}/vending-machine-controller" "${BACKUP_DIR}/"

# 复制根目录重要文件
echo "2. 复制根目录重要文件..."
cp "${PROJECT_ROOT}/app.py" "${BACKUP_DIR}/"
cp "${PROJECT_ROOT}/apis.py" "${BACKUP_DIR}/"
cp "${PROJECT_ROOT}/hiNana_deployment_guide.md" "${BACKUP_DIR}/"
cp "${PROJECT_ROOT}/stm32_vending_machine_analysis.md" "${BACKUP_DIR}/"
cp "${PROJECT_ROOT}/stm32_vending_project_summary.md" "${BACKUP_DIR}/"
cp "${PROJECT_ROOT}/verify_backend_functions.sh" "${BACKUP_DIR}/"
cp "${PROJECT_ROOT}/.gitignore" "${BACKUP_DIR}/" 2>/dev/null || true

# 复制工作内存（重要！）
echo "3. 复制工作内存..."
mkdir -p "${BACKUP_DIR}/.workbuddy"
cp -r "${PROJECT_ROOT}/.workbuddy/memory" "${BACKUP_DIR}/.workbuddy/"

# 复制配置文件
echo "4. 复制配置文件..."
cp "${PROJECT_ROOT}/cdgushai.com.conf" "${BACKUP_DIR}/"

# 创建备份信息文件
echo "5. 创建备份信息文件..."
cat > "${BACKUP_DIR}/BACKUP_INFO.md" << EOF
# HI拿管理系统代码备份信息

## 备份时间
$(date)

## 备份内容
1. 小程序API代码 (cdgushai/)
2. 管理后台代码 (hinana-admin/)
3. 小程序前端代码 (hinana-miniapp/)
4. HTML模板文件 (templates/)
5. 静态资源文件 (static/)
6. 硬件控制器代码 (vending-machine-controller/)
7. 主应用文件 (app.py, apis.py)
8. 项目文档
9. 工作记忆 (.workbuddy/memory/)
10. 配置文件

## Git状态
$(cd "${PROJECT_ROOT}" && git status)

## 最近提交
$(cd "${PROJECT_ROOT}" && git log --oneline -5)

## 服务器信息
- 主服务器: 150.158.20.232
- 管理后台: http://150.158.20.232/admin/
- 小程序API: http://150.158.20.232:5002/
- 服务端口: 
  - hinana-admin: 5001
  - vending-app: 5000
  - miniapp-api: 5002

## 恢复说明
1. 将备份文件解压到目标目录
2. 确保Python环境已安装所需依赖
3. 根据需要修改配置文件
4. 部署到服务器时注意数据库路径和端口配置
EOF

# 创建文件清单
echo "6. 创建文件清单..."
find "${BACKUP_DIR}" -type f | sort > "${BACKUP_DIR}/FILE_LIST.txt"

# 计算文件数量
echo "7. 统计备份内容..."
FILE_COUNT=$(find "${BACKUP_DIR}" -type f | wc -l)
DIR_COUNT=$(find "${BACKUP_DIR}" -type d | wc -l)
echo "备份完成: ${FILE_COUNT} 个文件, ${DIR_COUNT} 个目录"

# 创建压缩包
echo "8. 创建压缩包..."
tar -czf "${BACKUP_TAR}" -C "${PROJECT_ROOT}" "code_backup_$(date +%Y%m%d_%H%M)"

# 计算压缩包大小
TAR_SIZE=$(du -h "${BACKUP_TAR}" | cut -f1)

echo "========================================"
echo "备份完成!"
echo "备份目录: ${BACKUP_DIR}"
echo "压缩包: ${BACKUP_TAR} (${TAR_SIZE})"
echo "文件数量: ${FILE_COUNT}"
echo "目录数量: ${DIR_COUNT}"
echo "备份信息: ${BACKUP_DIR}/BACKUP_INFO.md"
echo "文件清单: ${BACKUP_DIR}/FILE_LIST.txt"
echo "========================================"

# 显示当前git状态差异
echo ""
echo "当前Git状态:"
cd "${PROJECT_ROOT}" && git status