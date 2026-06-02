"""
地址 → 经纬度（地理编码）
使用腾讯位置服务 API：https://lbs.qq.com/service/geocoder/geocoder-web
需要先在 lbs.qq.com 申请 key，填到 GEOCODING_API_KEY 环境变量。
没有 key 时静默跳过，不影响正常业务流程。
"""
from __future__ import annotations

import json
import logging
from typing import Optional
from urllib.request import urlopen
from urllib.parse import quote

from django.conf import settings

logger = logging.getLogger(__name__)


def geocode(address: str) -> Optional[tuple[str, str]]:
    """
    传入地址文本，返回 (lng, lat) 字符串元组。
    解析失败或未配置 key 时返回 None。
    """
    key = settings.GEOCODING_API_KEY
    if not key:
        logger.debug("geocoding: GEOCODING_API_KEY 未配置，跳过")
        return None

    if not address or not address.strip():
        return None

    encoded = quote(address.strip())
    url = f"https://apis.map.qq.com/ws/geocoder/v1/?address={encoded}&key={key}"

    try:
        with urlopen(url, timeout=5) as resp:
            data = json.loads(resp.read())
    except Exception as e:
        logger.warning("geocoding: 请求失败 %s", e)
        return None

    if data.get("status") != 0:
        logger.warning("geocoding: API 返回错误 status=%s message=%s",
                       data.get("status"), data.get("message"))
        return None

    location = data.get("result", {}).get("location")
    if not location:
        return None

    lng = str(location["lng"])
    lat = str(location["lat"])
    logger.info("geocoding: %s → (%s, %s)", address, lng, lat)
    return (lng, lat)
