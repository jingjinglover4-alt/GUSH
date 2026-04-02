#!/usr/bin/env python3
"""
每日工作计划系统启动脚本
自动打开工作计划页面，并检查是否需要填写
"""

import webbrowser
import os
import json
import datetime
import sys
import platform
from pathlib import Path

def get_data_path():
    """获取数据存储路径"""
    home = Path.home()
    if platform.system() == 'Windows':
        data_dir = home / 'AppData' / 'Local' / 'DailyWorkPlan'
    elif platform.system() == 'Darwin':  # macOS
        data_dir = home / 'Library' / 'Application Support' / 'DailyWorkPlan'
    else:  # Linux/Unix
        data_dir = home / '.daily_work_plan'
    
    data_dir.mkdir(parents=True, exist_ok=True)
    return data_dir / 'data.json'

def load_existing_data():
    """加载现有数据"""
    data_path = get_data_path()
    if data_path.exists():
        try:
            with open(data_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except:
            return []
    return []

def get_today_data():
    """获取今日数据"""
    data = load_existing_data()
    today = datetime.datetime.now().strftime('%Y-%m-%d')
    
    for entry in data:
        if entry.get('date', '').startswith(today):
            return entry
    return None

def should_remind():
    """判断是否需要提醒"""
    today_data = get_today_data()
    now = datetime.datetime.now()
    
    # 如果今天还没填写
    if not today_data:
        return True
    
    # 如果填写时间在晚上8点前，晚上8点后提醒再次检查
    if now.hour >= 20:
        entry_time = today_data.get('time', '')
        # 简单检查时间格式
        if ':' in entry_time:
            try:
                hour = int(entry_time.split(':')[0])
                if hour < 20:  # 如果是在晚上8点前填写的
                    return True
            except:
                pass
    
    return False

def open_browser():
    """打开浏览器"""
    # 获取当前脚本所在目录
    script_dir = Path(__file__).parent.absolute()
    html_file = script_dir / 'daily_work_plan.html'
    
    if not html_file.exists():
        print(f"错误: 找不到HTML文件: {html_file}")
        print(f"当前目录: {script_dir}")
        return False
    
    # 转换为file:// URL
    html_url = html_file.as_uri()
    
    print("=" * 60)
    print("📋 每日工作计划系统")
    print("=" * 60)
    print(f"时间: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    today_data = get_today_data()
    if today_data:
        print("✅ 今日已填写")
        if 'todayWork' in today_data and today_data['todayWork']:
            print(f"   工作内容: {today_data['todayWork'][:50]}...")
    else:
        print("⚠️  今日尚未填写")
    
    print(f"\n正在打开: {html_url}")
    print("=" * 60)
    
    # 打开浏览器
    try:
        # 尝试用默认浏览器打开
        webbrowser.open(html_url)
        
        # 如果是macOS，尝试用特定命令确保打开
        if platform.system() == 'Darwin':
            os.system(f'open "{html_file}"')
        elif platform.system() == 'Windows':
            os.system(f'start "" "{html_file}"')
        elif platform.system() == 'Linux':
            os.system(f'xdg-open "{html_file}"')
            
        return True
    except Exception as e:
        print(f"打开浏览器时出错: {e}")
        print(f"请手动打开文件: {html_file}")
        return False

def check_streak():
    """检查连续打卡天数"""
    data = load_existing_data()
    if not data:
        return 0
    
    # 按日期排序
    sorted_data = sorted(data, key=lambda x: x.get('date', ''), reverse=True)
    
    streak = 0
    today = datetime.datetime.now()
    
    for i, entry in enumerate(sorted_data):
        entry_date_str = entry.get('date', '')
        if not entry_date_str:
            continue
            
        try:
            entry_date = datetime.datetime.strptime(entry_date_str[:10], '%Y-%m-%d')
            expected_date = today - datetime.timedelta(days=i)
            
            if entry_date.date() == expected_date.date():
                streak += 1
            else:
                break
        except:
            continue
    
    return streak

def main():
    """主函数"""
    print("🚀 启动每日工作计划系统...")
    
    # 检查是否需要提醒
    if should_remind():
        print("\n🔔 提醒: 今日工作计划需要填写或更新！")
        
        # 检查连续打卡
        streak = check_streak()
        if streak > 0:
            print(f"🔥 连续打卡: {streak} 天")
            if streak >= 7:
                print("   🎉 习惯正在形成，继续保持！")
            elif streak >= 30:
                print("   🏆 太棒了！已经坚持一个月了！")
    else:
        print("\nℹ️  今日已完成填写，可以查看或更新。")
    
    # 打开浏览器
    success = open_browser()
    
    if success:
        print("\n✅ 系统已启动")
        print("   页面将在浏览器中打开...")
        print("\n💡 提示:")
        print("   1. 每天固定时间填写（建议晚上8点）")
        print("   2. 认真思考每个部分，强迫自己改变")
        print("   3. 定期回顾进度，持续改进")
    else:
        print("\n❌ 启动失败，请检查错误信息")
    
    # 非交互式环境跳过等待
    try:
        if platform.system() == 'Windows':
            input("\n按回车键退出...")
        else:
            input("\n按回车键退出...")
    except EOFError:
        print("\n✅ 脚本执行完成，页面已打开")
        pass

if __name__ == '__main__':
    main()