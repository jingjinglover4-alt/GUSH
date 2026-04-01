#!/usr/bin/env python3
import hashlib
import secrets

def generate_token(imei, sn, secret):
    """生成硬件令牌"""
    salt = secrets.token_hex(16)
    raw = f"{imei}:{sn}:{secret}:{salt}"
    token_hash = hashlib.sha256(raw.encode()).hexdigest()
    token = f"hw_{token_hash[:24]}"
    return token, salt

# 测试硬件信息
imei = "865709045268307"
sn = "MP0623472DF9B5F"
secret = "hardware-token-secret-2026"

token, salt = generate_token(imei, sn, secret)

print("硬件令牌生成示例:")
print(f"IMEI: {imei}")
print(f"SN: {sn}")
print(f"令牌: {token}")
print(f"Salt: {salt}")
print("\nSQL插入语句:")
print(f"INSERT INTO hardware_tokens (imei, serial_number, token_hash, salt, expires_at)")
print(f"VALUES ('{imei}', '{sn}', '{hashlib.sha256(f'{imei}:{sn}:{secret}:{salt}'.encode()).hexdigest()}', '{salt}', datetime('now', '+30 days'));")
