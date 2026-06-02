"""
快速生成画像演示数据：
  docker compose exec backend python scripts/seed_face_demo.py
功能：
- 给 MACHINE001 + 项目 #3 生成 30 条 visit + 25 条 face observation（约 80% 匹配上）
- 其中 18 条领码（带画像）
"""
import os
import sys
import django
import random
from datetime import timedelta

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "gush.settings")
django.setup()

from django.utils import timezone
from apps.devices.models import Machine
from apps.face.models import FaceObservation
from apps.face.services import match_observation_to_visit
from apps.pages.models import PageVisitLog
from apps.projects.models import Project, RedeemCode


def main():
    machine = Machine.objects.filter(machine_id="MACHINE001").first()
    if not machine:
        print("❌ 没找到 MACHINE001"); return
    project = Project.objects.filter(name="五一新品试用").first() or Project.objects.first()
    if not project:
        print("❌ 没找到项目"); return
    print(f"machine={machine.machine_id}, project={project.id} {project.name}")

    now = timezone.now()
    # 清掉过去 2 小时的演示数据（device_fp 以 demo- 开头）
    PageVisitLog.objects.filter(
        machine=machine, device_fp__startswith="demo-",
        visited_at__gte=now - timedelta(hours=2),
    ).delete()
    FaceObservation.objects.filter(
        machine=machine, source="demo",
        observed_at__gte=now - timedelta(hours=2),
    ).delete()

    GENDERS = ["male"] * 4 + ["female"] * 6  # 偏向女性
    AGES = [(15, 22), (20, 35), (20, 35), (20, 35), (35, 50), (50, 65)]
    EMOTIONS = ["happy"] * 5 + ["neutral"] * 4 + ["surprised", "sad"]

    EMO_LABEL_MAP = {
        "happy": "happy", "neutral": "neutral", "surprised": "surprised",
        "sad": "sad", "angry": "angry",
    }

    visits = []
    print("生成 30 条 visit...")
    for i in range(30):
        t = now - timedelta(minutes=random.randint(1, 120))
        v = PageVisitLog.objects.create(
            page_type="h5",
            project=project,
            machine=machine,
            device_fp=f"demo-fp-{i}",
            user_agent="demo-script",
            visited_at=t,
        )
        v.visited_at = t  # auto_now_add 不会理 — 手动 update
        PageVisitLog.objects.filter(id=v.id).update(visited_at=t)
        v.refresh_from_db()
        visits.append(v)

    print("生成 25 条 face observation（含部分对齐 visit 时间） ...")
    obs_count = 0
    matched = 0
    for v in random.sample(visits, 25):
        # 画像观测时间偏离 visit 0-20 秒（模拟摄像头在用户扫码前后捕捉）
        delta = random.randint(-15, 10)
        obs_at = v.visited_at + timedelta(seconds=delta)
        age_lo, age_hi = random.choice(AGES)
        age = random.randint(age_lo, age_hi)
        dom = random.choice(EMOTIONS)
        emo_scores = {e: round(random.uniform(2, 12), 1) for e in
                      ["happy", "neutral", "surprised", "sad",
                       "angry", "disgusted", "fear"]}
        emo_scores[dom] = round(random.uniform(55, 90), 1)
        obs = FaceObservation.objects.create(
            machine=machine,
            observed_at=obs_at,
            gender=random.choice(GENDERS),
            gender_confidence=round(random.uniform(0.75, 0.97), 3),
            age=age,
            age_range=(
                "child" if age <= 12 else "teen" if age <= 17 else
                "young_adult" if age <= 30 else "adult" if age <= 50 else "senior"
            ),
            dominant_emotion=dom,
            emotion_scores=emo_scores,
            is_smiling=emo_scores["happy"] > 40,
            source="demo",
            inference_meta={"model": "demo-seed"},
        )
        obs_count += 1
        if match_observation_to_visit(obs):
            matched += 1

    print(f"✓ 生成 visit={len(visits)}, face={obs_count}, matched={matched}")

    # 让其中 18 个 visit 走完领码流程
    eligible = list(PageVisitLog.objects.filter(
        machine=machine, device_fp__startswith="demo-",
        face_observation__isnull=False,
    ))
    n_claim = min(18, len(eligible))
    print(f"生成 {n_claim} 条 claim（每条 visit 一条 RedeemCode）...")
    from secrets import choice as schoice
    import string
    DIGITS = string.digits
    expires = now + timedelta(days=30)
    for v in random.sample(eligible, n_claim):
        # 生成唯一码
        for _ in range(5):
            code = "".join(schoice(DIGITS) for _ in range(project.code_length))
            if not RedeemCode.objects.filter(code=code).exists():
                RedeemCode.objects.create(
                    project=project, code=code,
                    expires_at=expires,
                    user_nickname=random.choice([
                        "小红", "小李", "王女士", "张先生", "Anna",
                        "测试用户", "李四", "小张", "周先生", "陈女士",
                    ]),
                    user_openid=f"openid-{v.device_fp}",
                    claim_visit=v,
                )
                break
    print("✓ 完成。")
    print(f"   总人脸: {FaceObservation.objects.filter(machine=machine).count()}")
    print(f"   已领码: {RedeemCode.objects.filter(project=project, claim_visit__isnull=False).count()}")


if __name__ == "__main__":
    main()
