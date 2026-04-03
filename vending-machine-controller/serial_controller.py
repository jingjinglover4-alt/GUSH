#!/usr/bin/env python3
"""
HI拿派样机 - 串口控制器
Orange Pi 3B V2.1 <-> STM32F407
波特率: 115200, 8N1 (8数据位, 无校验, 1停止位)
连接方式: USB转TTL

下位机协议（STM32二进制帧协议）：
- 出货指令: [0xAA] [行字节] [列字节] [0xBB]
  例如 A0货道 -> AA 41 30 BB
- 回复帧: [0xCC] [行字节] [列字节] [状态] [0xDD]
  状态: 0x01=成功, 0x02=失败(空仓/故障), 0x03=执行中
"""

import serial
import time
import threading
import logging

logger = logging.getLogger(__name__)

# 帧定义
FRAME_HEAD = 0xAA  # 指令帧头
FRAME_TAIL = 0xBB  # 指令帧尾
RESP_HEAD  = 0xCC  # 回复帧头
RESP_TAIL  = 0xDD  # 回复帧尾

# 回复状态码
STATUS_OK    = 0x01  # 出货成功
STATUS_EMPTY = 0x02  # 出货失败（货道空或机械故障）
STATUS_BUSY  = 0x03  # 执行中（请等待）

# 合法货道编码: A0~F9（6行×10列=60个货道）
VALID_CHANNELS = [
    f"{row}{col}"
    for row in "ABCDEF"
    for col in "0123456789"
]


class SerialController:
    """串口控制器，负责与STM32通信（二进制帧协议）"""

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
        """发送二进制帧出货指令并等待回复（内部方法，已加锁）"""
        row_char = ord(channel[0])   # 'A'=0x41 ~ 'F'=0x46
        col_char = ord(channel[1])   # '0'=0x30 ~ '9'=0x39

        # 构造指令帧: [0xAA] [行字节] [列字节] [0xBB]
        cmd = bytes([FRAME_HEAD, row_char, col_char, FRAME_TAIL])

        try:
            self.ser.reset_input_buffer()
            self.ser.write(cmd)
            logger.info(f"[TX] 出货指令: {channel} → {cmd.hex().upper()}")

            # 等待回复帧: [0xCC] [行字节] [列字节] [状态] [0xDD]
            start_time = time.time()
            rx_buf = bytearray()

            while time.time() - start_time < self.timeout:
                if self.ser.in_waiting:
                    data = self.ser.read(self.ser.in_waiting)
                    rx_buf.extend(data)

                    # 尝试解析完整的回复帧（5字节）
                    result = self._parse_response(rx_buf, channel)
                    if result is not None:
                        return result
                else:
                    time.sleep(0.02)  # 20ms 轮询间隔

            logger.warning(f"[RX] 回复超时，未收到有效响应 (buf: {rx_buf.hex().upper()})")
            return {"success": False, "status": "timeout", "channel": channel}

        except serial.SerialException as e:
            logger.error(f"串口通信异常: {e}")
            self.ser = None  # 标记为断线，下次重连
            return {"success": False, "status": "serial_error", "channel": channel}

    def _parse_response(self, buf: bytearray, channel: str):
        """
        解析回复帧，找到合法帧后返回结果。
        回复帧格式: [0xCC] [行字节] [列字节] [状态] [0xDD]
        :return: 解析成功返回结果dict，否则返回None（继续等待）
        """
        # 扫描缓冲区，查找帧头 0xCC
        i = 0
        while i <= len(buf) - 5:
            if buf[i] == RESP_HEAD and buf[i + 4] == RESP_TAIL:
                resp_row  = buf[i + 1]  # echo 回来的行字节
                resp_col  = buf[i + 2]  # echo 回来的列字节
                status    = buf[i + 3]  # 状态码

                resp_channel = chr(resp_row) + chr(resp_col)
                logger.info(
                    f"[RX] 收到回复帧: {bytes(buf[i:i+5]).hex().upper()} "
                    f"→ channel={resp_channel}, status=0x{status:02X}"
                )

                if status == STATUS_OK:
                    return {"success": True, "status": "ok", "channel": resp_channel}
                elif status == STATUS_BUSY:
                    # 执行中，继续等待
                    logger.info(f"[RX] 出货执行中，继续等待...")
                    buf = buf[i + 5:]  # 移除已解析帧，继续等待下一帧
                    i = 0
                    continue
                else:  # STATUS_EMPTY 或其他错误
                    err_msg = {
                        STATUS_EMPTY: "货道空或机械故障",
                    }.get(status, f"未知错误码 0x{status:02X}")
                    logger.warning(f"[RX] 出货失败: {err_msg}")
                    return {"success": False, "status": "dispense_failed", "message": err_msg, "channel": resp_channel}
            i += 1

        return None  # 未找到完整帧，继续等待

    def query_inventory(self) -> dict:
        """
        查询所有货道库存（可选功能）
        当前协议版本不支持主动查询，由主控自行维护计数。
        """
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
