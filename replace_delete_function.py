#!/usr/bin/env python3
import sys

file_path = "/opt/hinana-admin/apis.py"

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# 找到第二个api_delete_codes函数开始和结束
delete_start = -1
delete_end = -1

for i, line in enumerate(lines):
    if '@app.route("/admin/api/codes/delete", methods=["POST"])' in line:
        # 确保不是第一个函数（第一个函数有额外的装饰器）
        if i > 600:  # 第一个函数在633行左右
            delete_start = i
            break

if delete_start == -1:
    print("未找到删除函数")
    sys.exit(1)

# 找到函数结束（下一个def开始）
for i in range(delete_start + 1, len(lines)):
    if lines[i].strip().startswith('def ') and 'api_delete_codes' not in lines[i]:
        delete_end = i
        break

if delete_end == -1:
    delete_end = len(lines)

print(f"函数位置: {delete_start} 到 {delete_end}")

# 新函数内容
new_function = '''    @app.route("/admin/api/codes/delete", methods=["POST"])
    def api_delete_codes():
        """删除兑换码"""
        try:
            from flask import request, jsonify
            import sqlite3
            data = request.get_json()
            phone_numbers = data.get("phone_numbers") if data else None
            
            if not phone_numbers or not isinstance(phone_numbers, list):
                return jsonify({"success": False, "message": "缺少手机号参数或参数格式不正确"}), 400
            
            conn = sqlite3.connect("instance/hinana.db")
            cursor = conn.cursor()
            
            # 批量删除兑换码
            count = 0
            for phone in phone_numbers:
                cursor.execute("DELETE FROM redeem_codes WHERE phone = ?", (phone,))
                count += cursor.rowcount
            
            conn.commit()
            conn.close()
            return jsonify({"success": True, "message": f"删除成功，共删除{count}条记录"})
        except Exception as e:
            return jsonify({"success": False, "message": str(e)}), 500
'''

# 替换原函数
lines[delete_start:delete_end] = [new_function]

# 写回文件
with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(lines)

print("删除函数已更新")