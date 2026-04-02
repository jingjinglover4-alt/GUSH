#!/bin/bash
# 每日工作计划系统自动化设置脚本 (macOS/Linux)
# 设置每天固定时间自动打开工作计划页面

set -e

echo "📋 每日工作计划系统 - 自动化设置"
echo "=================================="

# 获取脚本目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PYTHON_SCRIPT="$SCRIPT_DIR/start_daily_plan.py"
HTML_FILE="$SCRIPT_DIR/daily_work_plan.html"

# 检查必要文件
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "❌ 错误: 找不到Python脚本: $PYTHON_SCRIPT"
    exit 1
fi

if [ ! -f "$HTML_FILE" ]; then
    echo "❌ 错误: 找不到HTML文件: $HTML_FILE"
    exit 1
fi

echo "✅ 找到必要文件:"
echo "   Python脚本: $PYTHON_SCRIPT"
echo "   HTML页面: $HTML_FILE"

# 检查Python3
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 需要Python3，但未安装"
    echo "   请安装Python3: https://www.python.org/downloads/"
    exit 1
fi

echo "✅ Python3 已安装: $(python3 --version)"

# 询问提醒时间
echo ""
echo "⏰ 设置每日提醒时间"
echo "------------------"
echo "建议时间:"
echo "  1) 早上9:00 - 计划当天工作"
echo "  2) 晚上20:00 - 总结当天工作"
echo "  3) 自定义时间"

read -p "请选择 (1/2/3): " time_choice

case $time_choice in
    1)
        HOUR="9"
        MINUTE="0"
        TIME_DESC="早上9:00"
        ;;
    2)
        HOUR="20"
        MINUTE="0"
        TIME_DESC="晚上8:00"
        ;;
    3)
        read -p "请输入小时 (0-23): " HOUR
        read -p "请输入分钟 (0-59): " MINUTE
        TIME_DESC="$HOUR:$MINUTE"
        ;;
    *)
        echo "使用默认时间: 晚上8:00"
        HOUR="20"
        MINUTE="0"
        TIME_DESC="晚上8:00"
        ;;
esac

echo ""
echo "📅 将设置每日 $TIME_DESC 自动提醒"

# 检查操作系统
OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
    echo "🖥️  检测到 macOS，使用 launchd 设置定时任务"
    setup_macos
elif [ "$OS" = "Linux" ]; then
    echo "🐧 检测到 Linux，使用 crontab 设置定时任务"
    setup_linux
else
    echo "❌ 不支持的操作系统: $OS"
    exit 1
fi

echo ""
echo "✅ 自动化设置完成！"
echo ""
echo "💡 接下来:"
echo "   1. 系统将在每日 $TIME_DESC 自动打开工作计划页面"
echo "   2. 第一次运行时可能需要授权"
echo "   3. 如果需要修改时间，重新运行此脚本"
echo ""
echo "🚀 立即测试: python3 \"$PYTHON_SCRIPT\""

setup_macos() {
    # macOS: 使用 launchd
    PLIST_NAME="com.dailyworkplan.reminder"
    PLIST_FILE="$HOME/Library/LaunchAgents/$PLIST_NAME.plist"
    
    # 创建 launchd plist 文件
    cat > "$PLIST_FILE" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$PLIST_NAME</string>
    
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>$PYTHON_SCRIPT</string>
    </array>
    
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>$HOUR</integer>
        <key>Minute</key>
        <integer>$MINUTE</integer>
    </dict>
    
    <key>RunAtLoad</key>
    <false/>
    
    <key>StandardOutPath</key>
    <string>$HOME/Library/Logs/$PLIST_NAME.log</string>
    <key>StandardErrorPath</key>
    <string>$HOME/Library/Logs/$PLIST_NAME.error.log</string>
</dict>
</plist>
EOF
    
    echo "📝 创建 launchd 配置文件: $PLIST_FILE"
    
    # 加载任务
    launchctl unload "$PLIST_FILE" 2>/dev/null || true
    launchctl load "$PLIST_FILE"
    
    echo "✅ launchd 任务已加载"
    echo ""
    echo "🔧 管理命令:"
    echo "   查看状态: launchctl list | grep $PLIST_NAME"
    echo "   停止任务: launchctl unload \"$PLIST_FILE\""
    echo "   启动任务: launchctl load \"$PLIST_FILE\""
    echo "   查看日志: tail -f \"$HOME/Library/Logs/$PLIST_NAME.log\""
}

setup_linux() {
    # Linux: 使用 crontab
    CRON_JOB="$MINUTE $HOUR * * * cd \"$SCRIPT_DIR\" && /usr/bin/python3 \"$PYTHON_SCRIPT\""
    
    # 添加到 crontab
    (crontab -l 2>/dev/null | grep -v "start_daily_plan.py" || true; echo "$CRON_JOB") | crontab -
    
    echo "✅ crontab 任务已添加"
    echo ""
    echo "🔧 管理命令:"
    echo "   查看任务: crontab -l"
    echo "   编辑任务: crontab -e"
    echo "   删除所有任务: crontab -r"
}

# 如果是macOS或Linux，调用相应的函数
if [ "$OS" = "Darwin" ]; then
    setup_macos
elif [ "$OS" = "Linux" ]; then
    setup_linux
fi