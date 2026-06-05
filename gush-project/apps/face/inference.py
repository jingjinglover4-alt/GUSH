"""
人脸推理 - 可插拔接口

唯一对外契约：
    infer(image_path: str | Path) -> dict
返回结构：
{
    "gender": "male" | "female" | "unknown",
    "gender_confidence": 0.0-1.0,
    "age": int | None,
    "dominant_emotion": "happy" | ... | "unknown",
    "emotion_scores": {"happy": 87.2, "neutral": 10.1, ...},  # 各 0-100
    "is_smiling": bool,
    "meta": {
        "model": "...",
        "latency_ms": float,
        "face_count": int,
    }
}

==========================================
未来切到真实推理：只改本文件 _infer_real()
==========================================

DeepFace 集成示例（pip install deepface）：

    from deepface import DeepFace

    def _infer_real(image_path):
        result = DeepFace.analyze(
            img_path=str(image_path),
            actions=['age', 'gender', 'emotion'],
            enforce_detection=False,
        )
        r = result[0] if isinstance(result, list) else result
        gender_label = (r.get('dominant_gender') or '').lower()
        emotion_scores = r.get('emotion') or {}
        return {
            "gender": {"man": "male", "woman": "female"}.get(gender_label, "unknown"),
            "gender_confidence": (r.get('gender') or {}).get(gender_label.title(), 0) / 100,
            "age": int(r.get('age', 0)) or None,
            "dominant_emotion": r.get('dominant_emotion', 'unknown'),
            "emotion_scores": {k: float(v) for k, v in emotion_scores.items()},
            "is_smiling": (emotion_scores.get('happy', 0) > 50),
            "meta": {"model": "DeepFace/VGG-Face", "face_count": 1},
        }

切换：把下面 BACKEND = "stub" 改成 "deepface"。
"""
import os
import random
import time
from pathlib import Path

BACKEND = os.environ.get("FACE_INFER_BACKEND", "stub")  # stub | deepface


def infer(image_path) -> dict:
    """对外统一入口；按 BACKEND 分发"""
    if BACKEND == "deepface":
        return _infer_deepface(image_path)
    return _infer_stub(image_path)


# ============================================================
# Stub：用于开发/测试，返回合理随机画像
# ============================================================
_AGE_RANGES = [
    (20, 35),  # young adult 偏多
    (20, 35),
    (20, 35),
    (15, 22),
    (28, 50),
    (50, 70),
]
_EMOTIONS = ["happy", "neutral", "neutral", "neutral", "surprised", "sad"]


def _infer_stub(image_path):
    """Stub 推理：基于图片大小做一个稳定的随机种子，避免同图每次结果不同"""
    p = Path(image_path)
    seed = p.stat().st_size if p.exists() else random.randint(0, 1 << 32)
    rng = random.Random(seed)

    t0 = time.perf_counter()
    gender = rng.choice(["male", "male", "female", "female", "female"])
    age_lo, age_hi = rng.choice(_AGE_RANGES)
    age = rng.randint(age_lo, age_hi)
    dominant = rng.choice(_EMOTIONS)

    # 7 种情绪打分，dominant 的分最高
    emotion_scores = {e: round(rng.uniform(2, 12), 1)
                      for e in ["happy", "neutral", "surprised", "sad",
                                "angry", "disgusted", "fear"]}
    emotion_scores[dominant] = round(rng.uniform(55, 92), 1)
    total = sum(emotion_scores.values())
    emotion_scores = {k: round(v * 100 / total, 1) for k, v in emotion_scores.items()}

    latency_ms = round((time.perf_counter() - t0) * 1000, 2)
    return {
        "gender": gender,
        "gender_confidence": round(rng.uniform(0.7, 0.98), 3),
        "age": age,
        "dominant_emotion": dominant,
        "emotion_scores": emotion_scores,
        "is_smiling": emotion_scores["happy"] > 40,
        "meta": {
            "model": "stub-v1",
            "latency_ms": latency_ms,
            "face_count": 1,
            "image_size": seed,
        },
    }


# ============================================================
# DeepFace（未启用；安装后取消注释 + 改 BACKEND=deepface 即可）
# ============================================================

def _infer_deepface(image_path):
    """
    集成步骤：
    1. 把 deepface 加进 requirements.txt 并 docker compose build backend
    2. 取消下面注释
    3. 把 BACKEND 默认值改成 "deepface"（或 env 控制）
    """
    raise NotImplementedError(
        "DeepFace 后端未启用。请按 inference.py 文件头部注释集成后再切换 BACKEND。"
    )
    # from deepface import DeepFace
    # t0 = time.perf_counter()
    # result = DeepFace.analyze(
    #     img_path=str(image_path),
    #     actions=['age', 'gender', 'emotion'],
    #     enforce_detection=False,
    # )
    # r = result[0] if isinstance(result, list) else result
    # gender_label = (r.get('dominant_gender') or '').lower()
    # emotion_scores = r.get('emotion') or {}
    # latency_ms = round((time.perf_counter() - t0) * 1000, 2)
    # return {
    #     "gender": {"man": "male", "woman": "female"}.get(gender_label, "unknown"),
    #     "gender_confidence": (r.get('gender') or {}).get(gender_label.title(), 0) / 100,
    #     "age": int(r.get('age', 0)) or None,
    #     "dominant_emotion": r.get('dominant_emotion', 'unknown'),
    #     "emotion_scores": {k: float(v) for k, v in emotion_scores.items()},
    #     "is_smiling": (emotion_scores.get('happy', 0) > 50),
    #     "meta": {
    #         "model": "DeepFace/VGG-Face",
    #         "latency_ms": latency_ms,
    #         "face_count": 1,
    #     },
    # }


# ============================================================
# 辅助：年龄 → 年龄段
# ============================================================
def age_to_range(age) -> str:
    if age is None:
        return "unknown"
    if age <= 12:
        return "child"
    if age <= 17:
        return "teen"
    if age <= 30:
        return "young_adult"
    if age <= 50:
        return "adult"
    return "senior"
