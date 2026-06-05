"""
Phase 1.7 - 设备级覆盖解析器

调用约定：
- resolve_theme(project, machine=None) → dict（key 与 PageTheme 字段对应）
- resolve_h5(project, machine=None)    → dict（key 与 H5Page 字段对应）
- resolve_led(project, machine=None)   → dict（key 与 LedPage 字段对应）

合并策略：**浅合并** (override key 存在时直接覆盖)
深层结构（blocks / form_fields / ads / shared_assets / privacy / submit_button / success_view / qr / input_config）
一律走整段替换语义 —— 简单可预测；编辑器侧若要「只改一个 block」也是
读出完整列表再改。
"""
from typing import Optional

from .models import H5Page, LedPage, PageTheme

# 谁是「合法可覆盖字段」的白名单 —— 防止编辑器误传 read-only 字段
ALLOWED_THEME_KEYS = {
    "brand_color", "accent_color", "text_color",
    "background_type", "background_value", "font_family",
    "shared_assets",
}
ALLOWED_H5_KEYS = {
    "header_title", "header_subtitle", "blocks", "form_fields",
    "privacy", "submit_button", "rate_limit", "success_view",
    "page1_background", "page2_background", "page3_background",
    "page1_button_text", "page1_button_font_size", "page1_button_padding",
    "page1_button_font_color", "page1_button_bg_color",
    "header_font_color", "header_font_size",
    "page2_button_text",
    "header_position", "button_position",
}
ALLOWED_LED_KEYS = {
    "header_title", "header_subtitle", "ads", "qr",
    "input_config", "footer_tip",
    "page1_blocks", "page2_blocks",
    "page1_background", "page2_background",
}


def _theme_to_dict(theme: PageTheme, request=None) -> dict:
    def abs_url(f):
        if not f:
            return None
        if request:
            return request.build_absolute_uri(f.url)
        return f.url

    return {
        "brand_color": theme.brand_color,
        "accent_color": theme.accent_color,
        "text_color": theme.text_color,
        "background_type": theme.background_type,
        "background_value": theme.background_value,
        "font_family": theme.font_family,
        "shared_assets": theme.shared_assets,
        # 文件字段：渲染时按需取 URL
        "logo_url": abs_url(theme.logo),
        "favicon_url": abs_url(theme.favicon),
        "background_image_url": abs_url(theme.background_image),
    }


def _ensure_css_unit(val):
    """纯数字自动加 px 后缀，已有单位的原样返回"""
    if val and str(val).strip().isdigit():
        return str(val).strip() + "px"
    return val or ""


def _h5_to_dict(page: H5Page) -> dict:
    return {
        "header_title": page.header_title,
        "header_subtitle": page.header_subtitle,
        "blocks": page.blocks or [],
        "form_fields": page.form_fields or [],
        "privacy": page.privacy or {},
        "submit_button": page.submit_button or {},
        "rate_limit": page.rate_limit,
        "success_view": page.success_view or {},
        "page1_background": page.page1_background or {},
        "page2_background": page.page2_background or {},
        "page3_background": page.page3_background or {},
        "page1_button_text": page.page1_button_text,
        "header_font_color": page.header_font_color or "#FFFFFF",
        "header_font_size": _ensure_css_unit(page.header_font_size) or "26",
        "page1_button_font_size": _ensure_css_unit(page.page1_button_font_size),
        "page1_button_padding": _ensure_css_unit(page.page1_button_padding),
        "page1_button_font_color": page.page1_button_font_color or "",
        "page1_button_bg_color": page.page1_button_bg_color or "",
        "page2_button_text": page.page2_button_text,
        "header_position": page.header_position or {},
        "button_position": page.button_position or {},
    }


def _led_to_dict(page: LedPage, request=None) -> dict:
    def abs_url(f):
        if not f:
            return None
        if request:
            return request.build_absolute_uri(f.url)
        return f.url

    result = {
        "header_title": page.header_title,
        "header_subtitle": page.header_subtitle,
        "ads": page.ads or [],
        "qr": page.qr or {},
        "qr_image_url": abs_url(page.qr_image),
        "input_config": page.input_config or {},
        "footer_tip": page.footer_tip,
        "page1_blocks": page.page1_blocks or [],
        "page2_blocks": page.page2_blocks or [],
        "page1_background": page.page1_background or {},
        "page2_background": page.page2_background or {},
    }

    # Post-process: resolve qr_code block image_path → image_url
    for block in result["page1_blocks"]:
        if block.get("type") == "qr_code":
            props = block.setdefault("props", {})
            if props.get("image_path") and not props.get("image_url"):
                props["image_url"] = abs_url(page.qr_image)
                props.pop("image_path", None)

    return result


def _apply(base: dict, override: dict, allowed: set) -> dict:
    if not override:
        return base
    merged = dict(base)
    for k, v in override.items():
        if k in allowed:
            merged[k] = v
    return merged


def _get_override(machine) -> Optional["DevicePageOverride"]:
    if machine is None:
        return None
    from .models import DevicePageOverride
    ovr = getattr(machine, "page_override", None)
    if not ovr or not ovr.enabled:
        return None
    return ovr


def resolve_theme(project, machine=None, request=None) -> dict:
    theme, _ = PageTheme.objects.get_or_create(project=project)
    base = _theme_to_dict(theme, request=request)
    ovr = _get_override(machine)
    if ovr:
        base = _apply(base, ovr.theme_override or {}, ALLOWED_THEME_KEYS)
    return base


def resolve_h5(project, machine=None) -> dict:
    page, _ = H5Page.objects.get_or_create(project=project)
    base = _h5_to_dict(page)
    ovr = _get_override(machine)
    if ovr:
        base = _apply(base, ovr.h5_override or {}, ALLOWED_H5_KEYS)
    return base


def _hash_bucket(seed: str) -> int:
    """把任意字符串映射到 0-99 的桶（用于 A/B 分流）"""
    import hashlib
    h = hashlib.md5(seed.encode("utf-8")).hexdigest()
    return int(h[:8], 16) % 100


def pick_experiment_variant(project, device_fp: str = "", cookie_variant: str = ""):
    """
    Phase 2.3 + 4.3 - 给一次访问挑变体。多变体支持 A/B/C/D
    返回 (experiment_or_None, variant_key_or_'', variant_h5_snapshot_or_None)

    分流：按各变体 traffic_share 累计区间，把哈希 bucket 落入对应桶
    例：A=30 B=30 C=20 D=20
        bucket [0,30)→A  [30,60)→B  [60,80)→C  [80,100)→D
    """
    from .models import Experiment
    exp = Experiment.objects.filter(
        project=project, status=Experiment.Status.RUNNING,
    ).prefetch_related("variants").first()
    if not exp:
        return None, "", None

    variants = list(exp.variants.all().order_by("key"))
    if not variants:
        return None, "", None
    keys = [v.key for v in variants]

    # cookie 粘性
    if cookie_variant in keys:
        variant_key = cookie_variant
    else:
        seed = device_fp or ""
        if not seed:
            import random
            bucket = random.randint(0, 99)
        else:
            bucket = _hash_bucket(f"{exp.id}:{seed}")

        # 累计区间分桶；若 shares 不合理（和不到 100），等分兜底
        shares = [max(0, int(v.traffic_share or 0)) for v in variants]
        total = sum(shares)
        if total <= 0 or total != 100:
            # 均分
            n = len(variants)
            per = 100 // n
            shares = [per] * n
            # 余数给最后一个
            shares[-1] += 100 - per * n
        # 找到 bucket 落在哪个累计区间
        cum = 0
        variant_key = variants[0].key
        for v, s in zip(variants, shares):
            cum += s
            if bucket < cum:
                variant_key = v.key
                break

    variant = next((v for v in variants if v.key == variant_key), None)
    return exp, variant_key, (variant.h5_snapshot if variant else None)


def resolve_led(project, machine=None, request=None) -> dict:
    page, _ = LedPage.objects.get_or_create(project=project)
    base = _led_to_dict(page, request=request)
    ovr = _get_override(machine)
    if ovr:
        base = _apply(base, ovr.led_override or {}, ALLOWED_LED_KEYS)
        # 文件字段：device 覆盖里有自己的 qr_image 就用 device 的
        if ovr.led_qr_image:
            if request:
                base["qr_image_url"] = request.build_absolute_uri(ovr.led_qr_image.url)
            else:
                base["qr_image_url"] = ovr.led_qr_image.url
    return base
