#!/usr/bin/env python3
"""
iPhone访问每日工作计划系统 - HTTP服务器
在电脑上运行此脚本，然后iPhone通过WiFi访问
"""

import http.server
import socketserver
import os
import sys
import webbrowser
from datetime import datetime

# 尝试导入qrcode，如果未安装则跳过二维码功能
try:
    import qrcode
    from io import BytesIO
    import base64
    QRCODE_AVAILABLE = True
except ImportError:
    QRCODE_AVAILABLE = False

def get_ip_address():
    """获取本机局域网IP地址"""
    import socket
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # 连接一个外部地址（不发送数据）
        s.connect(('8.8.8.8', 80))
        ip = s.getsockname()[0]
    except Exception:
        ip = '127.0.0.1'
    finally:
        s.close()
    return ip

def generate_qr_code(url):
    """生成访问URL的二维码（返回base64）"""
    if not QRCODE_AVAILABLE:
        return None
    
    try:
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        qr.add_data(url)
        qr.make(fit=True)
        
        img = qr.make_image(fill_color="black", back_color="white")
        
        # 转换为base64
        buffered = BytesIO()
        img.save(buffered, format="PNG")
        img_str = base64.b64encode(buffered.getvalue()).decode()
        return img_str
    except Exception:
        return None

def start_server(port=8000):
    """启动HTTP服务器"""
    ip_address = get_ip_address()
    url = f"http://{ip_address}:{port}/daily_work_plan.html"
    
    # 切换到脚本所在目录
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)
    
    # 检查HTML文件是否存在
    if not os.path.exists("daily_work_plan.html"):
        print("❌ 错误: 找不到 daily_work_plan.html 文件")
        print(f"当前目录: {script_dir}")
        return
    
    # 生成二维码
    qr_base64 = generate_qr_code(url)
    
    print("=" * 60)
    print("📱 iPhone访问每日工作计划系统")
    print("=" * 60)
    print(f"时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"电脑IP地址: {ip_address}")
    print(f"访问端口: {port}")
    print(f"访问URL: {url}")
    print("")
    print("📱 在iPhone上访问方法:")
    print("1. 确保iPhone和电脑连接同一WiFi网络")
    print("2. 在iPhone Safari浏览器中输入:")
    print(f"   {url}")
    
    if qr_base64:
        print("3. 或扫描下方二维码👇")
        print("")
        # 显示二维码（base64格式，可在某些终端显示）
        print("🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥")
        print("⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️")
        print("⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️")
        print("⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️")
        print("⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️")
        print("⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬜️")
        print("🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥")
        print("")
        print("💡 提示: 如果无法扫描，请手动输入URL")
    elif not QRCODE_AVAILABLE:
        print("")
        print("📱 二维码功能:")
        print("   如需二维码扫描，请安装qrcode库:")
        print("   pip install qrcode[pil]")
        print("   然后重新运行此脚本")
        print("")
        print("💡 提示: 暂时请手动输入URL访问")
    else:
        print("")
        print("💡 提示: 二维码生成失败，请手动输入URL访问")
    
    print("")
    print("📁 可访问文件:")
    print(f"  • daily_work_plan.html (主页面)")
    print(f"  • start_daily_plan.py (启动脚本)")
    print(f"  • DAILY_WORK_PLAN_README.md (使用指南)")
    print("")
    print("⏳ 服务器运行中... (按 Ctrl+C 停止)")
    print("=" * 60)
    
    # 在电脑浏览器中也打开（可选）
    try:
        webbrowser.open(f"http://localhost:{port}/daily_work_plan.html")
        print("✅ 已在电脑浏览器中打开页面")
    except:
        pass
    
    # 启动HTTP服务器
    handler = http.server.SimpleHTTPRequestHandler
    
    with socketserver.TCPServer(("", port), handler) as httpd:
        print(f"✅ HTTP服务器已启动，监听 {ip_address}:{port}")
        print("")
        
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n\n⏹️  服务器已停止")
        except Exception as e:
            print(f"\n❌ 服务器错误: {e}")

def main():
    """主函数"""
    print("🚀 启动iPhone访问服务器...")
    
    try:
        port = 8000
        start_server(port)
    except KeyboardInterrupt:
        print("\n👋 已退出")
    except Exception as e:
        print(f"\n❌ 启动失败: {e}")
        print("\n💡 解决方法:")
        print("1. 检查端口8000是否被占用")
        print("2. 尝试其他端口: python start_iphone_server.py 8080")
        print("3. 检查防火墙设置")

if __name__ == "__main__":
    # 可以指定端口，如: python start_iphone_server.py 8080
    if len(sys.argv) > 1:
        try:
            port = int(sys.argv[1])
            start_server(port)
        except ValueError:
            print(f"❌ 无效的端口号: {sys.argv[1]}")
            print("使用默认端口8000")
            start_server()
    else:
        main()