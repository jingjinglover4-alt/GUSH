"""
人脸画像 - 数据层

设计：
- 不存图片：图片只用于推理，落库前删除
- 不识别身份：仅性别 / 年龄 / 情绪三个脱敏标签
- 时间窗匹配：observed_at ± 30s 内同机器的 PageVisitLog 自动关联
- 双路径上报：POST 图片 → 服务器推理；或 POST JSON（Qt 端推理结果直传）
"""
from django.db import models


class FaceObservation(models.Model):
    """单次人脸观测（一个人靠近设备 ≈ 一条）"""

    class Gender(models.TextChoices):
        MALE = "male", "男"
        FEMALE = "female", "女"
        UNKNOWN = "unknown", "未知"

    class AgeRange(models.TextChoices):
        CHILD = "child", "儿童 (0-12)"
        TEEN = "teen", "青少年 (13-17)"
        YOUNG_ADULT = "young_adult", "青年 (18-30)"
        ADULT = "adult", "中年 (31-50)"
        SENIOR = "senior", "中老年 (51+)"
        UNKNOWN = "unknown", "未知"

    class Emotion(models.TextChoices):
        HAPPY = "happy", "开心"
        NEUTRAL = "neutral", "平静"
        SURPRISED = "surprised", "惊讶"
        SAD = "sad", "悲伤"
        ANGRY = "angry", "生气"
        DISGUSTED = "disgusted", "厌恶"
        FEAR = "fear", "害怕"
        UNKNOWN = "unknown", "未知"

    # ===== 关键字段 =====
    machine = models.ForeignKey(
        "devices.Machine", on_delete=models.CASCADE,
        related_name="face_observations",
        verbose_name="来源设备",
    )
    observed_at = models.DateTimeField("观测时间", db_index=True)

    # 性别
    gender = models.CharField("性别", max_length=16,
                              choices=Gender.choices, default=Gender.UNKNOWN, db_index=True)
    gender_confidence = models.FloatField("性别置信度", default=0.0)

    # 年龄
    age = models.IntegerField("估算年龄", null=True, blank=True)
    age_range = models.CharField("年龄段", max_length=16,
                                 choices=AgeRange.choices, default=AgeRange.UNKNOWN, db_index=True)

    # 情绪
    dominant_emotion = models.CharField("主导情绪", max_length=16,
                                        choices=Emotion.choices, default=Emotion.UNKNOWN, db_index=True)
    emotion_scores = models.JSONField("情绪打分明细", default=dict, blank=True,
                                      help_text="7 种情绪各自打分 0-100")
    is_smiling = models.BooleanField("是否微笑", default=False)

    # 元信息
    source = models.CharField("来源", max_length=16, default="image_upload",
                              help_text="image_upload=服务器推理 | qt_inference=Qt 端推理直传")
    inference_meta = models.JSONField("推理元数据", default=dict, blank=True,
                                      help_text="包含 model_version, latency_ms, face_bbox 等")

    # 关联（异步匹配后填充）
    matched_visit = models.OneToOneField(
        "pages.PageVisitLog", on_delete=models.SET_NULL,
        related_name="face_observation",
        null=True, blank=True,
        verbose_name="关联访问",
    )

    created_at = models.DateTimeField("入库时间", auto_now_add=True)

    class Meta:
        verbose_name = "人脸画像观测"
        verbose_name_plural = "人脸画像观测"
        db_table = "gush_face_observation"
        ordering = ["-observed_at"]
        indexes = [
            models.Index(fields=["machine", "-observed_at"]),
            models.Index(fields=["gender", "age_range"]),
        ]

    def __str__(self) -> str:
        return f"{self.machine.machine_id} {self.get_gender_display()} {self.age or '?'}岁 {self.get_dominant_emotion_display()} @ {self.observed_at:%H:%M}"
