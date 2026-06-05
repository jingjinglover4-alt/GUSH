"""
页面装修 - 视图
所有接口都挂在项目维度下：/api/projects/{project_id}/theme/、h5/、page-versions/

设计：
- GET/PATCH theme + h5（单实例，不用 list/create）
- POST h5/publish/ → 快照写入 PageVersion，status → published
- GET page-versions/ → 项目下所有快照（含 theme 和 h5）
"""
import json

from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
from django.db import transaction
from django.http import JsonResponse
from django.shortcuts import render
from django.shortcuts import get_object_or_404, render
from django.utils import timezone
from django.views.decorators.cache import never_cache
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status, viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.decorators import authentication_classes
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response

from django.conf import settings

from apps.devices.models import Channel, DispenseLog, Machine
from apps.projects.models import Project

from .models import (
    DevicePageOverride, Experiment, ExperimentVariant,
    H5Page, LedPage, PageTheme, PageVersion, PageVisitLog,
)
from .serializers import (
    DevicePageOverrideSerializer,
    ExperimentSerializer, ExperimentVariantSerializer,
    H5PageSerializer,
    LedPageSerializer,
    PageThemeSerializer,
    PageVersionSerializer,
    PublishH5Serializer,
    PublishLedSerializer,
)


def _get_project(project_id):
    return get_object_or_404(Project, id=project_id)


@api_view(["GET", "PATCH"])
@permission_classes([IsAuthenticated])
def project_theme(request, project_id):
    """
    GET  /api/projects/{id}/theme/   → 拿主题
    PATCH /api/projects/{id}/theme/  → 局部更新（支持文件上传 multipart）
    """
    project = _get_project(project_id)
    theme, _ = PageTheme.objects.get_or_create(project=project)

    if request.method == "GET":
        ser = PageThemeSerializer(theme, context={"request": request})
        return Response(ser.data)

    # PATCH
    ser = PageThemeSerializer(theme, data=request.data, partial=True, context={"request": request})
    ser.is_valid(raise_exception=True)
    ser.save()
    return Response(ser.data)


@api_view(["GET", "PATCH"])
@permission_classes([IsAuthenticated])
def project_h5(request, project_id):
    """
    GET  /api/projects/{id}/h5/   → 拿 H5 落地页
    PATCH /api/projects/{id}/h5/  → 局部更新（保持 draft 状态，需点 publish 才生效到线上）
    """
    project = _get_project(project_id)
    h5_page, _ = H5Page.objects.get_or_create(project=project)

    if request.method == "GET":
        ser = H5PageSerializer(h5_page, context={"request": request})
        return Response(ser.data)

    # PATCH — 编辑后回到 draft 状态
    ser = H5PageSerializer(h5_page, data=request.data, partial=True, context={"request": request})
    ser.is_valid(raise_exception=True)
    # 编辑就标 draft（即使已发布，再编辑也回到 draft，提示用户需重新发布）
    h5_page = ser.save(status=H5Page.Status.DRAFT)
    return Response(H5PageSerializer(h5_page, context={"request": request}).data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def publish_h5(request, project_id):
    """
    POST /api/projects/{id}/h5/publish/
    把当前 draft 快照写入 PageVersion，version + 1，status → published
    同时也把主题一起 snapshot（H5 离开主题没法独立展现）
    """
    project = _get_project(project_id)
    ser = PublishH5Serializer(data=request.data)
    ser.is_valid(raise_exception=True)
    note = ser.validated_data.get("note", "")

    h5_page, _ = H5Page.objects.get_or_create(project=project)
    theme, _ = PageTheme.objects.get_or_create(project=project)

    new_version = h5_page.current_version + 1

    # 组装 snapshot（不含文件二进制，只存 URL 路径）
    snapshot = {
        "h5": {
            "header_title": h5_page.header_title,
            "header_subtitle": h5_page.header_subtitle,
            "blocks": h5_page.blocks,
            "form_fields": h5_page.form_fields,
            "privacy": h5_page.privacy,
            "submit_button": h5_page.submit_button,
            "rate_limit": h5_page.rate_limit,
            "success_view": h5_page.success_view,
        },
        "theme": {
            "brand_color": theme.brand_color,
            "accent_color": theme.accent_color,
            "text_color": theme.text_color,
            "logo": theme.logo.name if theme.logo else "",
            "favicon": theme.favicon.name if theme.favicon else "",
            "background_type": theme.background_type,
            "background_value": theme.background_value,
            "background_image": theme.background_image.name if theme.background_image else "",
            "font_family": theme.font_family,
            "shared_assets": theme.shared_assets,
        },
    }

    with transaction.atomic():
        version = PageVersion.objects.create(
            page_type=PageVersion.PageType.H5,
            page_id=h5_page.id,
            project=project,
            version=new_version,
            snapshot=snapshot,
            note=note,
            published_by=request.user if request.user.is_authenticated else None,
        )
        h5_page.current_version = new_version
        h5_page.status = H5Page.Status.PUBLISHED
        h5_page.published_at = timezone.now()
        h5_page.save(update_fields=["current_version", "status", "published_at"])

    return Response({
        "version": version.version,
        "published_at": version.published_at,
        "page": H5PageSerializer(h5_page, context={"request": request}).data,
    }, status=status.HTTP_201_CREATED)


@api_view(["GET", "PATCH"])
@permission_classes([IsAuthenticated])
def project_led(request, project_id):
    """
    GET  /api/projects/{id}/led/   → 拿 LED 大屏页
    PATCH /api/projects/{id}/led/  → 局部更新（支持 multipart 上传 qr_image）
    """
    project = _get_project(project_id)
    led_page, _ = LedPage.objects.get_or_create(project=project)

    if request.method == "GET":
        ser = LedPageSerializer(led_page, context={"request": request})
        return Response(ser.data)

    ser = LedPageSerializer(led_page, data=request.data, partial=True, context={"request": request})
    ser.is_valid(raise_exception=True)
    led_page = ser.save(status=LedPage.Status.DRAFT)
    return Response(LedPageSerializer(led_page, context={"request": request}).data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def publish_led(request, project_id):
    """
    POST /api/projects/{id}/led/publish/
    """
    project = _get_project(project_id)
    ser = PublishLedSerializer(data=request.data)
    ser.is_valid(raise_exception=True)
    note = ser.validated_data.get("note", "")

    led_page, _ = LedPage.objects.get_or_create(project=project)
    theme, _ = PageTheme.objects.get_or_create(project=project)

    new_version = led_page.current_version + 1
    snapshot = {
        "led": {
            "header_title": led_page.header_title,
            "header_subtitle": led_page.header_subtitle,
            "ads": led_page.ads,
            "qr_image": led_page.qr_image.name if led_page.qr_image else "",
            "qr": led_page.qr,
            "input_config": led_page.input_config,
            "footer_tip": led_page.footer_tip,
            "page1_blocks": led_page.page1_blocks,
            "page2_blocks": led_page.page2_blocks,
            "page1_background": led_page.page1_background,
            "page2_background": led_page.page2_background,
        },
        "theme": {
            "brand_color": theme.brand_color,
            "accent_color": theme.accent_color,
            "text_color": theme.text_color,
        },
    }

    with transaction.atomic():
        version = PageVersion.objects.create(
            page_type=PageVersion.PageType.LED,
            page_id=led_page.id,
            project=project,
            version=new_version,
            snapshot=snapshot,
            note=note,
            published_by=request.user if request.user.is_authenticated else None,
        )
        led_page.current_version = new_version
        led_page.status = LedPage.Status.PUBLISHED
        led_page.published_at = timezone.now()
        led_page.save(update_fields=["current_version", "status", "published_at"])

    return Response({
        "version": version.version,
        "published_at": version.published_at,
        "page": LedPageSerializer(led_page, context={"request": request}).data,
    }, status=status.HTTP_201_CREATED)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def restore_page_version(request, project_id, version_id):
    """
    POST /api/projects/{id}/page-versions/{version_id}/restore/
    body: {"include_theme": true, "publish": false}

    把 PageVersion 的快照回填到 H5Page / LedPage (+可选 PageTheme)。
    默认 publish=False → 只恢复到 draft，让用户在编辑器里二次确认后再点发布。
    publish=True → 直接落库 + 翻 published + 写一条新的版本号，note="回滚自 vN"。
    """
    project = _get_project(project_id)
    version = get_object_or_404(PageVersion, pk=version_id, project=project)
    include_theme = bool(request.data.get("include_theme", True))
    do_publish = bool(request.data.get("publish", False))
    snapshot = version.snapshot or {}

    restored = {}
    with transaction.atomic():
        # 1) 恢复 theme（若 snapshot 内含 theme 段且勾选了 include_theme）
        if include_theme and snapshot.get("theme"):
            theme, _ = PageTheme.objects.get_or_create(project=project)
            tsnap = snapshot["theme"]
            for f in ("brand_color", "accent_color", "text_color",
                      "background_type", "background_value",
                      "font_family", "shared_assets"):
                if f in tsnap:
                    setattr(theme, f, tsnap[f])
            theme.save()
            restored["theme"] = True

        # 2) 恢复 h5 / led 本体
        if version.page_type == PageVersion.PageType.H5 and snapshot.get("h5"):
            page, _ = H5Page.objects.get_or_create(project=project)
            hsnap = snapshot["h5"]
            for f in ("header_title", "header_subtitle", "blocks", "form_fields",
                      "privacy", "submit_button", "rate_limit", "success_view"):
                if f in hsnap:
                    setattr(page, f, hsnap[f])
            page.status = H5Page.Status.DRAFT
            page.save()
            restored["h5"] = True
            target_page, target_type = page, PageVersion.PageType.H5
        elif version.page_type == PageVersion.PageType.LED and snapshot.get("led"):
            page, _ = LedPage.objects.get_or_create(project=project)
            lsnap = snapshot["led"]
            for f in ("header_title", "header_subtitle", "ads", "qr",
                      "input_config", "footer_tip",
                      "page1_blocks", "page2_blocks",
                      "page1_background", "page2_background"):
                if f in lsnap:
                    setattr(page, f, lsnap[f])
            page.status = LedPage.Status.DRAFT
            page.save()
            restored["led"] = True
            target_page, target_type = page, PageVersion.PageType.LED
        else:
            return Response(
                {"detail": f"该版本(page_type={version.page_type})缺少有效快照，无法回滚"},
                status=400,
            )

        # 3) 若用户要求一次性发布：再写一条新的 PageVersion，version+1
        if do_publish:
            new_version = target_page.current_version + 1
            theme_obj, _ = PageTheme.objects.get_or_create(project=project)
            new_snapshot = {
                "theme": {
                    "brand_color": theme_obj.brand_color,
                    "accent_color": theme_obj.accent_color,
                    "text_color": theme_obj.text_color,
                    "background_type": theme_obj.background_type,
                    "background_value": theme_obj.background_value,
                    "font_family": theme_obj.font_family,
                    "shared_assets": theme_obj.shared_assets,
                    "logo": theme_obj.logo.name if theme_obj.logo else "",
                    "favicon": theme_obj.favicon.name if theme_obj.favicon else "",
                    "background_image": theme_obj.background_image.name if theme_obj.background_image else "",
                },
            }
            if target_type == PageVersion.PageType.H5:
                new_snapshot["h5"] = {
                    "header_title": target_page.header_title,
                    "header_subtitle": target_page.header_subtitle,
                    "blocks": target_page.blocks,
                    "form_fields": target_page.form_fields,
                    "privacy": target_page.privacy,
                    "submit_button": target_page.submit_button,
                    "rate_limit": target_page.rate_limit,
                    "success_view": target_page.success_view,
                }
                target_page.status = H5Page.Status.PUBLISHED
            else:
                new_snapshot["led"] = {
                    "header_title": target_page.header_title,
                    "header_subtitle": target_page.header_subtitle,
                    "ads": target_page.ads,
                    "qr": target_page.qr,
                    "input_config": target_page.input_config,
                    "footer_tip": target_page.footer_tip,
                    "page1_blocks": target_page.page1_blocks,
                    "page2_blocks": target_page.page2_blocks,
                    "page1_background": target_page.page1_background,
                    "page2_background": target_page.page2_background,
                }
                target_page.status = LedPage.Status.PUBLISHED

            PageVersion.objects.create(
                page_type=target_type,
                page_id=target_page.id,
                project=project,
                version=new_version,
                snapshot=new_snapshot,
                note=f"回滚自 v{version.version}",
                published_by=request.user if request.user.is_authenticated else None,
            )
            target_page.current_version = new_version
            target_page.published_at = timezone.now()
            target_page.save(update_fields=["current_version", "status", "published_at"])
            restored["published_version"] = new_version

    return Response({
        "restored": restored,
        "from_version": version.version,
        "from_page_type": version.page_type,
        "mode": "publish" if do_publish else "draft",
    })


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def project_page_versions(request, project_id):
    """
    GET /api/projects/{id}/page-versions/?page_type=h5
    列出该项目下所有发布快照
    """
    project = _get_project(project_id)
    qs = PageVersion.objects.filter(project=project)
    page_type = request.query_params.get("page_type")
    if page_type:
        qs = qs.filter(page_type=page_type)
    qs = qs.order_by("-version")
    ser = PageVersionSerializer(qs, many=True)
    return Response(ser.data)


# ============================================================
# 设备级覆盖（Phase 1.7）
# ============================================================

@api_view(["GET", "PATCH", "DELETE"])
@permission_classes([IsAuthenticated])
def device_page_override(request, machine_id):
    """
    GET    /api/devices/{machine_id}/page-override/   → 拿覆盖配置（不存在时返回空 200）
    PATCH  /api/devices/{machine_id}/page-override/   → 局部更新（自动创建）
    DELETE /api/devices/{machine_id}/page-override/   → 清除该设备的覆盖
    """
    from apps.devices.models import Machine
    machine = get_object_or_404(Machine, machine_id=machine_id)

    # 该设备绑定的项目列表（供前端选 active_project）
    bound_projects = list(
        Project.objects.filter(machines=machine)
        .order_by("-created_at")
        .values("id", "name", "status")
    )

    if request.method == "GET":
        ovr = getattr(machine, "page_override", None)
        if not ovr:
            return Response({
                "machine": machine.id,
                "machine_id": machine.machine_id,
                "theme_override": {},
                "h5_override": {},
                "led_override": {},
                "led_qr_image_url": None,
                "active_project": None,
                "active_project_name": "",
                "enabled": False,
                "note": "",
                "exists": False,
                "bound_projects": bound_projects,
            })
        ser = DevicePageOverrideSerializer(ovr, context={"request": request})
        data = ser.data
        data["exists"] = True
        data["bound_projects"] = bound_projects
        return Response(data)

    if request.method == "DELETE":
        ovr = getattr(machine, "page_override", None)
        if ovr:
            ovr.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    # PATCH
    ovr, _ = DevicePageOverride.objects.get_or_create(machine=machine)
    ser = DevicePageOverrideSerializer(ovr, data=request.data, partial=True, context={"request": request})
    ser.is_valid(raise_exception=True)
    ser.save()
    return Response(ser.data)


# ============================================================
# 公开渲染：LED 大屏页（不需要登录）
# ============================================================

@never_cache
def subdomain_root(request):
    """
    子域名根路径：{subdomain}.gush.cdgushai.com/ → 直接渲染该设备的 LED 页
    本地开发不会命中（中间件在 localhost 直接放行）
    """
    from django.http import HttpResponseNotFound
    machine = getattr(request, "device_machine", None)
    if not machine:
        return HttpResponseNotFound("未识别的设备子域名")
    return public_led_page(request, machine.machine_id)


@never_cache
def public_led_page(request, machine_id):
    """
    LED 大屏页：派样机 Qt WebView 加载
    URL: /led/{machine_id}/
    优先用子域名解析到的 device_machine（Phase 1.7），否则用 URL 参数
    可选 ?project_id=X 编辑器预览用（强制指定项目）
    """
    from .resolver import resolve_led, resolve_theme

    machine = getattr(request, "device_machine", None)
    if not machine or machine.machine_id != machine_id:
        machine = get_object_or_404(Machine, machine_id=machine_id)

    project = None
    preview_project_id = request.GET.get("project_id")
    if preview_project_id:
        project = Project.objects.filter(id=preview_project_id).first()
    else:
        # Phase 4.4：若设备覆盖里显式指定了 active_project，优先用
        ovr = getattr(machine, "page_override", None)
        if ovr and ovr.enabled and ovr.active_project_id:
            project = ovr.active_project
        if not project:
            project = (
                Project.objects.filter(machines=machine, status=Project.Status.RUNNING)
                .order_by("-created_at").first()
            )
        if not project:
            project = Project.objects.filter(machines=machine).order_by("-created_at").first()

    led = None
    theme = None
    products_json = "[]"
    if project:
        led = resolve_led(project, machine=machine, request=request)
        theme = resolve_theme(project, machine=machine, request=request)
        # 取项目关联商品前 6 个（含图片 URL）
        qs = project.products.all()[:6]
        prods = []
        for p in qs:
            img_url = None
            if p.image:
                img_url = request.build_absolute_uri(p.image.url) if request else p.image.url
            prods.append({
                "id": p.id,
                "name": p.name,
                "sku": p.sku,
                "image_url": img_url,
            })
        products_json = json.dumps(prods, ensure_ascii=False)

    return render(request, "device_led.html", {
        "machine": machine,
        "project": project,
        "led_page": led,
        "theme": theme,
        "ads_json": json.dumps(led["ads"] if led else [], ensure_ascii=False),
        "qr_json": json.dumps(led["qr"] if led else {}, ensure_ascii=False),
        "input_json": json.dumps(led["input_config"] if led else {}, ensure_ascii=False),
        "products_json": products_json,
        "page1_blocks_json": json.dumps(led.get("page1_blocks", []), ensure_ascii=False),
        "page2_blocks_json": json.dumps(led.get("page2_blocks", []), ensure_ascii=False),
        "page1_background_json": json.dumps(led.get("page1_background", {}), ensure_ascii=False),
        "page2_background_json": json.dumps(led.get("page2_background", {}), ensure_ascii=False),
        "now": timezone.now(),
    })


# ---------- LED 触摸屏直接出货 ----------
@csrf_exempt
@never_cache
def led_dispense(request):
    """
    POST /api/public/led-dispense/
    LED 触摸屏直接出货（无需兑换码）
    Body: {"machine_id": "xxx", "product_id": 123}

    流程：
    1. 查 machine 是否存在、在线
    2. 找机器上该商品有库存的货道
    3. 通过 WebSocket group_send 下发 motor_run
    4. 记录 DispenseLog (result=BUSY)
    5. 返回结果
    """
    if request.method != "POST":
        return JsonResponse({"detail": "仅支持 POST"}, status=405)

    try:
        body = json.loads(request.body)
    except json.JSONDecodeError:
        return JsonResponse({"detail": "无效的 JSON"}, status=400)

    machine_id = body.get("machine_id", "").strip()
    product_id = body.get("product_id")

    if not machine_id or not product_id:
        return JsonResponse({"detail": "缺少 machine_id 或 product_id"}, status=400)

    machine = Machine.objects.filter(machine_id=machine_id).first()
    if not machine:
        return JsonResponse({"detail": "设备不存在"}, status=404)

    if machine.status != Machine.Status.ONLINE:
        return JsonResponse({"detail": "设备当前离线"}, status=400)

    # 找机器上该商品有库存的货道
    channel = (
        Channel.objects
        .filter(machine=machine, product_id=product_id, current_stock__gt=0)
        .exclude(status=Channel.Status.FAULT)
        .order_by("?")  # 随机选一个
        .first()
    )
    if not channel:
        return JsonResponse({"detail": "该礼品已领完"}, status=400)

    # 下发 motor_run
    motor_id = (ord(channel.channel_code[0]) - ord("A")) * 10 + int(channel.channel_code[1]) + 1
    payload = {"cmd": "motor_run", "id": motor_id, "num": 1}

    layer = get_channel_layer()
    if layer is None:
        return JsonResponse({"detail": "服务异常，稍后再试"}, status=500)

    try:
        async_to_sync(layer.group_send)(
            f"device_{machine_id}",
            {"type": "device.command", "payload": payload},
        )
    except Exception as e:
        return JsonResponse({"detail": f"下发失败: {e}"}, status=500)

    # 记录出货日志
    DispenseLog.objects.create(
        machine_id=machine.id,
        channel=channel,
        channel_code=channel.channel_code,
        result=DispenseLog.Result.BUSY,
        detail="LED 触摸屏直接出货",
    )

    return JsonResponse({
        "detail": "出货指令已下发",
        "channel": channel.channel_code,
        "product": channel.product.name if channel.product else "",
    })


# ============================================================
# Phase 2.3 - A/B 实验
# ============================================================

def _snapshot_h5(page: H5Page) -> dict:
    return {
        "header_title": page.header_title,
        "header_subtitle": page.header_subtitle,
        "blocks": page.blocks,
        "form_fields": page.form_fields,
        "privacy": page.privacy,
        "submit_button": page.submit_button,
        "rate_limit": page.rate_limit,
        "success_view": page.success_view,
    }


@api_view(["GET", "POST", "DELETE"])
@permission_classes([IsAuthenticated])
def project_experiment(request, project_id):
    """
    GET    /api/projects/{id}/experiment/   → 拿当前实验（含两变体），不存在时 200 + {exists: false}
    POST   /api/projects/{id}/experiment/   → 创建实验：用当前 H5 作为 A，复制一份作为 B（用户后续可编辑 B）
            body: {name, hypothesis, traffic_split_b}
    DELETE /api/projects/{id}/experiment/   → 删除实验（仅 draft / stopped / concluded 可删）
    """
    project = _get_project(project_id)
    exp = Experiment.objects.filter(project=project).prefetch_related("variants").first()

    if request.method == "GET":
        if not exp:
            return Response({"exists": False})
        data = ExperimentSerializer(exp, context={"request": request}).data
        data["exists"] = True
        return Response(data)

    if request.method == "DELETE":
        if not exp:
            return Response(status=status.HTTP_204_NO_CONTENT)
        if exp.status == Experiment.Status.RUNNING:
            return Response({"detail": "实验进行中，请先停止"}, status=400)
        exp.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    # POST 创建
    if exp:
        return Response({"detail": "该项目已存在实验，请先删除或结束"}, status=409)

    name = request.data.get("name") or "A/B 实验"
    hypothesis = request.data.get("hypothesis") or ""

    # Phase 4.3：支持 2-4 变体
    variant_count = int(request.data.get("variant_count") or 2)
    variant_count = max(2, min(4, variant_count))

    # 流量分配：用户传 traffic_shares=[..] 或者后端均分
    raw_shares = request.data.get("traffic_shares") or []
    if not isinstance(raw_shares, list) or len(raw_shares) != variant_count:
        # 均分
        per = 100 // variant_count
        shares = [per] * variant_count
        shares[-1] += 100 - per * variant_count
    else:
        try:
            shares = [max(0, min(100, int(x))) for x in raw_shares]
        except (TypeError, ValueError):
            shares = [100 // variant_count] * variant_count
            shares[-1] += 100 - (100 // variant_count) * variant_count
        if sum(shares) != 100:
            return Response({"detail": f"流量分配之和必须等于 100（当前 = {sum(shares)}）"}, status=400)

    page, _ = H5Page.objects.get_or_create(project=project)
    base_snapshot = _snapshot_h5(page)

    VARIANT_KEYS = ["A", "B", "C", "D"]
    DEFAULT_NAMES = ["对照组（当前线上）", "新方案 B", "新方案 C", "新方案 D"]

    with transaction.atomic():
        exp = Experiment.objects.create(
            project=project,
            name=name[:128],
            hypothesis=hypothesis,
            traffic_split_b=shares[1] if len(shares) > 1 else 50,  # 留向后兼容
        )
        for i in range(variant_count):
            ExperimentVariant.objects.create(
                experiment=exp,
                key=VARIANT_KEYS[i],
                name=DEFAULT_NAMES[i],
                traffic_share=shares[i],
                h5_snapshot=base_snapshot,
            )

    return Response(
        ExperimentSerializer(exp, context={"request": request}).data,
        status=status.HTTP_201_CREATED,
    )


@api_view(["PATCH"])
@permission_classes([IsAuthenticated])
def experiment_variant(request, project_id, variant_id):
    """
    PATCH /api/projects/{id}/experiment/variants/{vid}/
    body: {name, note, h5_snapshot} → 修改变体内容（实验运行中可改 B，A 通常不动）
    """
    project = _get_project(project_id)
    variant = get_object_or_404(
        ExperimentVariant, pk=variant_id, experiment__project=project,
    )
    for f in ("name", "note", "h5_snapshot"):
        if f in request.data:
            setattr(variant, f, request.data[f])
    variant.save()
    return Response(ExperimentVariantSerializer(variant).data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def experiment_transition(request, project_id):
    """
    POST /api/projects/{id}/experiment/transition/
    body: {"to": "running"|"stopped"|"concluded", "winner": "A"|"B" (concluded 时必填), "note": ""}
    - draft → running
    - running ⇄ stopped
    - running/stopped → concluded (必须指定 winner，并把 winner 的 h5_snapshot 推回 H5Page 作为草稿)
    """
    project = _get_project(project_id)
    exp = get_object_or_404(Experiment, project=project)
    target = request.data.get("to")
    if target not in Experiment.Status.values:
        return Response({"detail": "目标状态非法"}, status=400)

    allowed = {
        Experiment.Status.DRAFT: {Experiment.Status.RUNNING},
        Experiment.Status.RUNNING: {Experiment.Status.STOPPED, Experiment.Status.CONCLUDED},
        Experiment.Status.STOPPED: {Experiment.Status.RUNNING, Experiment.Status.CONCLUDED},
        Experiment.Status.CONCLUDED: set(),
    }
    if target not in allowed.get(exp.status, set()):
        return Response({"detail": f"不允许从「{exp.get_status_display()}」切换到「{Experiment.Status(target).label}」"},
                         status=400)

    with transaction.atomic():
        if target == Experiment.Status.RUNNING:
            if not exp.started_at:
                exp.started_at = timezone.now()
            exp.status = Experiment.Status.RUNNING
            exp.save()
        elif target == Experiment.Status.STOPPED:
            exp.status = Experiment.Status.STOPPED
            exp.save()
        elif target == Experiment.Status.CONCLUDED:
            winner = (request.data.get("winner") or "").upper()
            if winner not in {v.key for v in exp.variants.all()}:
                return Response({"detail": f"结案时必须指定一个有效变体 key"}, status=400)
            note = (request.data.get("note") or "")[:255]
            variant = exp.variants.filter(key=winner).first()
            if not variant:
                return Response({"detail": f"找不到变体 {winner}"}, status=400)
            # 把 winner 内容推回 H5Page（draft 状态，让用户最后审核后发布）
            page, _ = H5Page.objects.get_or_create(project=project)
            for k, v in (variant.h5_snapshot or {}).items():
                if k in {"header_title", "header_subtitle", "blocks", "form_fields",
                         "privacy", "submit_button", "rate_limit", "success_view"}:
                    setattr(page, k, v)
            page.status = H5Page.Status.DRAFT
            page.save()
            exp.status = Experiment.Status.CONCLUDED
            exp.stopped_at = timezone.now()
            exp.winner = winner
            exp.conclusion_note = note
            exp.save()

    return Response(ExperimentSerializer(exp, context={"request": request}).data)


def _compute_experiment_stats(project, exp):
    """纯函数：把实验统计算出来，供 API + CSV 共用，不依赖 request"""
    from django.db.models import Count
    from apps.projects.models import RedeemCode

    # 访问/UV 按变体
    visits = (
        PageVisitLog.objects.filter(project=project, experiment=exp)
        .exclude(variant_key="")
        .order_by()
        .values("variant_key")
        .annotate(visits=Count("id"))
    )
    visits_by_key = {r["variant_key"]: r["visits"] for r in visits}

    uvs = (
        PageVisitLog.objects.filter(project=project, experiment=exp)
        .exclude(device_fp="").exclude(variant_key="")
        .order_by()
        .values("variant_key", "device_fp")
        .distinct()
    )
    uv_by_key = {}
    for r in uvs:
        uv_by_key[r["variant_key"]] = uv_by_key.get(r["variant_key"], 0) + 1

    # 领码：visit.experiment + variant_key 通过 claim_visit FK 串
    claim_qs = (
        RedeemCode.objects.filter(project=project, claim_visit__experiment=exp)
        .exclude(claim_visit__variant_key="")
        .order_by()
        .values("claim_visit__variant_key")
        .annotate(claims=Count("id"))
    )
    claims_by_key = {r["claim_visit__variant_key"]: r["claims"] for r in claim_qs}

    # 核销
    used_qs = (
        RedeemCode.objects.filter(
            project=project, status=RedeemCode.Status.USED,
            claim_visit__experiment=exp,
        )
        .exclude(claim_visit__variant_key="")
        .order_by()
        .values("claim_visit__variant_key")
        .annotate(used=Count("id"))
    )
    used_by_key = {r["claim_visit__variant_key"]: r["used"] for r in used_qs}

    def rate(a, b):
        return round(a / b * 100, 2) if b > 0 else 0

    variants_data = []
    for v in exp.variants.all():
        k = v.key
        vis = visits_by_key.get(k, 0)
        clm = claims_by_key.get(k, 0)
        usd = used_by_key.get(k, 0)
        variants_data.append({
            "key": k,
            "name": v.name,
            "visits": vis,
            "uv": uv_by_key.get(k, 0),
            "claims": clm,
            "redeems": usd,
            "claim_rate": rate(clm, vis),
            "redeem_rate": rate(usd, vis),
        })

    # 显著性：以 A 为对照组，每个其他变体做 z-test
    significance = None
    if len(variants_data) >= 2:
        import math
        a = next((v for v in variants_data if v["key"] == "A"), variants_data[0])

        def proportion_z(c_a, n_a, c_b, n_b):
            if n_a == 0 or n_b == 0:
                return None
            p_pool = (c_a + c_b) / (n_a + n_b)
            se = math.sqrt(p_pool * (1 - p_pool) * (1 / n_a + 1 / n_b))
            if se == 0:
                return None
            return ((c_b / n_b) - (c_a / n_a)) / se

        comparisons = []
        leader = a["key"]
        leader_rate = a["claim_rate"]
        for v in variants_data:
            if v["key"] == a["key"]:
                continue
            z = proportion_z(a["claims"], a["visits"], v["claims"], v["visits"])
            comparisons.append({
                "variant": v["key"],
                "vs": a["key"],
                "z_score": round(z, 3) if z is not None else None,
                "confident": (z is not None and abs(z) >= 1.96),
                "leads": (z is not None and z > 0),
            })
            if v["claim_rate"] > leader_rate:
                leader = v["key"]
                leader_rate = v["claim_rate"]

        significance = {
            "control": a["key"],
            "leader": leader,
            "comparisons": comparisons,
            "note": "样本量较少时仅供参考，建议每个变体 ≥ 200 次访问后再下结论。",
        }

    return {
        "experiment_id": exp.id,
        "status": exp.status,
        "traffic_split_b": exp.traffic_split_b,
        "winner": exp.winner,
        "variants": variants_data,
        "significance": significance,
    }


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def experiment_stats(request, project_id):
    """GET /api/projects/{id}/experiment/stats/"""
    project = _get_project(project_id)
    exp = Experiment.objects.filter(project=project).first()
    if not exp:
        return Response({"detail": "未配置实验"}, status=404)
    return Response(_compute_experiment_stats(project, exp))


# ============================================================
# Phase 2.2 - 访问上报 + 漏斗看板
# ============================================================

def _client_ip(request):
    xff = request.META.get("HTTP_X_FORWARDED_FOR", "")
    if xff:
        return xff.split(",")[0].strip()
    return request.META.get("REMOTE_ADDR") or None


@csrf_exempt
@api_view(["POST"])
@authentication_classes([])  # 公开
@permission_classes([AllowAny])
def public_visit_report(request):
    """
    POST /api/public/visit/
    body: {
      "page_type": "h5"|"led",
      "project_id": int (h5 必填),
      "machine_id": str  (LED 必填，H5 可选),
      "device_fp": str   (前端 localStorage 持久化 UUID),
      "referrer":  str,
      "utm_source": str,
      "utm_campaign": str
    }
    返回 {"visit_id": int}
    """
    body = request.data or {}
    page_type = (body.get("page_type") or "h5").lower()
    if page_type not in ("h5", "led"):
        return Response({"detail": "page_type 非法"}, status=400)

    project = None
    project_id = body.get("project_id")
    if project_id:
        project = Project.objects.filter(id=project_id).first()

    machine = getattr(request, "device_machine", None)
    if not machine:
        machine_id = (body.get("machine_id") or "").strip()
        if machine_id:
            machine = Machine.objects.filter(machine_id=machine_id).first()

    # LED 页若没绑 project，尝试从 machine 推断
    if not project and machine:
        project = machine.projects.filter(status=Project.Status.RUNNING).order_by("-created_at").first()

    # Phase 2.3：可选实验串联
    from .models import Experiment
    exp_obj = None
    exp_id = body.get("experiment_id")
    if exp_id:
        exp_obj = Experiment.objects.filter(id=exp_id, project=project).first()
    variant_key = (body.get("variant_key") or "")[:4]

    ua = (request.META.get("HTTP_USER_AGENT") or "")[:512]
    visit = PageVisitLog.objects.create(
        page_type=page_type,
        project=project,
        machine=machine,
        device_fp=(body.get("device_fp") or "")[:64],
        user_agent=ua,
        ip=_client_ip(request),
        referrer=(body.get("referrer") or "")[:512],
        utm_source=(body.get("utm_source") or "")[:64],
        utm_campaign=(body.get("utm_campaign") or "")[:64],
        experiment=exp_obj,
        variant_key=variant_key if exp_obj else "",
    )

    # 频控提示：当天该 fp 在该项目是否已领过
    result = {"visit_id": visit.id, "already_claimed": False}
    if project and visit.device_fp:
        from apps.projects.models import RedeemCode
        today = timezone.localtime().date()
        existing = (
            RedeemCode.objects
            .filter(project=project, created_at__date=today)
            .filter(claim_visit__device_fp=visit.device_fp)
            .order_by("-created_at")
            .first()
        )
        if existing:
            result["already_claimed"] = True
            result["code"] = existing.code
            result["expires_at"] = existing.expires_at.isoformat() if existing.expires_at else None
    return Response(result)




@never_cache
@api_view(["GET"])
@permission_classes([AllowAny])
def public_privacy_policy(request, page_id):
    """
    GET /api/public/privacy/<page_id>/
    返回指定 H5Page 的隐私协议正文
    """
    h5_page = H5Page.objects.filter(id=page_id).first()
    if not h5_page:
        return Response({"detail": "页面不存在"}, status=404)

    return Response({
        "page_id": h5_page.id,
        "project_id": h5_page.project_id,
        "project_name": h5_page.project.name if h5_page.project else "",
        "policy_content": h5_page.privacy_policy or "",
    })

def privacy_policy_page(request, page_id):
    """
    GET /p/privacy/<page_id>/
    渲染隐私政策独立页面
    """
    return render(request, 'privacy_policy.html', {
        'page_id': page_id,
        'project_name': '健乐适',
    })




@api_view(["GET"])
@permission_classes([IsAuthenticated])
def project_funnel(request, project_id):
    """
    GET /api/projects/{id}/stats/funnel/?days=14
    返回项目漏斗：访问 → 领码 → 核销，按天聚合
    """
    from datetime import timedelta
    from django.db.models import Count
    from django.db.models.functions import TruncDate
    from apps.projects.models import RedeemCode

    project = _get_project(project_id)
    days = int(request.query_params.get("days", 14))
    days = max(1, min(days, 90))
    since = timezone.now() - timedelta(days=days)

    # === 访问按天 + page_type ===
    visit_qs = (
        PageVisitLog.objects.filter(project=project, visited_at__gte=since)
        .annotate(day=TruncDate("visited_at"))
        .values("day", "page_type")
        .annotate(c=Count("id"))
    )
    visit_by_day = {}
    for row in visit_qs:
        d = row["day"].isoformat()
        slot = visit_by_day.setdefault(d, {"h5_visits": 0, "led_visits": 0})
        if row["page_type"] == "h5":
            slot["h5_visits"] = row["c"]
        elif row["page_type"] == "led":
            slot["led_visits"] = row["c"]

    # UV by page_type（去重 device_fp）
    # 注意：必须 order_by() 清掉 Meta.ordering，否则 distinct 会把 visited_at 拉进 SELECT 列破坏去重
    uv_qs = (
        PageVisitLog.objects.filter(project=project, visited_at__gte=since)
        .exclude(device_fp="")
        .order_by()
        .values("page_type", "device_fp")
        .distinct()
    )
    uv_h5 = sum(1 for r in uv_qs if r["page_type"] == "h5")
    uv_led = sum(1 for r in uv_qs if r["page_type"] == "led")

    # === 领码按天 ===
    claim_qs = (
        RedeemCode.objects.filter(project=project, created_at__gte=since)
        .annotate(day=TruncDate("created_at"))
        .values("day")
        .annotate(c=Count("id"))
    )
    claim_by_day = {row["day"].isoformat(): row["c"] for row in claim_qs}

    # === 核销按天（status=used） ===
    used_qs = (
        RedeemCode.objects.filter(
            project=project, status=RedeemCode.Status.USED, used_at__gte=since,
        )
        .annotate(day=TruncDate("used_at"))
        .values("day")
        .annotate(c=Count("id"))
    )
    used_by_day = {row["day"].isoformat(): row["c"] for row in used_qs}

    # 拼时间轴
    series = []
    today = timezone.localtime().date()
    for i in range(days):
        d = (today - timedelta(days=days - 1 - i)).isoformat()
        slot = visit_by_day.get(d, {"h5_visits": 0, "led_visits": 0})
        series.append({
            "date": d,
            "h5_visits": slot["h5_visits"],
            "led_visits": slot["led_visits"],
            "claims": claim_by_day.get(d, 0),
            "redeems": used_by_day.get(d, 0),
        })

    # 总计
    totals = {
        "h5_visits": sum(s["h5_visits"] for s in series),
        "led_visits": sum(s["led_visits"] for s in series),
        "claims": sum(s["claims"] for s in series),
        "redeems": sum(s["redeems"] for s in series),
        "uv_h5": uv_h5,
        "uv_led": uv_led,
    }
    # 转化率（除零保护）
    def rate(a, b):
        return round(a / b * 100, 2) if b > 0 else 0
    conversion = {
        "h5_visit_to_claim": rate(totals["claims"], totals["h5_visits"]),
        "claim_to_redeem": rate(totals["redeems"], totals["claims"]),
        "overall": rate(totals["redeems"], totals["h5_visits"]),
    }

    return Response({
        "days": days,
        "since": since.isoformat(),
        "totals": totals,
        "conversion": conversion,
        "series": series,
    })


# ============================================================
# Phase 2.5 - 数据导出（CSV）
# ============================================================

def _csv_response(filename: str, rows):
    """统一 CSV 响应：加 UTF-8 BOM 让 Excel 中文不乱码"""
    import csv
    import io
    from django.http import HttpResponse

    buf = io.StringIO()
    buf.write("﻿")  # BOM
    writer = csv.writer(buf)
    for row in rows:
        writer.writerow(row)
    resp = HttpResponse(buf.getvalue(), content_type="text/csv; charset=utf-8")
    resp["Content-Disposition"] = f'attachment; filename="{filename}"'
    return resp


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def export_project_funnel(request, project_id):
    """
    GET /api/projects/{id}/stats/funnel/export/?days=30
    导出每日漏斗 CSV
    """
    from datetime import timedelta
    from django.db.models import Count
    from django.db.models.functions import TruncDate
    from apps.projects.models import RedeemCode

    project = _get_project(project_id)
    days = int(request.query_params.get("days", 30))
    days = max(1, min(days, 365))
    since = timezone.now() - timedelta(days=days)

    visit_qs = (
        PageVisitLog.objects.filter(project=project, visited_at__gte=since)
        .annotate(day=TruncDate("visited_at"))
        .values("day", "page_type").annotate(c=Count("id"))
    )
    visit_by_day = {}
    for row in visit_qs:
        d = row["day"].isoformat()
        slot = visit_by_day.setdefault(d, {"h5": 0, "led": 0})
        slot[row["page_type"]] = row["c"]

    claim_qs = (
        RedeemCode.objects.filter(project=project, created_at__gte=since)
        .annotate(day=TruncDate("created_at")).values("day").annotate(c=Count("id"))
    )
    claim_by_day = {r["day"].isoformat(): r["c"] for r in claim_qs}

    used_qs = (
        RedeemCode.objects.filter(
            project=project, status=RedeemCode.Status.USED, used_at__gte=since,
        ).annotate(day=TruncDate("used_at")).values("day").annotate(c=Count("id"))
    )
    used_by_day = {r["day"].isoformat(): r["c"] for r in used_qs}

    rows = [["日期", "H5 访问", "LED 访问", "领码", "核销",
             "访问→领码%", "领码→核销%"]]
    today = timezone.localtime().date()
    for i in range(days):
        d = (today - timedelta(days=days - 1 - i)).isoformat()
        slot = visit_by_day.get(d, {"h5": 0, "led": 0})
        h5 = slot["h5"]
        led = slot["led"]
        claims = claim_by_day.get(d, 0)
        redeems = used_by_day.get(d, 0)
        v2c = round(claims / h5 * 100, 2) if h5 > 0 else 0
        c2r = round(redeems / claims * 100, 2) if claims > 0 else 0
        rows.append([d, h5, led, claims, redeems, v2c, c2r])

    fname = f"funnel-{project.id}-{days}d-{today.isoformat()}.csv"
    return _csv_response(fname, rows)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def export_experiment(request, project_id):
    """
    GET /api/projects/{id}/experiment/export/
    导出当前实验的汇总 + 逐次访问明细
    """
    from apps.projects.models import RedeemCode

    project = _get_project(project_id)
    exp = Experiment.objects.filter(project=project).first()
    if not exp:
        return Response({"detail": "未配置实验"}, status=404)

    summary = _compute_experiment_stats(project, exp)

    rows = []
    rows.append(["==== 实验汇总 ===="])
    rows.append(["实验名", exp.name])
    rows.append(["状态", exp.get_status_display()])
    rows.append(["假设", exp.hypothesis or "—"])
    rows.append(["B 流量占比 (%)", exp.traffic_split_b])
    rows.append(["启动时间", exp.started_at.isoformat() if exp.started_at else "—"])
    rows.append(["结束时间", exp.stopped_at.isoformat() if exp.stopped_at else "—"])
    rows.append(["胜出变体", exp.winner or "—"])
    rows.append([])
    rows.append(["变体", "名称", "访问", "UV", "领码", "核销", "领码率(%)", "核销率(%)"])
    for v in summary.get("variants", []):
        rows.append([
            v["key"], v["name"], v["visits"], v["uv"],
            v["claims"], v["redeems"], v["claim_rate"], v["redeem_rate"],
        ])
    sig = summary.get("significance") or {}
    rows.append([])
    rows.append(["显著性 z-score", sig.get("z_score") or "—"])
    rows.append(["95% 置信", "是" if sig.get("confident") else "否"])
    rows.append(["领先变体", sig.get("leader") or "—"])
    rows.append([])

    # 逐次访问明细
    rows.append(["==== 访问明细 ===="])
    rows.append(["时间", "变体", "device_fp", "IP", "UA(截断)",
                 "referrer", "utm_source", "utm_campaign", "是否领码"])
    visits = (
        PageVisitLog.objects.filter(project=project, experiment=exp)
        .exclude(variant_key="")
        .order_by("visited_at")
        .select_related()
    )
    # 哪些 visit 触发了 claim
    claimed_visit_ids = set(
        RedeemCode.objects.filter(project=project, claim_visit__experiment=exp)
        .values_list("claim_visit_id", flat=True)
    )
    for v in visits:
        rows.append([
            v.visited_at.isoformat(),
            v.variant_key,
            v.device_fp,
            v.ip or "",
            (v.user_agent or "")[:80],
            v.referrer or "",
            v.utm_source or "",
            v.utm_campaign or "",
            "是" if v.id in claimed_visit_ids else "",
        ])

    fname = f"experiment-{project.id}-{exp.id}.csv"
    return _csv_response(fname, rows)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def upload_image(request, project_id):
    """通用图片上传：接收文件，保存到 media/blocks/，返回 URL"""
    file = request.FILES.get("file")
    if not file:
        return Response({"error": "请选择文件"}, status=status.HTTP_400_BAD_REQUEST)

    allowed = ("image/jpeg", "image/png", "image/gif", "image/webp", "image/svg+xml")
    if file.content_type not in allowed:
        return Response({"error": f"不支持的文件类型: {file.content_type}"}, status=status.HTTP_400_BAD_REQUEST)

    import uuid, os
    ext = os.path.splitext(file.name)[1] or ".jpg"
    filename = f"blocks/{uuid.uuid4().hex}{ext}"

    from django.core.files.storage import default_storage
    path = default_storage.save(filename, file)
    url = request.build_absolute_uri(f"{settings.MEDIA_URL}{path}")

    return Response({"url": url})
