"""
仪表盘统计接口
- 设备状态分布
- 今日 / 近 7 日 出货数
- 各项目兑换排行
- 近 7 日按天出货趋势
- 库存预警货道（库存 ≤ low 阈值）
"""
from datetime import timedelta

from django.db.models import Count, Q
from django.utils import timezone
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from apps.devices.models import Channel, DispenseLog, Machine
from apps.projects.models import Project, RedeemCode


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def dashboard(request):
    now = timezone.now()
    today = now.replace(hour=0, minute=0, second=0, microsecond=0)
    week_ago = today - timedelta(days=6)

    # ---- 设备状态 ----
    by_status = dict(Machine.objects.values_list("status").annotate(c=Count("id")).values_list("status", "c"))
    device_total = sum(by_status.values())

    # ---- 货道状态 ----
    channel_by_status = dict(
        Channel.objects.values_list("status").annotate(c=Count("id")).values_list("status", "c")
    )

    # ---- 出货统计 ----
    dispense_today = DispenseLog.objects.filter(created_at__gte=today, result=DispenseLog.Result.SUCCESS).count()
    dispense_7d = DispenseLog.objects.filter(created_at__gte=week_ago, result=DispenseLog.Result.SUCCESS).count()

    # 近 7 天按天 trend
    trend = []
    qs = (
        DispenseLog.objects
        .filter(created_at__gte=week_ago, result=DispenseLog.Result.SUCCESS)
        .extra(select={"d": "DATE(created_at)"})
        .values("d")
        .annotate(c=Count("id"))
    )
    by_day = {str(row["d"]): row["c"] for row in qs}
    for i in range(7):
        d = (week_ago + timedelta(days=i)).date()
        trend.append({"date": d.isoformat(), "count": by_day.get(d.isoformat(), 0)})

    # ---- 项目兑换排行 ----
    proj_rank = list(
        Project.objects
        .annotate(used=Count("redeem_codes", filter=Q(redeem_codes__status=RedeemCode.Status.USED)))
        .order_by("-used")
        .values("id", "name", "used")[:5]
    )

    # ---- 库存预警 ----
    low_channels = (
        Channel.objects
        .filter(status__in=[Channel.Status.EMPTY, Channel.Status.LOW])
        .select_related("machine", "product")
        .order_by("current_stock")[:10]
    )
    low_list = [
        {
            "machine_id": ch.machine.machine_id,
            "channel_code": ch.channel_code,
            "status": ch.status,
            "current_stock": ch.current_stock,
            "capacity": ch.capacity,
            "product": ch.product.name if ch.product else "",
        }
        for ch in low_channels
    ]

    # ---- 兑换码总览 ----
    code_total = RedeemCode.objects.count()
    code_used = RedeemCode.objects.filter(status=RedeemCode.Status.USED).count()

    # ---- Phase 4.2 新增 ----
    from apps.pages.models import Experiment, PageVisitLog
    from apps.face.models import FaceObservation

    visit_today_h5 = PageVisitLog.objects.filter(visited_at__gte=today, page_type="h5").count()
    visit_today_led = PageVisitLog.objects.filter(visited_at__gte=today, page_type="led").count()
    claim_today = RedeemCode.objects.filter(created_at__gte=today).count()

    project_running = Project.objects.filter(status=Project.Status.RUNNING).count()
    project_draft = Project.objects.filter(status=Project.Status.DRAFT).count()

    exp_running = Experiment.objects.filter(status=Experiment.Status.RUNNING).count()
    exp_stopped = Experiment.objects.filter(status=Experiment.Status.STOPPED).count()

    face_today = FaceObservation.objects.filter(observed_at__gte=today).count()
    face_gender = dict(
        FaceObservation.objects.values_list("gender")
        .annotate(c=Count("id")).values_list("gender", "c")
    )

    # ---- 设备地图位置 ----
    device_locations = list(
        Machine.objects.exclude(longitude__isnull=True, latitude__isnull=True)
        .values("id", "machine_id", "name", "address", "longitude", "latitude", "status", "network_plan", "network_type")
    )

    return Response({
        "device": {
            "total": device_total,
            "online": by_status.get("online", 0),
            "offline": by_status.get("offline", 0),
            "fault": by_status.get("fault", 0),
        },
        "channel": {
            "normal": channel_by_status.get("normal", 0),
            "low": channel_by_status.get("low", 0),
            "empty": channel_by_status.get("empty", 0),
            "fault": channel_by_status.get("fault", 0),
        },
        "dispense": {
            "today": dispense_today,
            "last_7d": dispense_7d,
            "trend": trend,
        },
        "redeem_code": {
            "total": code_total,
            "used": code_used,
        },
        "project_rank": proj_rank,
        "low_channels": low_list,
        # Phase 4.2 新增
        "today_funnel": {
            "h5_visits": visit_today_h5,
            "led_visits": visit_today_led,
            "claims": claim_today,
            "redeems": dispense_today,
        },
        "project": {
            "running": project_running,
            "draft": project_draft,
        },
        "experiment": {
            "running": exp_running,
            "stopped": exp_stopped,
        },
        "face": {
            "today": face_today,
            "by_gender": face_gender,
        },
        "device_locations": device_locations,
    })
