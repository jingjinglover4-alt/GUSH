# 📱 iPhone访问每日工作计划系统指南

## 概述

本指南介绍如何在iPhone上访问每日工作计划系统。系统文件在您的电脑上，需要通过WiFi网络让iPhone访问。

## 🎯 快速开始（推荐）

### 方法一：使用专用服务器脚本（最简单）

```bash
# 1. 进入工作目录
cd /Users/zhaoshiyu/WorkBuddy/Claw

# 2. 启动iPhone访问服务器
python3 start_iphone_server.py
```

**脚本将显示：**
- ✅ 电脑的IP地址（如：`192.168.10.229`）
- ✅ 访问URL（如：`http://192.168.10.229:8000/daily_work_plan.html`）
- 📱 iPhone访问步骤

### 方法二：使用Python内置HTTP服务器

```bash
# 1. 进入工作目录
cd /Users/zhaoshiyu/WorkBuddy/Claw

# 2. 启动HTTP服务器（端口8000）
python3 -m http.server 8000

# 3. 获取电脑IP地址（新开终端）
ifconfig | grep "inet 192" | awk '{print $2}'
# 或
ipconfig getifaddr en0  # macOS
```

## 📱 iPhone操作步骤

### 步骤1：连接同一WiFi网络
- 确保iPhone和电脑连接**同一个WiFi网络**
- 家庭WiFi、手机热点、公司WiFi均可

### 步骤2：在iPhone Safari中访问
1. 打开iPhone的 **Safari浏览器**
2. 在地址栏输入电脑显示的 **URL地址**
   - 例如：`http://192.168.10.229:8000/daily_work_plan.html`
3. 点击"前往"或"Go"

### 步骤3：开始使用
- ✅ 填写今日工作内容
- ✅ 制定明日计划  
- ✅ 深度思考反思
- ✅ 数据自动保存到iPhone浏览器

## 🔧 故障排除

### 问题1：无法连接
**症状**：iPhone显示"无法打开网页"或"Safari无法连接到服务器"

**解决方法**：
1. **检查网络**：确认iPhone和电脑连接同一WiFi
2. **检查防火墙**：电脑防火墙可能阻止端口8000
   - macOS: 系统偏好设置 → 安全性与隐私 → 防火墙
   - Windows: 控制面板 → Windows Defender防火墙
3. **尝试其他端口**：
   ```bash
   # 使用端口8080
   python3 start_iphone_server.py 8080
   ```

### 问题2：IP地址错误
**症状**：URL无法访问，但网络正常

**解决方法**：
1. **获取正确IP**：
   ```bash
   # macOS
   ipconfig getifaddr en0
   
   # 通用方法
   ifconfig | grep "inet 192" | awk '{print $2}'
   ```
2. **使用localhost测试**：在电脑浏览器访问 `http://localhost:8000` 确认服务正常

### 问题3：二维码功能不可用
**症状**：脚本提示需要安装qrcode库

**解决方法**：
```bash
# 安装qrcode库（可选）
pip3 install qrcode[pil]

# 或直接手动输入URL，无需二维码
```

## 📁 文件说明

### 可访问的文件
通过HTTP服务器可以访问：
- `daily_work_plan.html` - 工作计划主页面
- `start_daily_plan.py` - 启动脚本
- `DAILY_WORK_PLAN_README.md` - 使用指南
- `setup_automation_*.sh/ps1` - 自动化设置脚本

### 数据存储位置
- **电脑端**：浏览器LocalStorage，文件在 `~/.daily_work_plan/`
- **iPhone端**：Safari LocalStorage，数据保存在iPhone上

## 💡 高级技巧

### 技巧1：创建桌面快捷方式（iPhone）
1. 在Safari中打开工作计划页面
2. 点击分享按钮（📤）
3. 选择"添加到主屏幕"
4. 命名后点击"添加"
5. 以后可直接从桌面图标访问

### 技巧2：使用手机热点
如果WiFi不可用，可以使用手机热点：
1. 用iPhone开启个人热点
2. 电脑连接iPhone热点
3. 获取电脑在热点网络中的IP
4. iPhone直接访问该IP

### 技巧3：定期备份数据
```bash
# 导出数据备份
# 在电脑浏览器中打开页面，点击"导出报告"按钮
# 或手动备份LocalStorage数据
```

## 🔒 安全说明

### 本地网络安全
- 服务器仅在本地网络运行
- 外部互联网无法访问
- 数据不离开您的设备

### 隐私保护
- 所有数据存储在本地
- 无需注册账号
- 无需网络传输

## 🚀 优化体验

### 响应式设计
- 页面自动适配iPhone屏幕
- 触控友好的表单元素
- 移动端优化的按钮和布局

### 离线使用
- 首次访问后可以离线使用
- 数据自动保存到本地
- 支持断网后继续填写

## 📞 技术支持

### 获取帮助
如果遇到问题：
1. 检查本指南的故障排除部分
2. 确认Python版本（需要Python 3.6+）
3. 检查网络连接状态

### 常见命令参考
```bash
# 启动服务器
python3 start_iphone_server.py

# 使用其他端口
python3 start_iphone_server.py 8080

# 简单HTTP服务器
python3 -m http.server 8000

# 获取IP地址（macOS）
ipconfig getifaddr en0

# 检查端口占用
lsof -i :8000
```

## 🎉 开始使用！

### 立即行动
1. **打开终端**，进入工作目录
2. **运行服务器**：`python3 start_iphone_server.py`
3. **记住URL**：如 `http://192.168.10.229:8000`
4. **iPhone访问**：Safari输入URL
5. **开始填写**：养成每日反思习惯

### 习惯养成
- 📅 **每天固定时间**：建议晚上8点
- 🎯 **认真填写每个部分**：强迫深度思考
- 📊 **跟踪进度**：系统自动对比完成情况
- 🔥 **连续打卡**：21天形成习惯

---

**记住**：系统的目标是**强迫你思考、强迫你改变、强迫你成长**。今天就开始，坚持21天，见证自己的进步！