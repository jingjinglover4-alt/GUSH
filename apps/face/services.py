"""
画像与访问的时间窗匹配
"""
from datetime import timedelta
from django.utils import timezone

# 默认匹配窗口（秒）：观测时间 ± WINDOW 范围内的同机器 visit
DEFAULT_WINDOW_SECONDS = 60


def match_observation_to_visit(observation, window_seconds=DEFAULT_WINDOW_SECONDS):
    """
    在 FaceObservation 创建后调用：
    在 [observed_at - W, observed_at + W] 范围内找同机器最近的 PageVisitLog，
    且该 visit 还没被任何观测关联，则双向关联。
    返回匹配上的 visit 或 None。
    """
    from apps.pages.models import PageVisitLog

    if observation.matched_visit_id:
        return observation.matched_visit  # 已匹配

    delta = timedelta(seconds=window_seconds)
    start = observation.observed_at - delta
    end = observation.observed_at + delta

    candidate = (
        PageVisitLog.objects
        .filter(
            machine=observation.machine,
            visited_at__gte=start, visited_at__lte=end,
            face_observation__isnull=True,  # 还没被关联
        )
        .order_by("visited_at")  # 时间最近的策略改成「先到先关联」更稳
        .first()
    )
    if not candidate:
        return None

    # 选 visited_at 与 observed_at 时间差最小的
    nearest = min(
        PageVisitLog.objects.filter(
            machine=observation.machine,
            visited_at__gte=start, visited_at__lte=end,
            face_observation__isnull=True,
        ),
        key=lambda v: abs((v.visited_at - observation.observed_at).total_seconds()),
        default=None,
    )
    if not nearest:
        return None

    observation.matched_visit = nearest
    observation.save(update_fields=["matched_visit"])
    return nearest


def match_visit_to_observation(visit, window_seconds=DEFAULT_WINDOW_SECONDS):
    """
    反向匹配：visit 落库时尝试找最近的未匹配观测。
    在表单提交那一刻调用 → 此时摄像头观测可能还没传到（人还在镜头前）。
    所以这条路只是兜底，主要还是靠 observation 那边推 match。
    """
    from .models import FaceObservation

    if hasattr(visit, "face_observation") and visit.face_observation:
        return visit.face_observation

    delta = timedelta(seconds=window_seconds)
    start = visit.visited_at - delta
    end = visit.visited_at + delta

    nearest = (
        FaceObservation.objects
        .filter(
            machine=visit.machine,
            observed_at__gte=start, observed_at__lte=end,
            matched_visit__isnull=True,
        )
        .order_by("observed_at")
    )
    nearest = min(
        nearest,
        key=lambda o: abs((o.observed_at - visit.visited_at).total_seconds()),
        default=None,
    )
    if not nearest:
        return None
    nearest.matched_visit = visit
    nearest.save(update_fields=["matched_visit"])
    return nearest
