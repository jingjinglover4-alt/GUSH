#!/usr/bin/env python3
"""
HI拿派样机 - 本地HTTP API服务
接收云端下发的出货指令，驱动串口控制STM32
"""

import os
import time
import json
import logging
import requests
from flask import Flask, request, jsonify
from serial_controller import SerialController, find_serial_port
from inventory_manager import InventoryManager

# ─── 配置 ────────────────────────────────────────────────────
DEVICE_IMEI   = os.environ.get("DEVICE_IMEI", "ORANGEPI-001")
SERIAL_PORT   = os.environ.get("SERIAL_PORT", find_serial_port())
API_PORT      = int(os.environ.get("API_PORT", 8080))
API_TOKEN     = os.environ.get("API_TOKEN", "hinana-device-token-change-me")

# 云端地址
CLOUD_API_URL = os.environ.get("CLOUD_API_URL", "http://150.158.20.232")

# ─── 初始化 ──────────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s - %(message)s",
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler("/opt/hinana-vending/vending.log", encoding="utf-8")
    ]
)
logger = logging.getLogger(__name__)

app = Flask(__name__)
serial_ctrl = SerialController(port=SERIAL_PORT)
inventory   = InventoryManager(imei=DEVICE_IMEI)

# ─── 位置管理器 ───────────────────────────────────────────────
class LocationManager:
    """基站定位管理器"""
    
    def __init__(self):
        self.last_location = None
        self.last_update = None
    
    def get_lbs_location(self) -> dict:
        """
        通过4G模块获取基站定位
        返回: {"lat": xx, "lng": xx, "address": "xxx", "accuracy": xxx}
        """
        try:
            # 方式1: 通过 AT 命令获取基站信息（Quectel模块通用）
            # 这里我们用简化方式：获取公网IP反查地理位置
            
            # 获取公网IP
            try:
                ip_resp = requests.get("https://api.ipify.org?format=json", timeout=5)
                public_ip = ip_resp.json().get("ip", "")
            except:
                public_ip = ""
            
            if not public_ip:
                return {"error": "无法获取公网IP"}
            
            # 调用IP定位API（使用高德服务，免费额度足够）
            try:
                # 高德IP定位API（需要申请key，这里用免费版）
                lbs_url = f"https://restapi.amap.com/v3/ip?key=&ip={public_ip}"
                lbs_resp = requests.get(lbs_url, timeout=5)
                lbs_data = lbs_resp.json()
                
                if lbs_data.get("status") == "1":
                    rect = lbs_data.get("rectangle", "")
                    if rect:
                        # rectangle格式: "116.35,39.94;116.41,40.00"
                        parts = rect.split(";")
                        if len(parts) == 2:
                            lng1, lat1 = parts[0].split(",")
                            lng2, lat2 = parts[1].split(",")
                            center_lng = (float(lng1) + float(lng2)) / 2
                            center_lat = (float(lat1) + float(lat2)) / 2
                            
                            location = {
                                "lat": round(center_lat, 6),
                                "lng": round(center_lng, 6),
                                "address": lbs_data.get("province", "") + lbs_data.get("city", "") + lbs_data.get("district", ""),
                                "city": lbs_data.get("city", ""),
                                "province": lbs_data.get("province", ""),
                                "ip": public_ip,
                                "accuracy": 1000,  # IP定位精度约1km
                                "source": "ip"
                            }
                            self.last_location = location
                            self.last_update = time.time()
                            return location
            except Exception as e:
                logger.warning(f"高德API调用失败: {e}")
            
            # 方式2: 备用的IP.SO免费服务
            try:
                ip_resp = requests.get(f"http://ip-api.com/json/{public_ip}?fields=status,country,city,lat,lon", timeout=5)
                data = ip_resp.json()
                if data.get("status") == "success":
                    location = {
                        "lat": data.get("lat", 0),
                        "lng": data.get("lon", 0),
                        "address": f"{data.get('country', '')}{data.get('city', '')}",
                        "city": data.get("city", ""),
                        "ip": public_ip,
                        "accuracy": 5000,  # ip-api精度约城市级别
                        "source": "ip-api"
                    }
                    self.last_location = location
                    self.last_location = time.time()
                    return location
            except Exception as e:
                logger.warning(f"ip-api调用失败: {e}")
            
            return {"error": "所有定位服务均失败"}
            
        except Exception as e:
            logger.error(f"定位异常: {e}")
            return {"error": str(e)}
    
    def get_cached_location(self) -> dict:
        """获取缓存的位置（如果存在且在10分钟内）"""
        if self.last_location and self.last_update:
            if time.time() - self.last_update < 600:  # 10分钟内有效
                return self.last_location
        return None


location_mgr = LocationManager()


def check_token():
    """验证请求token"""
    token = request.headers.get("X-Device-Token") or request.args.get("token")
    return token == API_TOKEN


# ─── API 路由 ────────────────────────────────────────────────

@app.route("/health", methods=["GET"])
def health():
    """健康检查"""
    return jsonify({
        "status": "ok",
        "device": DEVICE_IMEI,
        "serial": SERIAL_PORT,
        "serial_connected": serial_ctrl.is_connected()
    })


@app.route("/location", methods=["GET"])
def get_location():
    """
    获取当前设备位置
    GET /location
    """
    if not check_token():
        return jsonify({"success": False, "error": "unauthorized"}), 401
    
    # 先尝试返回缓存
    cached = location_mgr.get_cached_location()
    if cached:
        return jsonify({
            "success": True,
            "cached": True,
            "location": cached
        })
    
    # 重新获取
    loc = location_mgr.get_lbs_location()
    if "error" in loc:
        return jsonify({
            "success": False,
            "error": loc["error"]
        }), 500
    
    return jsonify({
        "success": True,
        "cached": False,
        "location": loc
    })


@app.route("/location/report", methods=["POST"])
def report_location():
    """
    上报位置到云端
    POST /location/report
    """
    if not check_token():
        return jsonify({"success": False, "error": "unauthorized"}), 401
    
    # 获取位置
    loc = location_mgr.get_lbs_location()
    if "error" in loc:
        return jsonify({
            "success": False,
            "error": loc["error"]
        }), 500
    
    # 上报到云端
    try:
        report_url = f"{CLOUD_API_URL}/api/device/location-report"
        payload = {
            "imei": DEVICE_IMEI,
            **loc,
            "timestamp": time.strftime("%Y-%m-%dT%H:%M:%S")
        }
        resp = requests.post(report_url, json=payload, timeout=10)
        if resp.status_code == 200:
            logger.info(f"位置上报成功: {loc.get('address')}")
            return jsonify({"success": True, "location": loc})
        else:
            logger.warning(f"云端位置上报失败: {resp.status_code}")
            return jsonify({"success": False, "error": "cloud rejected"}), 500
    except Exception as e:
        logger.error(f"位置上报异常: {e}")
        return jsonify({"success": False, "error": str(e)}), 500


@app.route("/dispense", methods=["POST"])
def dispense():
    """
    出货接口
    POST /dispense
    Headers: X-Device-Token: <token>
    Body: {"channel": "A0"}
    """
    if not check_token():
        return jsonify({"success": False, "error": "unauthorized"}), 401

    data = request.get_json(silent=True) or {}
    channel = data.get("channel", "").upper().strip()

    if not channel:
        return jsonify({"success": False, "error": "missing channel"}), 400

    # 检查库存
    qty = inventory.get(channel)
    if qty <= 0:
        logger.warning(f"货道 {channel} 库存不足，拒绝出货")
        return jsonify({
            "success": False,
            "error": "out_of_stock",
            "channel": channel,
            "qty": 0
        })

    # 驱动出货
    result = serial_ctrl.dispense(channel)

    if result["success"]:
        # 出货成功，减少库存
        remaining = inventory.decrement(channel)
        result["remaining_qty"] = remaining
        # 立即上报库存变更
        inventory.report_to_cloud()

    return jsonify(result)


@app.route("/inventory", methods=["GET"])
def get_inventory():
    """获取全部库存"""
    if not check_token():
        return jsonify({"success": False, "error": "unauthorized"}), 401

    return jsonify({
        "success": True,
        "device": DEVICE_IMEI,
        "inventory": inventory.get_all()
    })


@app.route("/inventory/<channel>", methods=["PUT"])
def set_inventory(channel):
    """
    设置单个货道库存（补货用）
    PUT /inventory/A0
    Body: {"qty": 5}
    """
    if not check_token():
        return jsonify({"success": False, "error": "unauthorized"}), 401

    data = request.get_json(silent=True) or {}
    qty = data.get("qty")

    if qty is None or not isinstance(qty, int) or qty < 0:
        return jsonify({"success": False, "error": "invalid qty"}), 400

    inventory.set_qty(channel.upper(), qty)
    return jsonify({"success": True, "channel": channel.upper(), "qty": qty})


@app.route("/inventory/replenish", methods=["POST"])
def replenish_all():
    """全部货道补货至满"""
    if not check_token():
        return jsonify({"success": False, "error": "unauthorized"}), 401

    data = request.get_json(silent=True) or {}
    qty = data.get("qty", 5)
    inventory.replenish_all(qty)
    inventory.report_to_cloud()
    return jsonify({"success": True, "message": f"全部货道已补货至 {qty}"})


@app.route("/report", methods=["POST"])
def force_report():
    """手动触发云端上报"""
    if not check_token():
        return jsonify({"success": False, "error": "unauthorized"}), 401

    ok = inventory.report_to_cloud()
    return jsonify({"success": ok})


# ─── 启动 ────────────────────────────────────────────────────
def start_location_report():
    """启动时上报一次位置"""
    def delayed_report():
        time.sleep(5)  # 等待网络就绪
        try:
            resp = requests.post(
                f"http://localhost:{API_PORT}/location/report",
                headers={"X-Device-Token": API_TOKEN},
                timeout=10
            )
            if resp.status_code == 200:
                logger.info("启动位置上报成功")
            else:
                logger.warning(f"启动位置上报失败: {resp.status_code}")
        except Exception as e:
            logger.warning(f"启动位置上报异常: {e}")
    
    import threading
    t = threading.Thread(target=delayed_report, daemon=True)
    t.start()


if __name__ == "__main__":
    import os
    os.makedirs("/opt/hinana-vending", exist_ok=True)

    logger.info(f"设备ID: {DEVICE_IMEI}")
    logger.info(f"串口: {SERIAL_PORT}")
    logger.info(f"API端口: {API_PORT}")

    # 连接串口
    if not serial_ctrl.connect():
        logger.error("串口连接失败！请检查USB转TTL连接和设备路径")
    else:
        logger.info("串口连接成功")

    # 启动定时上报
    inventory.start_auto_report()
    
    # 启动时上报位置
    start_location_report()

    # 启动HTTP服务
    app.run(host="0.0.0.0", port=API_PORT, debug=False)
