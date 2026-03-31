#!/usr/bin/env python3
"""
HI拿派样机 - 库存管理器
负责本地库存计数 + 定时上报云端
"""

import json
import time
import logging
import threading
import requests
from pathlib import Path

logger = logging.getLogger(__name__)

# 库存数据存储路径
INVENTORY_FILE = Path("/opt/hinana-vending/inventory.json")

# 云端上报地址（你的服务器）
CLOUD_REPORT_URL = "http://150.158.20.232/api/device/inventory-report"

# 每个货道初始库存
DEFAULT_QTY = 5

# 60个货道
ALL_CHANNELS = [
    f"{row}{col}"
    for row in "ABCDEF"
    for col in "0123456789"
]


class InventoryManager:
    """本地库存管理器"""

    def __init__(self, imei: str, report_interval: int = 300):
        """
        :param imei: 设备IMEI或唯一ID（用于云端识别设备）
        :param report_interval: 上报间隔秒数，默认5分钟
        """
        self.imei = imei
        self.report_interval = report_interval
        self._inventory = {}
        self._lock = threading.Lock()
        self._reporter_thread = None
        self._stop_event = threading.Event()

        self._load_inventory()

    def _load_inventory(self):
        """从本地文件加载库存"""
        if INVENTORY_FILE.exists():
            try:
                with open(INVENTORY_FILE, "r") as f:
                    self._inventory = json.load(f)
                logger.info(f"库存已加载，{len(self._inventory)} 个货道")
                return
            except Exception as e:
                logger.warning(f"库存文件读取失败: {e}，重置为默认值")

        # 初始化所有货道库存
        self._inventory = {ch: DEFAULT_QTY for ch in ALL_CHANNELS}
        self._save_inventory()
        logger.info(f"库存已初始化，{len(ALL_CHANNELS)} 个货道，每道 {DEFAULT_QTY} 个")

    def _save_inventory(self):
        """持久化库存到本地文件"""
        try:
            INVENTORY_FILE.parent.mkdir(parents=True, exist_ok=True)
            with open(INVENTORY_FILE, "w") as f:
                json.dump(self._inventory, f, indent=2)
        except Exception as e:
            logger.error(f"库存保存失败: {e}")

    def get(self, channel: str) -> int:
        """获取货道库存数量"""
        return self._inventory.get(channel.upper(), 0)

    def get_all(self) -> dict:
        """获取全部货道库存"""
        with self._lock:
            return dict(self._inventory)

    def decrement(self, channel: str) -> int:
        """出货后减少库存，返回剩余数量"""
        channel = channel.upper()
        with self._lock:
            current = self._inventory.get(channel, 0)
            if current > 0:
                self._inventory[channel] = current - 1
                self._save_inventory()
                logger.info(f"货道 {channel} 出货，剩余: {self._inventory[channel]}")
            else:
                logger.warning(f"货道 {channel} 库存为0，无法减少")
            return self._inventory.get(channel, 0)

    def set_qty(self, channel: str, qty: int):
        """手动设置货道库存（补货时使用）"""
        channel = channel.upper()
        with self._lock:
            self._inventory[channel] = qty
            self._save_inventory()
        logger.info(f"货道 {channel} 库存设置为: {qty}")

    def replenish_all(self, qty: int = DEFAULT_QTY):
        """全部货道补满"""
        with self._lock:
            for ch in ALL_CHANNELS:
                self._inventory[ch] = qty
            self._save_inventory()
        logger.info(f"全部货道已补货至: {qty}")

    # ─── 云端上报 ──────────────────────────────────────────
    def report_to_cloud(self) -> bool:
        """上报库存到云端"""
        channels_data = [
            {"no": i + 1, "channel": ch, "qty": self._inventory.get(ch, 0)}
            for i, ch in enumerate(ALL_CHANNELS)
        ]
        payload = {
            "imei": self.imei,
            "channels": channels_data,
            "timestamp": time.strftime("%Y-%m-%dT%H:%M:%S")
        }

        try:
            resp = requests.post(
                CLOUD_REPORT_URL,
                json=payload,
                timeout=10
            )
            if resp.status_code == 200:
                logger.info(f"库存上报成功: {resp.json()}")
                return True
            else:
                logger.warning(f"云端上报失败: HTTP {resp.status_code} - {resp.text[:100]}")
                return False
        except requests.exceptions.ConnectionError:
            logger.warning("网络不可达，跳过本次上报（离线模式）")
            return False
        except Exception as e:
            logger.error(f"上报异常: {e}")
            return False

    def start_auto_report(self):
        """启动定时上报线程"""
        if self._reporter_thread and self._reporter_thread.is_alive():
            return

        self._stop_event.clear()
        self._reporter_thread = threading.Thread(
            target=self._report_loop,
            daemon=True,
            name="InventoryReporter"
        )
        self._reporter_thread.start()
        logger.info(f"定时上报已启动，间隔: {self.report_interval}s")

    def stop_auto_report(self):
        """停止定时上报"""
        self._stop_event.set()

    def _report_loop(self):
        """上报循环（后台线程）"""
        # 启动时立即上报一次
        self.report_to_cloud()

        while not self._stop_event.wait(self.report_interval):
            self.report_to_cloud()


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG, format="%(asctime)s [%(levelname)s] %(message)s")

    mgr = InventoryManager(imei="ORANGEPI-TEST-001")
    print("当前库存:", mgr.get_all())

    # 测试出货
    mgr.decrement("A0")
    print("A0出货后:", mgr.get("A0"))

    # 测试上报（需要网络）
    # mgr.report_to_cloud()
