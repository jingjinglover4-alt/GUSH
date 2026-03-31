#!/usr/bin/env python3
"""
HI拿派样机 - 串口通信测试脚本
在Orange Pi上运行，测试与STM32的通信是否正常
"""

import serial
import time
import sys

SERIAL_PORT = "/dev/ttyUSB0"
BAUDRATE = 115200

def test_serial():
    """测试串口连接和基本通信"""
    print(f"测试串口: {SERIAL_PORT} @ {BAUDRATE}")
    print("=" * 50)
    
    try:
        # 打开串口
        ser = serial.Serial(
            SERIAL_PORT,
            baudrate=BAUDRATE,
            bytesize=serial.EIGHTBITS,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            timeout=2
        )
        print("✅ 串口打开成功")
        
        # 清空缓冲区
        ser.reset_input_buffer()
        time.sleep(0.1)
        
        # 读取欢迎语（如果有）
        print("\n等待STM32欢迎语（5秒内）...")
        start = time.time()
        while time.time() - start < 5:
            if ser.in_waiting:
                line = ser.readline().decode('ascii', errors='ignore').strip()
                if line:
                    print(f"  STM32: {line}")
            time.sleep(0.1)
        
        # 测试出货指令
        print("\n➡️ 测试出货指令: A0")
        ser.write(b"A0\n")
        
        # 等待回复
        print("等待回复（5秒内）...")
        start = time.time()
        got_ok = False
        while time.time() - start < 5:
            if ser.in_waiting:
                line = ser.readline().decode('ascii', errors='ignore').strip()
                if line:
                    print(f"  STM32: {line}")
                    if line.startswith("OK:"):
                        print("✅ 出货指令被接受")
                        got_ok = True
                    elif line.startswith("ERR:") or line.startswith("ERROR:"):
                        print(f"❌ 出货失败: {line}")
                    elif line.startswith("DONE:"):
                        print(f"✅ 出货完成: {line}")
            time.sleep(0.1)
        
        if not got_ok:
            print("⚠️  未收到OK响应，但可能STM32正在执行出货")
        
        # 测试无效指令
        print("\n➡️ 测试无效指令: Z9")
        ser.write(b"Z9\n")
        
        start = time.time()
        while time.time() - start < 3:
            if ser.in_waiting:
                line = ser.readline().decode('ascii', errors='ignore').strip()
                if line:
                    print(f"  STM32: {line}")
                    if line.startswith("ERR:"):
                        print("✅ 无效指令被正确拒绝")
            time.sleep(0.1)
        
        ser.close()
        print("\n" + "=" * 50)
        print("✅ 串口测试完成")
        print("如果看到OK: Slot1等响应，说明通信正常")
        print("如果没看到响应，请检查：")
        print("1. USB转TTL是否插好")
        print("2. STM32是否通电")
        print("3. 波特率是否为115200")
        
    except serial.SerialException as e:
        print(f"❌ 串口打开失败: {e}")
        print("\n可能的解决方法:")
        print(f"1. 检查设备路径: ls /dev/ttyUSB*")
        print("2. 检查串口权限: sudo chmod 666 /dev/ttyUSB0")
        print("3. 检查USB转TTL驱动")
        return 1
    
    return 0

if __name__ == "__main__":
    # 如果指定了串口路径
    if len(sys.argv) > 1:
        SERIAL_PORT = sys.argv[1]
        print(f"使用自定义串口: {SERIAL_PORT}")
    
    sys.exit(test_serial())