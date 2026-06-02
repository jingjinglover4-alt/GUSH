"""
项目 / 兑换码 视图
- ProjectViewSet: 项目 CRUD + 绑定设备 + 批量生成兑换码
- RedeemCodeViewSet: 兑换码列表 + 作废
- 公开 C 端：兑换页 + 兑换 POST（不需要登录）
"""
import secrets
import string

from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
from django.db import transaction
from django.db.models import Count, Q
from django.shortcuts import get_object_or_404, render
from django.utils import timezone
from django.views.decorators.cache import never_cache
from django.views.decorators.clickjacking import xframe_options_exempt
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status, viewsets
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.pagination import PageNumberPagination
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response

from apps.devices.models import Channel, DispenseLog, Machine

from .models import Project, ProjectMachine, RedeemCode
from .serializers import (
    BindMachinesSerializer,
    BindProductsSerializer,
    GenerateCodesSerializer,
    ProjectDetailSerializer,
    ProjectListSerializer,
    ProjectWriteSerializer,
    PublicRedeemSerializer,
    RedeemCodeSerializer,
)

# 兑换码字符集：纯数字（用户在派样机硬件键盘上输入）
CODE_CHARSET = "0123456789"


def _generate_code(length: int) -> str:
    return "".join(secrets.choice(CODE_CHARSET) for _ in range(length))


class ProjectViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Project.objects.all()

    def get_queryset(self):
        qs = Project.objects.all().annotate(
            _machine_count=Count("machines", distinct=True),
            _code_total=Count("redeem_codes", distinct=True),
            _code_used=Count(
                "redeem_codes",
                filter=Q(redeem_codes__status=RedeemCode.Status.USED),
                distinct=True,
            ),
        )
        search = self.request.query_params.get("search")
        if search:
            qs = qs.filter(name__icontains=search)
        status_f = self.request.query_params.get("status")
        if status_f in Project.Status.values:
            qs = qs.filter(status=status_f)
        return qs

    def get_serializer_class(self):
        if self.action == "list":
            return ProjectListSerializer
        if self.action in ("create", "update", "partial_update"):
            return ProjectWriteSerializer
        return ProjectDetailSerializer

    def perform_create(self, serializer):
        serializer.save(created_by=self.request.user)

    def create(self, request, *args, **kwargs):
        ser = ProjectWriteSerializer(data=request.data)
        ser.is_valid(raise_exception=True)
        project = ser.save(created_by=request.user)
        out = ProjectDetailSerializer(project, context=self.get_serializer_context())
        return Response(out.data, status=status.HTTP_201_CREATED)

    @action(detail=True, methods=["post"])
    def bind_machines(self, request, pk=None):
        """覆盖式绑定：传入的 machine_ids 作为新的绑定集合"""
        project = self.get_object()
        ser = BindMachinesSerializer(data=request.data)
        ser.is_valid(raise_exception=True)
        ids = set(ser.validated_data["machine_ids"])

        existing = set(project.machines.values_list("id", flat=True))
        to_add = ids - existing
        to_remove = existing - ids

        with transaction.atomic():
            if to_add:
                machines = Machine.objects.filter(id__in=to_add)
                ProjectMachine.objects.bulk_create(
                    [ProjectMachine(project=project, machine=m) for m in machines],
                    ignore_conflicts=True,
                )
            if to_remove:
                ProjectMachine.objects.filter(project=project, machine_id__in=to_remove).delete()

        out = ProjectDetailSerializer(project, context=self.get_serializer_context())
        return Response(out.data)

    @action(detail=True, methods=["post"])
    def bind_products(self, request, pk=None):
        """覆盖式挂载礼品：传入的 product_ids 作为新的礼品清单"""
        project = self.get_object()
        ser = BindProductsSerializer(data=request.data)
        ser.is_valid(raise_exception=True)
        ids = list(set(ser.validated_data["product_ids"]))
        project.products.set(ids)
        out = ProjectDetailSerializer(project, context=self.get_serializer_context())
        return Response(out.data)

    # ===== 状态转移合法性矩阵（from → to 允许的集合）=====
    _ALLOWED_TRANSITIONS = {
        Project.Status.DRAFT:    {Project.Status.RUNNING},
        Project.Status.RUNNING:  {Project.Status.PAUSED, Project.Status.FINISHED},
        Project.Status.PAUSED:   {Project.Status.RUNNING, Project.Status.FINISHED},
        Project.Status.FINISHED: set(),  # 终态
    }

    @action(detail=True, methods=["get"])
    def preflight(self, request, pk=None):
        """
        发布上线前的自检：让前端弹个 checklist
        GET /api/projects/projects/{id}/preflight/
        返回每条检查的 {ok, message, severity: warn|block}
        """
        from apps.pages.models import H5Page, LedPage
        project: Project = self.get_object()
        checks = []

        # 1) 至少绑一台设备 - block
        machine_count = project.machines.count()
        checks.append({
            "key": "machine_bound",
            "label": "至少绑定 1 台设备",
            "ok": machine_count > 0,
            "severity": "block",
            "detail": f"当前绑定 {machine_count} 台" if machine_count else "尚未绑定设备",
        })

        # 2) 设备至少有 1 个货道有库存 - block
        from apps.devices.models import Channel
        has_stock = Channel.objects.filter(
            machine__in=project.machines.all(),
            product__isnull=False,
            current_stock__gt=0,
        ).exists() if machine_count else False
        checks.append({
            "key": "has_stock",
            "label": "至少 1 台设备的货道有库存",
            "ok": has_stock,
            "severity": "block",
            "detail": "" if has_stock else "请到设备详情用「一键补满 / 批量投放」给货道装货",
        })

        # 3) H5 已发布 - warn（用户访问 /p/{id}/ 看的是 draft 还是 published 内容）
        h5 = H5Page.objects.filter(project=project).first()
        h5_published = h5 and h5.status == H5Page.Status.PUBLISHED
        checks.append({
            "key": "h5_published",
            "label": "H5 落地页已发布",
            "ok": bool(h5_published),
            "severity": "warn",
            "detail": "" if h5_published else "页面装修 → H5 落地页 → 点「发布到线上」",
        })

        # 4) LED 已发布 - warn
        led = LedPage.objects.filter(project=project).first()
        led_published = led and led.status == LedPage.Status.PUBLISHED
        checks.append({
            "key": "led_published",
            "label": "LED 大屏页已发布",
            "ok": bool(led_published),
            "severity": "warn",
            "detail": "" if led_published else "页面装修 → LED 大屏 → 点「发布 LED 大屏」",
        })

        # 5) 时间窗口 - warn
        now = timezone.now()
        in_window = project.starts_at <= now <= project.ends_at
        checks.append({
            "key": "in_time_window",
            "label": "当前在活动时间窗口内",
            "ok": in_window,
            "severity": "warn",
            "detail": f"活动时间：{project.starts_at:%Y-%m-%d %H:%M} ~ {project.ends_at:%Y-%m-%d %H:%M}",
        })

        blockers = [c for c in checks if not c["ok"] and c["severity"] == "block"]
        return Response({
            "can_publish": len(blockers) == 0,
            "checks": checks,
        })

    @action(detail=True, methods=["post"], url_path="transition")
    def transition(self, request, pk=None):
        """
        切换项目状态。
        POST /api/projects/projects/{id}/transition/  body: {"to": "running|paused|finished", "force": false}
        - 强校验状态机
        - to=running 时默认跑 preflight；若有 block 检查未通过则 409；force=true 可跳过 warn 但不能跳过 block
        """
        project: Project = self.get_object()
        target = request.data.get("to")
        force = bool(request.data.get("force"))

        if target not in Project.Status.values:
            return Response({"detail": "目标状态非法"}, status=400)
        if target == project.status:
            return Response({"detail": f"项目已是「{project.get_status_display()}」"}, status=400)

        allowed = self._ALLOWED_TRANSITIONS.get(project.status, set())
        if target not in allowed:
            return Response({
                "detail": f"不允许从「{project.get_status_display()}」切换到「{Project.Status(target).label}」",
            }, status=400)

        # 上线前 preflight（force=false 时硬卡 block）
        if target == Project.Status.RUNNING and not force:
            check_resp = self.preflight(request, pk=pk).data
            if not check_resp["can_publish"]:
                return Response({
                    "detail": "发布前自检未通过，请处理 block 项后再试",
                    "preflight": check_resp,
                }, status=409)

        old = project.status
        project.status = target
        project.save(update_fields=["status", "updated_at"])

        return Response({
            "id": project.id,
            "from": old,
            "to": project.status,
            "status_label": project.get_status_display(),
        })

    @action(detail=True, methods=["post"])
    def generate_codes(self, request, pk=None):
        """批量生成兑换码"""
        project: Project = self.get_object()
        ser = GenerateCodesSerializer(data=request.data)
        ser.is_valid(raise_exception=True)
        n = ser.validated_data["count"]

        expires_at = timezone.now() + timezone.timedelta(days=project.code_validity_days)
        created = []
        # 简单实现：循环生成并 bulk_create，遇唯一冲突重试
        attempts = 0
        max_attempts = n * 3
        seen = set()
        while len(created) < n and attempts < max_attempts:
            code = _generate_code(project.code_length)
            if code in seen:
                attempts += 1
                continue
            seen.add(code)
            created.append(RedeemCode(project=project, code=code, expires_at=expires_at))
            attempts += 1

        # 一次性入库；唯一冲突 → ignore，前端用 count 区分
        RedeemCode.objects.bulk_create(created, ignore_conflicts=True)
        actual = RedeemCode.objects.filter(
            project=project, code__in=[c.code for c in created]
        ).count()

        return Response({
            "requested": n,
            "created": actual,
            "expires_at": expires_at,
        })


class RedeemCodePagination(PageNumberPagination):
    page_size = 50
    page_size_query_param = "page_size"
    max_page_size = 500


class RedeemCodeViewSet(viewsets.ReadOnlyModelViewSet):
    """
    GET    /api/projects/codes/?project={id}&status=unused
    POST   /api/projects/codes/{id}/revoke/
    """
    permission_classes = (IsAuthenticated,)
    serializer_class = RedeemCodeSerializer
    pagination_class = RedeemCodePagination
    queryset = RedeemCode.objects.all()

    def get_queryset(self):
        qs = RedeemCode.objects.all().select_related("project", "used_on_machine")
        project_id = self.request.query_params.get("project")
        if project_id:
            qs = qs.filter(project_id=project_id)
        status_f = self.request.query_params.get("status")
        if status_f in RedeemCode.Status.values:
            qs = qs.filter(status=status_f)
        search = self.request.query_params.get("search")
        if search:
            qs = qs.filter(code__icontains=search.upper())
        return qs

    @action(detail=True, methods=["post"])
    def revoke(self, request, pk=None):
        code = self.get_object()
        if code.status != RedeemCode.Status.UNUSED:
            return Response({"detail": "只能作废未使用的兑换码"}, status=400)
        code.status = RedeemCode.Status.REVOKED
        code.save(update_fields=["status"])
        return Response(RedeemCodeSerializer(code).data)


# ============================================================
# 公开（C 端）接口 - 不需要登录
# ============================================================

@never_cache
@xframe_options_exempt
def public_redeem_page(request, project_id):
    """
    H5 落地页：用户扫码后进入 → 填表单 → 拿兑换码 → 在派样机输入兑换码
    生产域名：https://{subdomain}.gush.cdgushai.com/p/{project_id}/
    本地开发：http://localhost:8000/p/{project_id}/
    可选 ?machine_id=... → 标识当前在哪台机器扫的
    页面内容从 H5Page + PageTheme 读取（Phase 1.2）
    """
    import json

    from apps.pages.resolver import pick_experiment_variant, resolve_h5, resolve_theme

    project = get_object_or_404(Project, id=project_id)

    # 设备来源：优先用子域名解析出的 machine（Phase 1.7），否则 URL query
    machine = getattr(request, "device_machine", None)
    if not machine:
        machine_id = request.GET.get("machine_id", "")
        if machine_id:
            machine = Machine.objects.filter(machine_id=machine_id).first()

    h5 = resolve_h5(project, machine=machine)
    theme = resolve_theme(project, machine=machine, request=request)

    # Phase 2.5 隐私协议正文：拿到 H5Page id + 正文，供模板渲染"查看协议"弹窗
    from apps.pages.models import H5Page
    _h5_page_obj = H5Page.objects.filter(project=project).first()
    h5_page_id = _h5_page_obj.id if _h5_page_obj else 0
    privacy_policy_text = (getattr(_h5_page_obj, "privacy_policy", "") if _h5_page_obj else "") or ""

    # Phase 2.3：若有 running 实验，覆盖 h5 内容
    # Phase 2.4：?preview_variant=A|B → 强制渲染指定变体（编辑器预览用，不落 cookie、不计入访问统计）
    exp_obj = None
    variant_key = ""
    preview_variant = (request.GET.get("preview_variant") or "").upper()
    is_preview = preview_variant in ("A", "B") or request.GET.get("preview") == "1"

    if is_preview:
        from apps.pages.models import Experiment
        exp_obj = Experiment.objects.filter(project=project).prefetch_related("variants").first()
        if exp_obj:
            variant = next((v for v in exp_obj.variants.all() if v.key == preview_variant), None)
            if variant:
                variant_key = preview_variant
                variant_snapshot = variant.h5_snapshot
                if variant_snapshot:
                    for k, v in variant_snapshot.items():
                        if k in {"header_title", "header_subtitle", "blocks", "form_fields",
                                 "privacy", "submit_button", "rate_limit", "success_view",
                                 "page1_button_text", "page2_button_text",
                                 "header_style", "page1_button_style"}:
                            h5[k] = v
    else:
        fp_cookie = request.COOKIES.get("gush_device_fp", "")
        exp_obj, variant_key, variant_snapshot = pick_experiment_variant(
            project,
            device_fp=fp_cookie,
            cookie_variant=request.COOKIES.get(f"gush_exp_{project.id}", ""),
        )
        if exp_obj and variant_snapshot:
            for k, v in variant_snapshot.items():
                if k in {"header_title", "header_subtitle", "blocks", "form_fields",
                         "privacy", "submit_button", "rate_limit", "success_view",
                         "page1_button_text", "page2_button_text",
                         "header_style", "page1_button_style"}:
                    h5[k] = v

    response = render(request, "public_redeem.html", {
        "project": project,
        "machine": machine,
        "h5_page": h5,
        "theme": theme,
        # Phase 2.3：注入到模板供 JS 上报使用
        "experiment_id": exp_obj.id if exp_obj else "",
        "variant_key": variant_key,
        "is_preview": is_preview,
        # 注入 JS 用的 JSON 字符串（避免 Django 模板把 dict 渲染成 Python repr）
        "blocks_json": json.dumps(h5.get("blocks") or [], ensure_ascii=False),
        "fields_json": json.dumps(h5.get("form_fields") or [], ensure_ascii=False),
        "privacy_json": json.dumps(h5.get("privacy") or {}, ensure_ascii=False),
        "submit_json": json.dumps(h5.get("submit_button") or {}, ensure_ascii=False),
        "success_json": json.dumps(h5.get("success_view") or {}, ensure_ascii=False),
        # 各页背景 - 直接传值，方便模板使用
        "page1_bg_type": (h5.get("page1_background") or {}).get("type", "color"),
        "page1_bg_value": (h5.get("page1_background") or {}).get("value", "#0a0a0a"),
        "page1_bg_fit": (h5.get("page1_background") or {}).get("fit", "cover"),
        "page2_bg_type": (h5.get("page2_background") or {}).get("type", "color"),
        "page2_bg_value": (h5.get("page2_background") or {}).get("value", "#0a0a0a"),
        "page2_bg_fit": (h5.get("page2_background") or {}).get("fit", "cover"),
        "header_position_json": json.dumps(h5.get("header_position") or {"x": 50, "y": 25}, ensure_ascii=False),
        "button_position_json": json.dumps(h5.get("button_position") or {"x": 50, "y": 75}, ensure_ascii=False),
        "h5_page_id": h5_page_id,
        "privacy_policy_text": privacy_policy_text,
        "now": timezone.now(),
    })

    # Phase 2.3：粘性 cookie，保证同访客始终看到同一变体
    # preview 模式不落 cookie，避免污染真实访客状态
    if exp_obj and variant_key and not is_preview:
        response.set_cookie(
            f"gush_exp_{project.id}", variant_key,
            max_age=60 * 60 * 24 * 30,  # 30 天
            samesite="Lax",
        )
    return response


@csrf_exempt
@api_view(["POST"])
@permission_classes([AllowAny])
def public_claim_submit(request):
    """
    H5 落地页表单提交 → 生成兑换码并返回
    body: {"project_id": 1, "machine_id": "MACHINE001", "form": {...}, "visit_id": optional}
    Phase 2.2：若带 visit_id 则串联到 RedeemCode.claim_visit
    """
    from apps.pages.models import PageVisitLog

    project_id = request.data.get("project_id")
    machine_id = (request.data.get("machine_id") or "").strip()
    form_data = request.data.get("form") or {}
    visit_id = request.data.get("visit_id")

    project = Project.objects.filter(id=project_id).first()
    if not project:
        return Response({"detail": "项目不存在"}, status=404)
    if project.status != Project.Status.RUNNING:
        return Response({"detail": "活动暂未开始或已结束"}, status=400)

    visit_obj = None
    if visit_id:
        visit_obj = PageVisitLog.objects.filter(id=visit_id, project=project).first()

    openid = (form_data.get("openid") or "").strip()
    nickname = (form_data.get("name") or form_data.get("nickname") or "").strip()[:64]
    expires_at = timezone.now() + timezone.timedelta(days=project.code_validity_days)

    code_str = None
    for _ in range(5):
        candidate = _generate_code(project.code_length)
        if not RedeemCode.objects.filter(code=candidate).exists():
            try:
                rc = RedeemCode.objects.create(
                    project=project,
                    code=candidate,
                    expires_at=expires_at,
                    user_openid=openid,
                    user_nickname=nickname,
                    claim_visit=visit_obj,
                )
                code_str = rc.code
                break
            except Exception:
                continue

    if not code_str:
        return Response({"detail": "兑换码生成失败，请稍后重试"}, status=500)

    return Response({
        "code": code_str,
        "expires_at": expires_at,
    })


@csrf_exempt
@api_view(["POST"])
@permission_classes([AllowAny])
def public_redeem_submit(request):
    """
    C 端提交兑换码（用户在派样机上输入兑换码 → 调用此接口）
    body: {"code":"XXXX","machine_id":"MACHINE001"}
    - 校验码状态 / 有效期 / 项目是否绑定此机器
    - 选择一个有库存且非故障的货道
    - 标记码为 used
    - 通过 channel layer 下发 motor_run 到设备
    """
    ser = PublicRedeemSerializer(data=request.data)
    ser.is_valid(raise_exception=True)
    code_str = ser.validated_data["code"].strip().upper()
    machine_id = ser.validated_data.get("machine_id", "").strip()

    if not machine_id:
        return Response({"detail": "缺少 machine_id"}, status=400)

    machine = Machine.objects.filter(machine_id=machine_id).first()
    if not machine:
        return Response({"detail": "设备不存在"}, status=404)

    with transaction.atomic():
        code = (
            RedeemCode.objects
            .select_for_update()
            .select_related("project")
            .filter(code=code_str)
            .first()
        )
        if not code:
            return Response({"detail": "兑换码不存在"}, status=404)
        if code.status == RedeemCode.Status.USED:
            return Response({"detail": "兑换码已被使用"}, status=400)
        if code.status == RedeemCode.Status.REVOKED:
            return Response({"detail": "兑换码已作废"}, status=400)
        if code.expires_at < timezone.now():
            if code.status != RedeemCode.Status.EXPIRED:
                code.status = RedeemCode.Status.EXPIRED
                code.save(update_fields=["status"])
            return Response({"detail": "兑换码已过期"}, status=400)

        # 项目-设备是否绑定
        if not code.project.machines.filter(id=machine.id).exists():
            return Response({"detail": "兑换码与当前设备不匹配"}, status=400)

        # 选一个可用货道：库存 > 0 且非故障；
        # 若项目挂载了礼品清单，则优先选这些礼品对应的货道
        ch_qs = (
            Channel.objects
            .filter(machine=machine, current_stock__gt=0)
            .exclude(status=Channel.Status.FAULT)
        )
        project_products = list(code.project.products.values_list("id", flat=True))
        import random
        strategy = machine.dispense_strategy
        if strategy == "random":
            if project_products:
                scoped = list(ch_qs.filter(product_id__in=project_products))
                channel = random.choice(scoped) if scoped else None
            else:
                scoped = list(ch_qs)
                channel = random.choice(scoped) if scoped else None
        else:
            if project_products:
                scoped = ch_qs.filter(product_id__in=project_products).order_by("row", "col")
                channel = scoped.first() or ch_qs.order_by("row", "col").first()
            else:
                channel = ch_qs.order_by("row", "col").first()
        if not channel:
            return Response({"detail": "设备无可用库存"}, status=409)

        # 标记为已使用
        code.status = RedeemCode.Status.USED
        code.used_at = timezone.now()
        code.used_on_machine = machine
        code.used_on_channel_code = channel.channel_code
        code.save(update_fields=["status", "used_at", "used_on_machine", "used_on_channel_code"])

        # 库存预扣（设备实际出货完成后 motor_done 会再扣一次？不会，因为这里只是预扣 UI 优化）
        # 决策：不在这里扣库存，等设备回 motor_done 时统一扣；这边只是发起指令
        # 但状态保险起见也算个预出货
        log = DispenseLog.objects.create(
            machine=machine,
            channel=channel,
            channel_code=channel.channel_code,
            redeem_code=code,
            result=DispenseLog.Result.BUSY,  # 先标 busy，等 motor_done 改 success
            detail="兑换码触发，等待设备出货",
        )

    # 通过 channel layer 下发指令
    motor_id = (ord(channel.channel_code[0]) - ord("A")) * 10 + int(channel.channel_code[1]) + 1
    layer = get_channel_layer()
    if layer is not None:
        async_to_sync(layer.group_send)(
            f"device_{machine.machine_id}",
            {"type": "device.command", "payload": {
                "cmd": "motor_run",
                "id": motor_id,
                "num": 1,
            }},
        )

    return Response({
        "detail": "兑换成功，请到取货口领取",
        "channel": channel.channel_code,
        "machine_id": machine.machine_id,
        "log_id": log.id,
    })


# ============================================================
# 客户端看板（公开，通过 client_token 访问）
# ============================================================

@never_cache
@api_view(["GET"])
@permission_classes([AllowAny])
def public_project_dashboard_api(request, token):
    """
    GET /api/public/project-dashboard/{token}/
    返回单个项目的统计数据摘要（无登录、仅通过 token 鉴权）
    """
    from datetime import timedelta

    from django.db.models import Count, Q, Sum
    from django.utils import timezone

    from apps.devices.models import Channel, DispenseLog, Machine
    from apps.pages.models import PageVisitLog

    project = get_object_or_404(Project, client_token=token)
    now = timezone.now()
    today_start = now.replace(hour=0, minute=0, second=0, microsecond=0)
    days_ago_7 = now - timedelta(days=7)
    days_ago_30 = now - timedelta(days=30)

    machines = project.machines.all()
    machine_ids = list(machines.values_list("id", flat=True))

    # 设备状态
    by_status = dict(
        machines.values_list("status").annotate(c=Count("id")).values_list("status", "c")
    )
    machine_total = len(machine_ids)
    machine_online = by_status.get("online", 0)
    machine_offline = by_status.get("offline", 0)
    machine_fault = by_status.get("fault", 0)

    # 货道状态
    channels = Channel.objects.filter(machine_id__in=machine_ids)
    channel_total = channels.count()
    channel_stocked = channels.filter(current_stock__gt=0).count()
    channel_fault_count = channels.filter(status=Channel.Status.FAULT).count()
    total_stock = channels.aggregate(s=Sum("current_stock"))["s"] or 0

    # 出货统计
    dispenses = DispenseLog.objects.filter(machine_id__in=machine_ids)
    dispense_total = dispenses.count()
    dispense_today = dispenses.filter(created_at__gte=today_start).count()
    dispense_success = dispenses.filter(result=DispenseLog.Result.SUCCESS).count()
    dispense_7d = dispenses.filter(created_at__gte=days_ago_7).count()

    # 每日出货趋势（近 30 天）
    dispense_trend = []
    for i in range(29, -1, -1):
        d = (today_start - timedelta(days=i)).date()
        count = dispenses.filter(
            created_at__gte=d,
            created_at__lt=d + timedelta(days=1),
        ).count()
        dispense_trend.append({"date": d.isoformat(), "count": count})

    # 漏斗：访问 → 领码 → 核销
    visits = PageVisitLog.objects.filter(project=project)
    h5_visits_7d = visits.filter(page_type="h5", visited_at__gte=days_ago_7).count()
    led_visits_7d = visits.filter(page_type="led", visited_at__gte=days_ago_7).count()
    h5_visits_total = visits.filter(page_type="h5").count()
    led_visits_total = visits.filter(page_type="led").count()

    codes = project.redeem_codes
    claims_total = codes.count()
    redeems_total = codes.filter(status=RedeemCode.Status.USED).count()
    claims_7d = codes.filter(created_at__gte=days_ago_7).count()
    redeems_7d = codes.filter(used_at__gte=days_ago_7).count()

    # 项目状态
    time_remaining = None
    if project.ends_at and project.ends_at > now:
        remaining = project.ends_at - now
        time_remaining = int(remaining.total_seconds())

    return Response({
        "project": {
            "id": project.id,
            "name": project.name,
            "description": project.description,
            "status": project.status,
            "status_label": project.get_status_display(),
            "starts_at": project.starts_at,
            "ends_at": project.ends_at,
            "time_remaining_seconds": time_remaining,
        },
        "machines": {
            "total": machine_total,
            "online": machine_online,
            "offline": machine_offline,
            "fault": machine_fault,
            "online_rate": round(machine_online / machine_total * 100, 1) if machine_total else 0,
        },
        "channels": {
            "total": channel_total,
            "stocked": channel_stocked,
            "fault": channel_fault_count,
            "total_stock": total_stock,
        },
        "dispenses": {
            "total": dispense_total,
            "today": dispense_today,
            "last_7d": dispense_7d,
            "success": dispense_success,
            "trend": dispense_trend,
        },
        "funnel": {
            "h5_visits": {"total": h5_visits_total, "last_7d": h5_visits_7d},
            "led_visits": {"total": led_visits_total, "last_7d": led_visits_7d},
            "claims": {"total": claims_total, "last_7d": claims_7d},
            "redeems": {"total": redeems_total, "last_7d": redeems_7d},
            "conversion_claim_rate": round(redeems_total / claims_total * 100, 1) if claims_total else 0,
            "conversion_visit_to_redeem": round(redeems_total / (h5_visits_total + led_visits_total) * 100, 1) if (h5_visits_total + led_visits_total) else 0,
        },
    })


@never_cache
def public_project_dashboard_page(request, token):
    """渲染客户端看板 HTML 页面"""
    project = get_object_or_404(Project, client_token=token)
    return render(request, "client_dashboard.html", {
        "project": project,
        "dashboard_api_url": f"/api/public/project-dashboard/{token}/",
    })


# ============ Qt 上位机接口 ============

@csrf_exempt
@api_view(["POST"])
@permission_classes([AllowAny])
def qt_exchange(request):
    """
    Qt 上位机兑换码验证接口
    请求: {"code": "XXXX", "machine_id": "MACHINE001"}
    返回: {"type": "random"|"order", "result": "on"|"off"}
    - type: 出货策略（设备配置）
    - result: on=成功 off=失败
    """
    code_str = request.data.get("code", "").strip().upper()
    machine_id = request.data.get("machine_id", "").strip()

    if not code_str:
        return Response({"type": "order", "result": "off"})

    if not machine_id:
        return Response({"type": "order", "result": "off"})

    machine = Machine.objects.filter(machine_id=machine_id).first()
    if not machine:
        return Response({"type": "order", "result": "off"})

    strategy = machine.dispense_strategy or "sequential"
    qt_type = "random" if strategy == "random" else "order"

    with transaction.atomic():
        code = (
            RedeemCode.objects
            .select_for_update()
            .select_related("project")
            .filter(code=code_str)
            .first()
        )
        if not code:
            return Response({"type": qt_type, "result": "off"})
        if code.status != RedeemCode.Status.UNUSED:
            return Response({"type": qt_type, "result": "off"})
        if code.expires_at and code.expires_at < timezone.now():
            if code.status != RedeemCode.Status.EXPIRED:
                code.status = RedeemCode.Status.EXPIRED
                code.save(update_fields=["status"])
            return Response({"type": qt_type, "result": "off"})

        if not code.project.machines.filter(id=machine.id).exists():
            return Response({"type": qt_type, "result": "off"})

        code.status = RedeemCode.Status.USED
        code.used_at = timezone.now()
        code.used_on_machine = machine
        code.save(update_fields=["status", "used_at", "used_on_machine"])

    return Response({"type": qt_type, "result": "on"})


@csrf_exempt
@api_view(["POST"])
@permission_classes([AllowAny])
def qt_report(request):
    """
    Qt 上位机出货完成上报接口
    请求: {"channel": "A0", "machine_id": "MACHINE001"}
    返回: {"ok": true}
    - 扣减对应货道库存
    - 更新出货日志状态
    """
    channel_code = request.data.get("channel", "").strip().upper()
    machine_id = request.data.get("machine_id", "").strip()

    if not channel_code or not machine_id:
        return Response({"ok": False})

    machine = Machine.objects.filter(machine_id=machine_id).first()
    if not machine:
        return Response({"ok": False})

    ch = Channel.objects.filter(
        machine=machine, channel_code=channel_code
    ).first()

    if ch and ch.current_stock > 0:
        ch.current_stock -= 1
        ch.save(update_fields=["current_stock"])
        ch.recompute_status(save=True)

    redeem = (
        RedeemCode.objects
        .filter(used_on_machine=machine, status=RedeemCode.Status.USED, used_on_channel_code="")
        .order_by("-used_at")
        .first()
    )
    if redeem:
        redeem.used_on_channel_code = channel_code
        redeem.save(update_fields=["used_on_channel_code"])

    DispenseLog.objects.create(
        machine=machine,
        channel=ch,
        channel_code=channel_code,
        redeem_code=redeem,
        result=DispenseLog.Result.SUCCESS,
        detail="出货完成（Qt上报）",
    )

    return Response({"ok": True})
