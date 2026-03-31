#!/usr/bin/env python3
"""
HI拿派样机 - 串口控制器
Orange Pi 3B V2.1 <-> STM32F407
波特率: 115200, 8N1 (8数据位, 无校验, 1停止位)
连接方式: USB转TTL

下位机协议（STM32现有固件）：
- 指令: 2个ASCII字符（列字母+行数字） + 换行符（'\n'）
  例如 A0货道 -> "A0\n"
- 响应: 文本行（以\\r\\n结尾）
  成功: "OK: Slot1\\r\\n"
  错误: "ERR: Invalid slot\\r\\n"
  出货完成: "DONE: Slot1 OK\\r\\n"
  出错: "ERROR: Slot1 Fail\\r\\n"
"""

import serial
import time
import threading
import logging

logger = logging.getLogger(__name__)

# 合法货道编码: A0~F9（6行×10列=60个货道）
VALID_CHANNELS = [
    f"{row}{col}"
    for row in "ABCDEF"
    for col in "0123456789"
]


class SerialController:
    """串口控制器，负责与STM32通信"""

    def __init__(self, port="/dev/ttyUSB0", baudrate=115200, timeout=5):
        """
        初始化串口控制器
        :param port: 串口设备路径，USB转TTL通常是 /dev/ttyUSB0
        :param baudrate: 波特率，115200
        :param timeout: 等待回复超时秒数
        """
        self.port = port
        self.baudrate = baudrate
        self.timeout = timeout
        self.ser = None
        self._lock = threading.Lock()  # 防止并发出货

    def connect(self):
        """打开串口连接"""
        try:
            self.ser = serial.Serial(
                port=self.baudrate,
                baudrate=self.baudrate,
                bytesize=serial.EIGHTBITS,
                parity=serial.PARITY_NONE,
                stopbits=serial.STOPBITS_ONE,
                timeout=self.timeout
            )
            # 修正：第一个参数是 port
            self.ser = serial.Serial(
                self.port,
                baudrate=self.baudrate,
                bytesize=serial.EIGHTBITS,
                parity=serial.PARITY_NONE,
                stopbits=serial.STOPBITS_ONE,
                timeout=self.timeout
            )
            logger.info(f"串口已连接: {self.port} @ {self.baudrate}")
            return True
        except serial.SerialException as e:
            logger.error(f"串口连接失败: {e}")
            return False

    def disconnect(self):
        """关闭串口"""
        if self.ser and self.ser.is_open:
            self.ser.close()
            logger.info("串口已关闭")

    def is_connected(self):
        return self.ser is not None and self.ser.is_open

    def dispense(self, channel: str) -> dict:
        """
        触发出货
        :param channel: 货道编码，如 "A0", "F9"
        :return: {"success": bool, "status": str, "channel": str}
        """
        channel = channel.upper().strip()

        # 验证货道编码
        if channel not in VALID_CHANNELS:
            return {"success": False, "status": "invalid_channel", "channel": channel}

        if not self.is_connected():
            logger.warning("串口未连接，尝试重连...")
            if not self.connect():
                return {"success": False, "status": "serial_not_connected", "channel": channel}

        with self._lock:
            return self._send_dispense_cmd(channel)

    def _send_dispense_cmd(self, channel: str) -> dict:
        """发送出货指令并等待回复（内部方法，已加锁）"""
        # 指令格式: 两个ASCII字符 + 换行符
        cmd = f"{channel}\n".encode("ascii")

        try:
            self.ser.reset_input_buffer()
            self.ser.write(cmd)
            logger.info(f"[TX] 出货指令: {channel} → {cmd.hex().upper()} ({cmd})")

            # 等待回复行（以\\r\\n结尾）
            # 下位机可能会先发送欢迎语等无关信息，需要过滤
            start_time = time.time()
            while time.time() - start_time < self.timeout:
                if self.ser.in_waiting:
                    line = self.ser.readline().decode("ascii", errors="ignore").strip()
                    if not line:
                        continue
                    logger.info(f"[RX] 收到: {line}")
                    
                    # 解析回复
                    if line.startswith("OK:"):
                        # 成功接受指令
                        logger.info(f"[OK] 出货指令已接受: {channel}")
                        return {"success": True, "status": "ok", "channel": channel}
                    elif line.startswith("ERR:") or line.startswith("ERROR:"):
                        logger.warning(f"[ERROR] 出货失败: {line}")
                        return {"success": False, "status": line.split(":", 1)[1].strip(), "channel": channel}
                    elif line.startswith("DONE:"):
                        # 出货完成消息，可以忽略（已在 OK 时扣库存）
                        continue
                    else:
                        # 其他信息（如欢迎语、调试输出）忽略，继续等待有效回复
                        continue
            
            logger.warning(f"[RX] 回复超时，未收到有效响应")
            return {"success": False, "status": "timeout", "channel": channel}

        except serial.SerialException as e:
            logger.error(f"串口通信异常: {e}")
            self.ser = None  # 标记为断线，下次重连
            return {"success": False, "status": "serial_error", "channel": channel}

    def query_inventory(self) -> dict:
        """
        查询所有货道库存（可选功能）
        如果STM32支持主动上报库存，则通过回调处理；
        如果不支持，返回空字典（由主控自行维护计数）
        """
        # TODO: 根据STM32固件实际支持情况实现
        return {}


# ─── 自动检测串口 ─────────────────────────────────────────────
def find_serial_port() -> str:
    """自动查找USB转TTL设备路径"""
    import glob
    candidates = glob.glob("/dev/ttyUSB*") + glob.glob("/dev/ttyACM*")
    if candidates:
        logger.info(f"找到串口设备: {candidates}")
        return candidates[0]
    logger.warning("未找到USB串口设备，使用默认 /dev/ttyUSB0")
    return "/dev/ttyUSB0"


if __name__ == "__main__":
    # 简单测试
    logging.basicConfig(level=logging.DEBUG, format="%(asctime)s [%(levelname)s] %(message)s")

    port = find_serial_port()
    ctrl = SerialController(port=port)

    if ctrl.connect():
        # 测试出货 A0 货道
        result = ctrl.dispense("A0")
        print(f"出货结果: {result}")
        ctrl.disconnect()
    else:
        print("串口连接失败，请检查设备连接")
