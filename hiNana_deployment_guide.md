# HI拿智能派样SaaS系统 - 完整部署与使用指南

## 📋 目录

1. [系统概述](#系统概述)
2. [系统架构](#系统架构)
3. [核心功能](#核心功能)
4. [部署环境](#部署环境)
5. [中控台使用指南](#中控台使用指南)
6. [硬件集成](#硬件集成)
7. [故障排除](#故障排除)
8. [备份与恢复](#备份与恢复)
9. [安全注意事项](#安全注意事项)
10. [联系方式](#联系方式)

---

## 1. 系统概述

HI拿智能派样SaaS系统是一套完整的智能派样解决方案，包括软件服务、硬件控制和业务流程管理三大部分。系统通过微信公众号、小程序、派样硬件设备形成闭环，为企业级客户提供轻资产短租型派样服务。

### 核心优势
- **轻资产运营**：按天/按次计费，降低客户成本
- **快速部署**：硬件即插即用，15分钟完成安装
- **智能管理**：全流程数字化管理，实时监控
- **可扩展性**：支持多客户、多设备、多地点并行运营

### 目标客户
- 景区营销部门
- 学校/教育机构
- 商业展会主办方
- 品牌推广代理商

---

## 2. 系统架构

### 2.1 软件架构
```bash
服务器: 150.158.20.232 (域名: cdgush.com)
├── 管理后台 (端口5001): http://150.158.20.232/admin/
├── 派样机页面 (端口5000): http://150.158.20.232/redeem
├── 小程序API (端口5002): http://150.158.20.232/api/
└── Web服务器 (nginx): 80/443端口
```

### 2.2 硬件架构
```
用户扫码 → 小程序 → 生成6位兑换码 → 
↓
Orange Pi → 验证兑换码 → STM32控制出货
↑
实时上报状态 ← 监控系统
```

### 2.3 数据库结构
- **SQLite数据库**: `/opt/hinana-admin/instance/hinana.db`
- **核心数据表**:
  - `customers`: 客户配置信息
  - `redeem_codes`: 兑换码管理
  - `user_records`: 用户领取记录
  - `machines`: 硬件设备管理
  - `admin_users`: 管理员账户

---

## 3. 核心功能

### 3.1 用户端功能
1. **公众号关注**：用户扫描机器上的公众号二维码
2. **企业微信添加**：关注后自动推送员工企业微信二维码
3. **小程序留资**：在企业微信中打开小程序填写信息
4. **获取兑换码**：填写信息后获得60秒有效兑换码
5. **机器端兑换**：在派样机上输入6位兑换码领取样品

### 3.2 管理端功能
1. **客户管理**：多客户独立配置（Logo、背景、二维码等）
2. **兑换码管理**：生成、查看、导出兑换码
3. **设备监控**：实时监控设备状态和库存
4. **数据分析**：用户数据统计和业务分析
5. **营收管理**：租金和派样笔数费用计算

### 3.3 硬件端功能
1. **设备控制**：控制50个货道派样机
2. **通信接口**：串口通信协议，支持状态上报
3. **离线模式**：网络断开时支持离线验证
4. **安全机制**：防拆检测、异常报警

---

## 4. 部署环境

### 4.1 服务器要求
- **操作系统**: Ubuntu 20.04+ / CentOS 8+
- **CPU**: 2核+
- **内存**: 4GB+
- **存储**: 100GB+
- **带宽**: 10Mbps+
- **端口**: 80, 443, 5000-5002

### 4.2 依赖软件
```bash
# 系统级依赖
Python 3.8+
SQLite 3.25+
nginx 1.18+
systemd

# Python依赖包
Flask, sqlite3, psutil, Werkzeug
```

### 4.3 安装命令
```bash
# Ubuntu系统
apt update
apt install -y python3-pip nginx sqlite3
pip3 install Flask psutil

# 服务管理
systemctl enable nginx
systemctl enable hinana-admin
systemctl enable vending-app
systemctl enable miniapp-api
```

---

## 5. 中控台使用指南

### 5.1 访问地址
- **标准仪表盘**: http://150.158.20.232/admin/ (用户名: admin, 密码: 123456)
- **增强版中控台**: http://150.158.20.232/admin/control

### 5.2 中控台功能介绍

#### 5.2.1 服务监控模块
- **实时状态**: 显示所有服务运行状态（绿色=正常，红色=异常）
- **性能指标**: CPU、内存使用率监控
- **操作按钮**: 一键重启、查看日志、停止/启动服务

#### 5.2.2 客户管理模块
- **快速配置**: 添加新客户（Logo、背景、二维码等）
- **客户概览**: 查看全部客户信息，按状态筛选
- **配置导出**: 导出客户配置为Excel文件

#### 5.2.3 硬件监控模块
- **STM32状态**: 下位机连接状态、固件版本、通道数量
- **Orange Pi状态**: 上位机在线状态、IP地址、系统负载
- **设备详情**: 每台派样机的具体信息（位置、库存、最后活动时间）

#### 5.2.4 系统概览模块
- **数据统计**: 总客户数、活跃客户数、机器总数、兑换总数
- **营收数据**: 7日营收、今日兑换数、平均客单价
- **活动日志**: 最近的操作记录和系统事件

### 5.3 常用操作

#### 5.3.1 新增客户流程
1. 点击"快速客户配置" → "新增客户"
2. 填写客户基本信息（名称、联系方式）
3. 上传客户Logo、背景图、二维码
4. 配置AppID和Secret（微信相关）
5. 保存配置，系统自动生成专属页面

#### 5.3.2 生成兑换码
1. 点击"兑换码管理" → "批量生成"
2. 输入生成数量（1-1000）
3. 设置有效期（默认60秒）
4. 确认生成，系统显示兑换码列表
5. 可导出为CSV文件，供现场工作人员使用

#### 5.3.3 机器状态查看
1. 点击"硬件状态监控" → "刷新状态"
2. 查看所有设备连接状态
3. 点击设备名称查看详细信息
4. 库存预警：库存低于10%时显示黄色警告
5. 离线报警：设备离线超过1小时显示红色警告

### 5.4 快捷键
- **Ctrl+R**: 刷新服务状态
- **Ctrl+B**: 执行系统备份
- **F5**: 刷新整个页面
- **Ctrl+L**: 查看系统日志
- **Ctrl+F**: 搜索功能（在表格界面）

---

## 6. 硬件集成

### 6.1 硬件清单
1. **派样机主体**: 50货道智能派样机
2. **控制板**: STM32F407ZGT6 (LQFP144封装)
3. **上位机**: Orange Pi 3B/4B
4. **通讯模块**: USB转串口线 × 2
5. **电源**: 12V/5A电源适配器
6. **显示屏**: 10寸触摸屏（可选）

### 6.2 硬件连接图
```text
[用户界面] ←→ [Orange Pi] ←串口→ [STM32] ←→ [电机驱动板] ←→ [货道电机]
    ↑                ↑                ↑               ↑              ↑
 触摸屏          Wi-Fi/USB          GPIO          控制信号       执行机构
```

### 6.3 硬件安装步骤

#### 6.3.1 STM32烧录（下位机）
1. **准备工具**：
   - ST-Link V2编程器
   - MDK-ARM Keil软件
   - STM32CubeMX软件

2. **烧录步骤**：
   ```bash
   # 1. 连接ST-Link
     VCC(3.3V) → 3.3V
     GND → GND
     SWDIO → PA13
     SWCLK → PA14

   # 2. 使用Keil打开项目
     项目路径: /Users/zhaoshiyu/Desktop/project1.0.1/
     
   # 3. 编译项目
     Project → Build Target (F7)
     
   # 4. 烧录固件
     Flash → Download (F8)
   ```

3. **验证烧录**：
   - 电源指示灯亮起
   - USART3串口输出启动信息（波特率115200）
   - 可通过串口调试助手验证通信

#### 6.3.2 Orange Pi配置（上位机）
1. **系统安装**：
   ```bash
   # 1. 下载系统镜像
     wget https://dl.armbian.com/orangepi4/archive/Armbian_24.5.0_Orangepi4_bookworm_current_6.6.31_minimal.img.xz
   
   # 2. 烧录到SD卡
     sudo dd if=Armbian_...img of=/dev/sdX bs=4M status=progress
   
   # 3. 首次启动配置
     # 连接网线，通过SSH访问
     ssh root@orangepi.local (默认密码: 1234)
   ```

2. **安装依赖**：
   ```bash
   # 1. 系统更新
     apt update && apt upgrade -y
   
   # 2. 安装Python和依赖
     apt install python3 python3-pip python3-venv -y
     pip3 install pyserial requests
   
   # 3. 设置串口权限
     usermod -a -G dialout orangepi
   ```

3. **部署通信程序**：
   ```bash
   # 1. 创建项目目录
     mkdir -p /opt/hinana-orange-pi
   
   # 2. 配置串口通信
     # 连接STM32到Orange Pi串口
     # 检查串口设备: ls /dev/tty*
     # 通常为: /dev/ttyAMA0（GPIO串口）或/dev/ttyUSB0（USB转串口）
   
   # 3. 运行通信程序
     python3 /opt/hinana-orange-pi/serial_comm.py
   ```

#### 6.3.3 联调测试
1. **通信测试**：
   ```python
   # serial_comm.py示例代码
   import serial
   import time
   
   ser = serial.Serial('/dev/ttyAMA0', 115200, timeout=1)
   
   # 发送测试指令
   ser.write(b'TEST\r\n')
   response = ser.readline()
   print(f"STM32响应: {response}")
   ```

2. **网络连接测试**：
   ```bash
   # 测试与服务器的连接
   curl http://150.158.20.232/api/health
   
   # 如果使用WiFi
   nmcli device wifi connect "SSID" password "密码"
   ```

3. **完整流程测试**：
   1. 用户在小程序获得兑换码 "123456"
   2. Orange Pi接收兑换码请求
   3. 验证兑换码有效性
   4. 发送出货指令到STM32
   5. STM32控制电机出货
   6. 报告出货结果

### 6.4 现场安装
1. **选择位置**：人流量适中、电源方便、WiFi信号良好
2. **硬件组装**：
   - 安装STM32控制板到派样机内部
   - 连接电机驱动板线缆
   - 固定Orange Pi到合适位置
3. **网络配置**：
   - 连接WiFi或有线网络
   - 测试与服务器通信
4. **电源连接**：
   - 12V电源适配器连接到派样机
   - 5V电源适配器连接到Orange Pi（如有需要）
5. **首次启动**：
   - 开机检查所有指示灯
   - 验证屏幕正常显示
   - 测试出货功能

---

## 7. 故障排除

### 7.1 常见问题及解决方法

#### 问题1: 无法访问管理后台
```bash
# 检查步骤
1. 检查服务状态: systemctl status hinana-admin
2. 检查端口监听: netstat -tlnp | grep 5001
3. 检查防火墙: ufw status
4. 检查Nginx配置: nginx -t
5. 查看日志: journalctl -u hinana-admin -f
```

#### 问题2: 兑换码验证失败
```bash
# 检查步骤
1. 检查数据库连接: 
     sqlite3 /opt/hinana-admin/instance/hinana.db
     SELECT * FROM redeem_codes WHERE code='123456';
   
2. 检查兑换码状态:
     SELECT code, status, expires_at FROM redeem_codes;
   
3. 检查API服务:
     curl http://localhost:5002/api/redeem_code -d '{"code":"123456"}'
```

#### 问题3: 硬件通信异常
```bash
# STM32通信问题
1. 检查串口连接: dmesg | grep tty
2. 检查波特率设置: 必须为115200
3. 检查电缆质量: 尝试更换USB串口线
4. 测试通信: 
     minicom -D /dev/ttyUSB0 -b 115200
     # 输入"TEST"按回车，查看STM32响应
```

#### 问题4: 微信/小程序接口问题
```bash
# 微信相关故障
1. 检查AppID/Secret配置:
     SELECT appid, secret FROM customers WHERE id=1;
   
2. 检查证书有效期:
     # 微信相关证书有效期一年，需定期更新
   
3. 检查域名备案:
     # 确保cdgush.com已完成ICP备案
```

### 7.2 监控工具
```bash
# 实时监控系统状态
watch -n 5 "systemctl status hinana-admin vending-app miniapp-api"

# 监控系统资源
htop  # 查看CPU、内存使用
iotop # 查看磁盘IO
nload # 查看网络流量

# 监控数据库
sqlite3 /opt/hinana-admin/instance/hinana.db "SELECT COUNT(*) FROM user_records;"
```

---

## 8. 备份与恢复

### 8.1 手动备份
```bash
# 创建完整备份（推荐）
cd /opt
BACKUP_DIR="hinana-backup-$(date +%Y%m%d_%H%M%S)"
mkdir $BACKUP_DIR

# 备份数据库
cp /opt/hinana-admin/instance/hinana.db $BACKUP_DIR/

# 备份配置文件
cp -r /opt/hinana-admin/*.py $BACKUP_DIR/
cp /www/server/panel/vhost/nginx/cdgushai.com.conf $BACKUP_DIR/

# 备份模板文件
tar -czf $BACKUP_DIR/templates.tar.gz -C /opt/hinana-admin/templates .

# 创建压缩包
tar -czf $BACKUP_DIR.tar.gz -C $BACKUP_DIR .
rm -rf $BACKUP_DIR

echo "备份完成: $BACKUP_DIR.tar.gz"
```

### 8.2 一键备份脚本
```bash
#!/bin/bash
# hinana_backup.sh
BACKUP_DIR="/opt/hinana-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p $BACKUP_DIR

echo "开始备份HI拿系统..."

# 备份数据库
echo "1. 备份数据库..."
cp /opt/hinana-admin/instance/hinana.db $BACKUP_DIR/

# 备份代码
echo "2. 备份代码文件..."
cp -r /opt/hinana-admin/*.py $BACKUP_DIR/
cp -r /opt/hinana-admin/static $BACKUP_DIR/
tar -czf $BACKUP_DIR/templates.tar.gz -C /opt/hinana-admin/templates .

# 备份配置
echo "3. 备份配置文件..."
cp /www/server/panel/vhost/nginx/cdgushai.com.conf $BACKUP_DIR/

# 备份Nginx配置
echo "4. 备份系统配置..."
cp /etc/systemd/system/hinana-admin.service $BACKUP_DIR/
cp /etc/systemd/system/vending-app.service $BACKUP_DIR/
cp /etc/systemd/system/miniapp-api.service $BACKUP_DIR/

# 创建还原脚本
echo "5. 创建还原脚本..."
cat > $BACKUP_DIR/restore.sh << 'EOF'
#!/bin/bash
echo "开始还原HI拿系统..."

# 停止服务
systemctl stop hinana-admin
systemctl stop vending-app
systemctl stop miniapp-api

# 还原数据库
echo "1. 还原数据库..."
cp hinana.db /opt/hinana-admin/instance/

# 还原代码
echo "2. 还原代码文件..."
cp *.py /opt/hinana-admin/
tar -xzf templates.tar.gz -C /opt/hinana-admin/templates

# 还原配置
echo "3. 还原配置文件..."
cp cdgushai.com.conf /www/server/panel/vhost/nginx/
cp *.service /etc/systemd/system/

# 重启服务
systemctl daemon-reload
systemctl start hinana-admin
systemctl start vending-app
systemctl start miniapp-api

echo "还原完成，请检查服务状态"
EOF

chmod +x $BACKUP_DIR/restore.sh

# 创建备份信息
echo "6. 创建备份信息文件..."
cat > $BACKUP_DIR/backup_info.txt << EOF
备份时间: $(date)
备份目录: $BACKUP_DIR
数据库大小: $(du -h /opt/hinana-admin/instance/hinana.db | cut -f1)
包含文件: $(find $BACKUP_DIR -type f | wc -l) 个
备份人员: 系统自动备份
备注: 包含完整系统备份
EOF

# 创建压缩包
echo "7. 创建压缩包..."
tar -czf $BACKUP_DIR.tar.gz -C $BACKUP_DIR .
rm -rf $BACKUP_DIR

echo "备份完成: $BACKUP_DIR.tar.gz"
echo "备份大小: $(du -h $BACKUP_DIR.tar.gz | cut -f1)"
```

### 8.3 自动备份（使用crontab）
```bash
# 编辑crontab
crontab -e

# 添加以下行（每天凌晨2点备份）
0 2 * * * /opt/bin/hinana_backup.sh >> /var/log/hinana-backup.log 2>&1
```

### 8.4 恢复步骤
```bash
# 从备份恢复
tar -xzf hinana-backup-20260328_1612.tar.gz
cd hinana-backup-20260328_1612
chmod +x restore.sh

# 查看恢复脚本内容
cat restore.sh

# 开始恢复（需要root权限）
sudo ./restore.sh

# 验证恢复结果
systemctl status hinana-admin
curl http://localhost:5001/admin/login
```

---

## 9. 安全注意事项

### 9.1 密码安全
1. **修改默认密码**：
   ```bash
   # 修改管理后台密码
   sqlite3 /opt/hinana-admin/instance/hinana.db
   UPDATE admin_users SET password = '新的哈希密码' WHERE username = 'admin';
   ```
   
   **注意**：密码需要使用`generate_password_hash()`生成哈希值

2. **SSH安全**：
   ```bash
   # 禁用root登录
   vim /etc/ssh/sshd_config
   PermitRootLogin no
   
   # 重启SSH服务
   systemctl restart sshd
   ```

### 9.2 防火墙配置
```bash
# 只开放必要端口
ufw allow 22/tcp    # SSH
ufw allow 80/tcp    # HTTP
ufw allow 443/tcp   # HTTPS
ufw allow 5000/tcp  # 派样机服务
ufw allow 5001/tcp  # 管理后台
ufw allow 5002/tcp  # 小程序API
ufw enable
```

### 9.3 数据安全
1. **定期备份**：至少每周一次完整备份
2. **异地备份**：重要数据备份到不同服务器
3. **访问控制**：限制非必要人员的访问权限
4. **安全审计**：定期查看系统日志，发现异常访问

### 9.4 更新维护
```bash
# 系统更新
apt update && apt upgrade -y

# 安全补丁
apt-get install unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades
```

---

## 10. 联系方式

### 技术支持
- **开发团队**: HI拿智能科技
- **技术支持邮箱**: support@hinana-tech.com
- **紧急联系电话**: 400-xxx-xxxx
- **技术支持时间**: 9:00-18:00（工作日）

### 文档资源
1. **在线文档**: https://docs.hinana-tech.com
2. **视频教程**: 微信视频号 @HI拿智能派样
3. **常见问题**: https://help.hinana-tech.com

### 升级说明
- **系统版本**: v1.0.1
- **最后更新**: 2026-03-28
- **下次更新**: 2026-06-30（计划新增幸运大转盘功能）

---

## 🚀 快速开始

### 第一步：访问系统
1. 打开浏览器访问: http://150.158.20.232/admin/
2. 使用默认账号登录: admin / 123456
3. 立即修改管理员密码

### 第二步：添加第一个客户
1. 点击"客户管理" → "新增客户"
2. 填写基本信息并上传素材
3. 保存后获得客户专属链接

### 第三步：部署硬件
1. 参考[硬件集成](#6-硬件集成)章节
2. 完成硬件连接和配置
3. 进行测试出货

### 第四步：开始运营
1. 客户将派样机部署到目标场地
2. 用户扫码领取样品
3. 通过管理后台监控业务数据

---

## 📞 紧急联系

如果遇到紧急问题，请按以下优先级联系：

1. **系统无法访问** → 检查服务状态，重启相关服务
2. **硬件不工作** → 检查电源和网络连接
3. **兑换码无效** → 重置兑换码或检查数据库连接
4. **数据丢失** → 使用最新备份恢复
5. **安全问题** → 立即断开网络，联系技术支持

---

**祝您使用愉快！HI拿智能派样助您业务腾飞！** 🎯

---
*文档版本: v2.0 (2026-03-28)*
*系统版本: HI拿SaaS v1.0.1*