"""
人脸画像 - 公开接口（设备侧调用，不需要登录）
"""
import os
import tempfile
import logging

from django.utils import timezone
from django.utils.dateparse import parse_datetime
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from apps.devices.models import Machine

from .inference import age_to_range, infer
from .models import FaceObservation
from .services import match_observation_to_visit

logger = logging.getLogger(__name__)


def _resolve_machine(request, body):
    """优先用子域名解析的 machine（Phase 1.7 中间件），否则用 body / query 里的 machine_id"""
    machine = getattr(request, "device_machine", None)
    if machine:
        return machine
    mid = (body.get("machine_id") if body else None) or request.GET.get("machine_id") or ""
    if not mid:
        return None
    return Machine.objects.filter(machine_id=mid).first()


def _auth_machine(machine, request, body):
    """简单鉴权：machine.comm_secret 与上报一致"""
    if not machine:
        return False
    secret = ""
    if body:
        secret = body.get("secret") or ""
    if not secret:
        secret = request.GET.get("secret") or ""
    return bool(secret) and secret == machine.comm_secret


@csrf_exempt
@api_view(["POST"])
@authentication_classes([])
@permission_classes([AllowAny])
def upload_face_image(request):
    """
    POST /api/public/face/upload/
    Qt 端检测到有人时上传抓拍图，服务端跑推理后立即删除图片
    multipart/form-data:
        image: <file>
        machine_id: str
        secret: str
        observed_at: ISO8601（可选，缺省取服务器接收时间）
    """
    image_file = request.FILES.get("image")
    if not image_file:
        return Response({"detail": "缺少 image 字段"}, status=400)

    body = request.POST  # multipart 走 POST 而不是 data
    machine = _resolve_machine(request, body)
    if not machine:
        return Response({"detail": "未识别设备"}, status=404)
    if not _auth_machine(machine, request, body):
        return Response({"detail": "secret 鉴权失败"}, status=403)

    observed_at_raw = body.get("observed_at") or ""
    observed_at = parse_datetime(observed_at_raw) if observed_at_raw else None
    if not observed_at:
        observed_at = timezone.now()

    # 写到临时文件 → 推理 → 立即删
    tmp_fd, tmp_path = tempfile.mkstemp(suffix=".jpg", prefix="face_")
    try:
        with os.fdopen(tmp_fd, "wb") as tf:
            for chunk in image_file.chunks():
                tf.write(chunk)
        try:
            result = infer(tmp_path)
        except Exception as e:
            logger.exception("人脸推理失败")
            return Response({"detail": f"推理失败: {e}"}, status=500)
    finally:
        try:
            os.unlink(tmp_path)
        except OSError:
            pass

    obs = FaceObservation.objects.create(
        machine=machine,
        observed_at=observed_at,
        gender=result.get("gender") or FaceObservation.Gender.UNKNOWN,
        gender_confidence=result.get("gender_confidence") or 0.0,
        age=result.get("age"),
        age_range=age_to_range(result.get("age")),
        dominant_emotion=result.get("dominant_emotion") or FaceObservation.Emotion.UNKNOWN,
        emotion_scores=result.get("emotion_scores") or {},
        is_smiling=bool(result.get("is_smiling")),
        source="image_upload",
        inference_meta=result.get("meta") or {},
    )
    match_observation_to_visit(obs)

    return Response({
        "id": obs.id,
        "gender": obs.gender,
        "age": obs.age,
        "age_range": obs.age_range,
        "dominant_emotion": obs.dominant_emotion,
        "is_smiling": obs.is_smiling,
        "matched_visit_id": obs.matched_visit_id,
    })


@csrf_exempt
@api_view(["POST"])
@authentication_classes([])
@permission_classes([AllowAny])
def submit_face_observation(request):
    """
    POST /api/public/face/observation/
    Qt 端已在本地完成推理，直接上传 JSON 结果（不传图片，省带宽）
    body: {
        machine_id, secret, observed_at,
        gender, gender_confidence, age,
        dominant_emotion, emotion_scores, is_smiling, meta
    }
    """
    body = request.data or {}
    machine = _resolve_machine(request, body)
    if not machine:
        return Response({"detail": "未识别设备"}, status=404)
    if not _auth_machine(machine, request, body):
        return Response({"detail": "secret 鉴权失败"}, status=403)

    observed_at = parse_datetime(body.get("observed_at") or "") or timezone.now()
    age = body.get("age")
    try:
        age_val = int(age) if age is not None else None
    except (TypeError, ValueError):
        age_val = None

    obs = FaceObservation.objects.create(
        machine=machine,
        observed_at=observed_at,
        gender=(body.get("gender") or FaceObservation.Gender.UNKNOWN).lower(),
        gender_confidence=float(body.get("gender_confidence") or 0),
        age=age_val,
        age_range=age_to_range(age_val),
        dominant_emotion=(body.get("dominant_emotion") or FaceObservation.Emotion.UNKNOWN).lower(),
        emotion_scores=body.get("emotion_scores") or {},
        is_smiling=bool(body.get("is_smiling")),
        source="qt_inference",
        inference_meta=body.get("meta") or {},
    )
    match_observation_to_visit(obs)

    return Response({
        "id": obs.id,
        "matched_visit_id": obs.matched_visit_id,
    })
