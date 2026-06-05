"""
用户获客列表 - 业务方真正看的报表

每行 = 一次领码（RedeemCode），左侧表单字段、右侧画像标签
"""
import json
from datetime import timedelta

from django.shortcuts import get_object_or_404
from django.utils import timezone
from rest_framework.decorators import api_view, permission_classes
from rest_framework.pagination import PageNumberPagination
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from apps.projects.models import Project, RedeemCode

from .models import FaceObservation


def _build_field_map(project):
    """从 project 关联的 H5Page 中提取表单字段定义"""
    page = None
    try:
        from apps.pages.models import H5Page
        page = H5Page.objects.filter(project=project).order_by("-id").first()
    except Exception:
        pass

    key_map = {}          # f_randomKey → 中文 label
    option_map = {}       # f_randomKey → {opt_value: opt_label}
    field_order = []      # 字段顺序

    if page and page.form_fields:
        for field in page.form_fields:
            fkey = field.get("key", "")
            label = field.get("label", fkey)
            key_map[fkey] = label
            field_order.append(fkey)

            choices = field.get("options") or field.get("choices") or []
            if choices:
                opt_map = {}
                for opt in choices:
                    opt_map[str(opt.get("value", ""))] = opt.get("label", str(opt.get("value", "")))
                option_map[fkey] = opt_map

    return key_map, option_map, field_order


def _humanize_form_data(form_data, key_map, option_map, field_order):
    """把 form_data 映射为可读的 [{label, value}] 列表并按 field_order 排序"""
    if not form_data or not isinstance(form_data, dict):
        return []

    items = []
    for k, raw_v in form_data.items():
        label = key_map.get(k, k)

        if k in option_map and raw_v is not None and raw_v != "":
            opt_map = option_map[k]
            raw_s = str(raw_v).strip()

            # 尝试精确匹配
            if raw_s in opt_map:
                label_v = opt_map[raw_s]
            else:
                # 可能是序号映射（前端用 1,2,3 做选项值）
                # 如果 opt_map 的 value 本身是纯数字字符串
                digit_match = None
                for opt_k, opt_label in opt_map.items():
                    if raw_s == opt_label:
                        digit_match = opt_label
                        break
                label_v = digit_match or raw_s

            items.append({"label": label, "value": label_v})
        else:
            v = raw_v if raw_v is not None else ""
            items.append({"label": label, "value": str(v)})

    # 按 field_order 排序
    order_map = {k: i for i, k in enumerate(field_order)}
    items.sort(key=lambda x: order_map.get(x["label"], 999))

    return items


def _row(code: RedeemCode, key_map=None, option_map=None, field_order=None):
    """把 RedeemCode + visit + observation 拍平成一行 JSON"""
    visit = getattr(code, "claim_visit", None)
    obs = None
    if visit:
        obs = getattr(visit, "face_observation", None)

    # 可读化 form_data
    form_data_display = _humanize_form_data(
        code.form_data, key_map or {}, option_map or {}, field_order or []
    )

    return {
        "id": code.id,
        "code": code.code,
        "status": code.status,
        "status_label": code.get_status_display(),
        "claimed_at": code.created_at.isoformat() if code.created_at else None,
        "used_at": code.used_at.isoformat() if code.used_at else None,
        # 表单侧（来自 RedeemCode）
        "user_nickname": code.user_nickname or "",
        "user_openid": code.user_openid or "",
        "form_data": code.form_data or {},
        "form_data_display": form_data_display,
        # 设备
        "claim_machine_id": (visit.machine.machine_id if (visit and visit.machine) else ""),
        "used_machine_id": (code.used_on_machine.machine_id if code.used_on_machine else ""),
        "used_channel": code.used_on_channel_code or "",
        # 画像侧
        "face": {
            "gender": obs.gender if obs else "",
            "gender_label": obs.get_gender_display() if obs else "",
            "age": obs.age if obs else None,
            "age_range": obs.age_range if obs else "",
            "age_range_label": obs.get_age_range_display() if obs else "",
            "dominant_emotion": obs.dominant_emotion if obs else "",
            "dominant_emotion_label": obs.get_dominant_emotion_display() if obs else "",
            "is_smiling": obs.is_smiling if obs else False,
            "observed_at": obs.observed_at.isoformat() if obs else None,
        } if obs else None,
    }


class LeadsPagination(PageNumberPagination):
    page_size = 30
    page_size_query_param = "page_size"
    max_page_size = 200


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def project_leads(request, project_id):
    """
    GET /api/projects/{id}/leads/
    Query params:
        ?status=unused|used|expired|revoked
        ?gender=male|female
        ?age_range=child|teen|young_adult|adult|senior
        ?emotion=happy|neutral|surprised|sad|angry|disgusted|fear
        ?since=YYYY-MM-DD
        ?search=<nickname/code>
        ?page=&page_size=
    """
    project = get_object_or_404(Project, id=project_id)
    qs = (
        RedeemCode.objects
        .filter(project=project)
        .select_related("claim_visit__face_observation",
                        "claim_visit__machine",
                        "used_on_machine")
        .order_by("-created_at")
    )

    status_f = request.query_params.get("status")
    if status_f:
        qs = qs.filter(status=status_f)

    gender = request.query_params.get("gender")
    if gender:
        qs = qs.filter(claim_visit__face_observation__gender=gender)

    age_range = request.query_params.get("age_range")
    if age_range:
        qs = qs.filter(claim_visit__face_observation__age_range=age_range)

    emotion = request.query_params.get("emotion")
    if emotion:
        qs = qs.filter(claim_visit__face_observation__dominant_emotion=emotion)

    since = request.query_params.get("since")
    if since:
        from django.utils.dateparse import parse_date
        d = parse_date(since)
        if d:
            qs = qs.filter(created_at__date__gte=d)

    search = (request.query_params.get("search") or "").strip()
    if search:
        from django.db.models import Q
        qs = qs.filter(Q(user_nickname__icontains=search) | Q(code__icontains=search))

    # 构建字段映射（只查一次）
    key_map, option_map, field_order = _build_field_map(project)

    paginator = LeadsPagination()
    page = paginator.paginate_queryset(qs, request)
    return paginator.get_paginated_response([_row(c, key_map, option_map, field_order) for c in page])


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def project_leads_summary(request, project_id):
    """
    GET /api/projects/{id}/leads/summary/
    画像汇总：性别分布 / 年龄段 / 情绪 / 微笑率
    """
    from django.db.models import Count
    project = get_object_or_404(Project, id=project_id)

    base = FaceObservation.objects.filter(matched_visit__project=project)

    by_gender = {r["gender"]: r["c"] for r in
                 base.order_by().values("gender").annotate(c=Count("id"))}
    by_age = {r["age_range"]: r["c"] for r in
              base.order_by().values("age_range").annotate(c=Count("id"))}
    by_emotion = {r["dominant_emotion"]: r["c"] for r in
                  base.order_by().values("dominant_emotion").annotate(c=Count("id"))}

    total = base.count()
    smile = base.filter(is_smiling=True).count()

    # 已领码（即 face matched 到 visit 且 visit 串到 RedeemCode）的人数
    claimed = base.filter(matched_visit__claimed_codes__isnull=False).distinct().count()

    return Response({
        "total_faces": total,
        "claimed_faces": claimed,
        "smile_count": smile,
        "smile_ratio": round(smile / total * 100, 2) if total else 0,
        "by_gender": by_gender,
        "by_age_range": by_age,
        "by_emotion": by_emotion,
    })


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def export_leads_csv(request, project_id):
    """
    GET /api/projects/{id}/leads/export/
    导出获客列表 CSV（含画像列），过滤参数与 project_leads 完全一致
    2026-05-26 新增：form_data 导出也做可读化
    """
    import csv
    import io
    from django.http import HttpResponse

    project = get_object_or_404(Project, id=project_id)
    qs = (
        RedeemCode.objects
        .filter(project=project)
        .select_related("claim_visit__face_observation",
                        "claim_visit__machine",
                        "used_on_machine")
        .order_by("-created_at")
    )

    # 复用筛选逻辑
    for f, field in [
        ("status", "status"),
        ("gender", "claim_visit__face_observation__gender"),
        ("age_range", "claim_visit__face_observation__age_range"),
        ("emotion", "claim_visit__face_observation__dominant_emotion"),
    ]:
        val = request.query_params.get(f)
        if val:
            qs = qs.filter(**{field: val})

    since = request.query_params.get("since")
    if since:
        from django.utils.dateparse import parse_date
        d = parse_date(since)
        if d:
            qs = qs.filter(created_at__date__gte=d)

    search = (request.query_params.get("search") or "").strip()
    if search:
        from django.db.models import Q
        qs = qs.filter(Q(user_nickname__icontains=search) | Q(code__icontains=search))

    # 构建字段映射
    key_map, option_map, field_order = _build_field_map(project)

    buf = io.StringIO()
    buf.write("﻿")  # UTF-8 BOM
    w = csv.writer(buf)
    w.writerow([
        "领码时间", "兑换码", "状态", "称呼", "手机/openid",
        "扫码设备", "已使用设备", "已使用货道", "使用时间",
        "性别", "年龄", "年龄段", "情绪", "是否微笑", "观测时间",
        "表单数据",
    ])
    for c in qs:
        visit = getattr(c, "claim_visit", None)
        obs = getattr(visit, "face_observation", None) if visit else None

        # 可读化 form_data
        fd_items = _humanize_form_data(c.form_data, key_map, option_map, field_order)
        fd_str = "; ".join(f"{item['label']}: {item['value']}" for item in fd_items)

        w.writerow([
            c.created_at.strftime("%Y-%m-%d %H:%M:%S") if c.created_at else "",
            c.code,
            c.get_status_display(),
            c.user_nickname or "",
            c.user_openid or "",
            (visit.machine.machine_id if visit and visit.machine else ""),
            (c.used_on_machine.machine_id if c.used_on_machine else ""),
            c.used_on_channel_code or "",
            c.used_at.strftime("%Y-%m-%d %H:%M:%S") if c.used_at else "",
            obs.get_gender_display() if obs else "",
            obs.age if (obs and obs.age) else "",
            obs.get_age_range_display() if obs else "",
            obs.get_dominant_emotion_display() if obs else "",
            ("是" if obs and obs.is_smiling else "") if obs else "",
            obs.observed_at.strftime("%Y-%m-%d %H:%M:%S") if obs else "",
            fd_str,
        ])

    today = timezone.now().strftime("%Y-%m-%d")
    resp = HttpResponse(buf.getvalue(), content_type="text/csv; charset=utf-8")
    resp["Content-Disposition"] = f'attachment; filename="leads-{project.id}-{today}.csv"'
    return resp


@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def delete_leads(request, project_id):
    """
    DELETE /api/projects/{id}/leads/delete/
    Body: {"ids": [1, 2, 3]}
    删除指定 RedeemCode（仅删除当前项目下的记录）
    """
    project = get_object_or_404(Project, id=project_id)
    ids = request.data.get("ids", [])
    if not ids or not isinstance(ids, list):
        return Response({"error": "请提供 ids 列表"}, status=400)

    deleted_count = RedeemCode.objects.filter(project=project, id__in=ids).delete()[0]
    return Response({"deleted": deleted_count})
