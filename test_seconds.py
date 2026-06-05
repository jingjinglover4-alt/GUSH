import json
from urllib import request as urlreq
from apps.projects.models import Project, RedeemCode
from apps.devices.models import Machine
from django.utils import timezone
import datetime

m = Machine.objects.get(machine_id="MACHINE001")
p = Project.objects.get(id=2)

# 改 project 的 code_validity_seconds 为 90s 做测试
p.code_validity_seconds = 90
p.save(update_fields=["code_validity_seconds"])
print(f"project {p.id} code_validity_seconds = {p.code_validity_seconds}")

# 删旧测试
for c in ["777111", "777222"]:
    RedeemCode.objects.filter(code=c).delete()

def post(url, data):
    req = urlreq.Request(url, data=json.dumps(data, ensure_ascii=False).encode("utf-8"),
                         headers={"Content-Type":"application/json"})
    try:
        with urlreq.urlopen(req, timeout=10) as r:
            return r.status, r.read().decode()
    except Exception as e:
        return 0, str(e)

VISIT = "https://machine001.gush.cdgushai.com/api/public/visit/"
CLAIM = "https://machine001.gush.cdgushai.com/api/public/claim/"

# 领码
s, b = post(VISIT, {"page_type":"h5", "project_id":2, "machine_id":"MACHINE001", "device_fp":"fp_test_seconds"})
v = json.loads(b)
s, b = post(CLAIM, {"project_id":2, "machine_id":"MACHINE001", "form":{"openid":"","name":"t"}, "visit_id":v["visit_id"]})
print("claim:", s, b)
new = RedeemCode.objects.filter(code=b.split(code:')[1].split(')[0]).first() if s == 200 else None
if new:
    delta = (new.expires_at - timezone.now()).total_seconds()
    print(f"expires_at delta from now: {delta:.1f} seconds (expect ~90)")

# 测试 admin 校验：尝试设 50 秒
print()
print("=== Test admin validator: try setting to 50 (below min 60) ===")
p.code_validity_seconds = 50
try:
    p.save(update_fields=["code_validity_seconds"])
    p.full_clean()  # 触发 validators
    print("ERROR: validation should have failed but passed")
except Exception as e:
    print("OK, rejected:", str(e)[:200])

# 600 OK
print()
print("=== Test 600 (max) ===")
p.code_validity_seconds = 600
try:
    p.full_clean()
    print("OK, 600 passed")
except Exception as e:
    print("ERROR:", str(e)[:200])

# 700 不行
print()
print("=== Test 700 (above max 600) ===")
p.code_validity_seconds = 700
try:
    p.full_clean()
    print("ERROR: should reject")
except Exception as e:
    print("OK, rejected:", str(e)[:200])

# 恢复默认 60
p.code_validity_seconds = 60
p.save(update_fields=["code_validity_seconds"])
print()
print("project reset to code_validity_seconds = 60")
