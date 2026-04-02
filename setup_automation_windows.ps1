# 每日工作计划系统自动化设置脚本 (Windows)
# 设置每天固定时间自动打开工作计划页面

Write-Host "📋 每日工作计划系统 - 自动化设置" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

# 获取脚本目录
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$PYTHON_SCRIPT = Join-Path $SCRIPT_DIR "start_daily_plan.py"
$HTML_FILE = Join-Path $SCRIPT_DIR "daily_work_plan.html"

# 检查必要文件
if (-not (Test-Path $PYTHON_SCRIPT)) {
    Write-Host "❌ 错误: 找不到Python脚本: $PYTHON_SCRIPT" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $HTML_FILE)) {
    Write-Host "❌ 错误: 找不到HTML文件: $HTML_FILE" -ForegroundColor Red
    exit 1
}

Write-Host "✅ 找到必要文件:" -ForegroundColor Green
Write-Host "   Python脚本: $PYTHON_SCRIPT"
Write-Host "   HTML页面: $HTML_FILE"

# 检查Python3
try {
    $pythonVersion = python --version 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Python not found"
    }
    Write-Host "✅ Python 已安装: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ 错误: 需要Python，但未安装" -ForegroundColor Red
    Write-Host "   请安装Python: https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

# 询问提醒时间
Write-Host ""
Write-Host "⏰ 设置每日提醒时间" -ForegroundColor Cyan
Write-Host "------------------" -ForegroundColor Cyan
Write-Host "建议时间:" -ForegroundColor Yellow
Write-Host "  1) 早上9:00 - 计划当天工作"
Write-Host "  2) 晚上20:00 - 总结当天工作"
Write-Host "  3) 自定义时间"

$timeChoice = Read-Host "请选择 (1/2/3)"

switch ($timeChoice) {
    "1" {
        $HOUR = 9
        $MINUTE = 0
        $TIME_DESC = "早上9:00"
    }
    "2" {
        $HOUR = 20
        $MINUTE = 0
        $TIME_DESC = "晚上8:00"
    }
    "3" {
        $HOUR = Read-Host "请输入小时 (0-23)"
        $MINUTE = Read-Host "请输入分钟 (0-59)"
        $TIME_DESC = "$HOUR:$MINUTE"
    }
    default {
        Write-Host "使用默认时间: 晚上8:00" -ForegroundColor Yellow
        $HOUR = 20
        $MINUTE = 0
        $TIME_DESC = "晚上8:00"
    }
}

Write-Host ""
Write-Host "📅 将设置每日 $TIME_DESC 自动提醒" -ForegroundColor Green

# 创建任务计划
Write-Host ""
Write-Host "🖥️  创建Windows计划任务..." -ForegroundColor Cyan

# 任务名称
$TASK_NAME = "DailyWorkPlanReminder"
$TASK_DESCRIPTION = "每日工作计划提醒 - 自动打开工作计划页面"

# 创建任务操作的参数
$ACTION = New-ScheduledTaskAction `
    -Execute "python" `
    -Argument "`"$PYTHON_SCRIPT`""

# 创建任务触发器（每天指定时间）
$TRIGGER = New-ScheduledTaskTrigger `
    -Daily `
    -At "$($HOUR.ToString('00')):$($MINUTE.ToString('00'))"

# 任务设置
$SETTINGS = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -WakeToRun

# 注册任务
try {
    # 检查是否已存在任务，如果存在则删除
    $existingTask = Get-ScheduledTask -TaskName $TASK_NAME -ErrorAction SilentlyContinue
    if ($existingTask) {
        Write-Host "⚠️  已存在同名任务，正在删除..." -ForegroundColor Yellow
        Unregister-ScheduledTask -TaskName $TASK_NAME -Confirm:$false
    }
    
    # 注册新任务
    Register-ScheduledTask `
        -TaskName $TASK_NAME `
        -Action $ACTION `
        -Trigger $TRIGGER `
        -Settings $SETTINGS `
        -Description $TASK_DESCRIPTION `
        -RunLevel Highest `
        -Force
    
    Write-Host "✅ Windows计划任务创建成功！" -ForegroundColor Green
    
    # 启用任务
    Enable-ScheduledTask -TaskName $TASK_NAME
    
    Write-Host "✅ 计划任务已启用" -ForegroundColor Green
    
} catch {
    Write-Host "❌ 创建计划任务失败: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 替代方案:" -ForegroundColor Yellow
    Write-Host "   1. 手动创建计划任务:" -ForegroundColor Yellow
    Write-Host "      - 打开'任务计划程序'" -ForegroundColor Yellow
    Write-Host "      - 创建基本任务" -ForegroundColor Yellow
    Write-Host "      - 名称: DailyWorkPlanReminder" -ForegroundColor Yellow
    Write-Host "      - 触发器: 每天 $TIME_DESC" -ForegroundColor Yellow
    Write-Host "      - 操作: 启动程序" -ForegroundColor Yellow
    Write-Host "      - 程序: python" -ForegroundColor Yellow
    Write-Host "      - 参数: `"$PYTHON_SCRIPT`"" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "✅ 自动化设置完成！" -ForegroundColor Green
Write-Host ""
Write-Host "💡 接下来:" -ForegroundColor Cyan
Write-Host "   1. 系统将在每日 $TIME_DESC 自动打开工作计划页面" -ForegroundColor Cyan
Write-Host "   2. 第一次运行时可能需要授权" -ForegroundColor Cyan
Write-Host "   3. 如果需要修改时间，重新运行此脚本" -ForegroundColor Cyan
Write-Host ""
Write-Host "🔧 管理命令:" -ForegroundColor Yellow
Write-Host "   查看任务: Get-ScheduledTask -TaskName `"$TASK_NAME`"" -ForegroundColor Yellow
Write-Host "   运行任务: Start-ScheduledTask -TaskName `"$TASK_NAME`"" -ForegroundColor Yellow
Write-Host "   停止任务: Stop-ScheduledTask -TaskName `"$TASK_NAME`"" -ForegroundColor Yellow
Write-Host "   删除任务: Unregister-ScheduledTask -TaskName `"$TASK_NAME`" -Confirm:`$false" -ForegroundColor Yellow
Write-Host ""
Write-Host "🚀 立即测试: python `"$PYTHON_SCRIPT`"" -ForegroundColor Cyan

# 询问是否立即测试
$testNow = Read-Host "是否立即测试运行? (Y/N)"
if ($testNow -eq "Y" -or $testNow -eq "y") {
    Write-Host "正在启动测试..." -ForegroundColor Cyan
    & python $PYTHON_SCRIPT
}