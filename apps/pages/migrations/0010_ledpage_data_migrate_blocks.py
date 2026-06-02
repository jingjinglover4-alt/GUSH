# Generated manually: migrate existing LedPage data to block format
# Converts: header_title/subtitle → text blocks, ads → image/video blocks,
#           qr_image/qr → qr_code block, input_config → redee block, footer_tip → text block

from django.db import migrations


def _convert_old_to_blocks(apps, schema_editor):
    LedPage = apps.get_model("pages", "LedPage")
    for page in LedPage.objects.all():
        p1 = []
        p2 = []
        bid = 0

        def nid():
            nonlocal bid
            bid += 1
            return f"b_{bid}"

        # Page 1 blocks: header_title, header_subtitle, ads, qr
        if page.header_title:
            p1.append({"id": nid(), "type": "text", "props": {
                "content": page.header_title, "font_size": 72,
                "align": "center", "weight": "700", "color": "",
            }})
        if page.header_subtitle:
            p1.append({"id": nid(), "type": "text", "props": {
                "content": page.header_subtitle, "font_size": 28,
                "align": "center", "weight": "", "color": "muted",
            }})
        if page.qr_image:
            p1.append({"id": nid(), "type": "qr_code", "props": {
                "image_path": page.qr_image.name,
                "label": (page.qr or {}).get("label", "扫码关注 · 领取样品"),
                "size": 440,
            }})
        elif page.qr and page.qr.get("url"):
            p1.append({"id": nid(), "type": "qr_code", "props": {
                "image_url": page.qr["url"],
                "label": page.qr.get("label", "扫码关注 · 领取样品"),
                "size": 440,
            }})
        if page.ads:
            for i, ad in enumerate(page.ads):
                ad_type = ad.get("type", "image")
                p1.append({"id": nid(), "type": ad_type, "props": {
                    "url": ad.get("url", ""),
                    "autoplay": True,
                    "loop": True,
                    "fullscreen": True,
                }})

        page.page1_blocks = p1

        # Page 2 blocks: input_config (redeem), footer_tip
        ic = page.input_config or {}
        redeem_block = {
            "id": nid(),
            "type": "redeem",
            "props": {
                "claim_btn_text": ic.get("submit_text", "立即领取礼品"),
                "show_code_input": False,
                "code_length": 6,
                "show_product_grid": True,
            },
        }
        p2.append(redeem_block)
        if page.footer_tip:
            p2.append({"id": nid(), "type": "text", "props": {
                "content": page.footer_tip, "font_size": 20,
                "align": "center", "weight": "", "color": "muted",
            }})

        page.page2_blocks = p2
        page.page1_background = {"type": "color", "value": "#0a0a0a"}
        page.page2_background = {"type": "color", "value": "#0a0a0a"}
        page.save(update_fields=[
            "page1_blocks", "page2_blocks",
            "page1_background", "page2_background",
        ])


def _reverse_convert(apps, schema_editor):
    """No-op: we keep old fields intact, so reversing is fine."""
    pass


class Migration(migrations.Migration):
    dependencies = [
        ("pages", "0009_ledpage_blocks_background"),
    ]

    operations = [
        migrations.RunPython(_convert_old_to_blocks, _reverse_convert),
    ]
