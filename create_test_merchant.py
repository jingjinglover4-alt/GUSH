#!/usr/bin/env python3
"""
创建测试商户数据
在服务器上运行此脚本插入测试商户账号和相关数据
"""

import sys
import os
from datetime import datetime, timedelta
import hashlib
import random
import string

# 添加当前目录到Python路径
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# 导入Flask应用和模型
try:
    from app import app, db
    from app import Admin, Customer, Machine, RedeemCode, UserRecord, Stats
    print("✅ 成功导入应用模型")
except ImportError as e:
    print(f"❌ 导入失败: {e}")
    print("请确保在项目根目录运行此脚本")
    sys.exit(1)

def create_test_customers():
    """创建测试客户数据"""
    with app.app_context():
        # 检查是否已存在测试客户
        existing_customers = Customer.query.filter(Customer.name.like('%测试%')).all()
        if existing_customers:
            print(f"⚠️  已存在 {len(existing_customers)} 个测试客户，跳过创建")
            return existing_customers[0].id if existing_customers else None
        
        # 创建测试客户
        test_customer = Customer(
            name="测试商户有限公司",
            logo_url="https://example.com/logo.png",
            bg_image_url="https://example.com/bg.jpg",
            qrcode_url="https://example.com/qrcode.png",
            slogan="测试商户，品质保证",
            app_name="测试商户派样机",
            created_at=datetime.now()
        )
        
        db.session.add(test_customer)
        db.session.commit()
        print(f"✅ 创建测试客户: {test_customer.name} (ID: {test_customer.id})")
        
        # 创建第二个测试客户
        test_customer2 = Customer(
            name="演示商户科技有限公司",
            logo_url="https://example.com/demo-logo.png",
            bg_image_url="https://example.com/demo-bg.jpg",
            qrcode_url="https://example.com/demo-qrcode.png",
            slogan="科技派样，智能体验",
            app_name="演示商户派样机",
            created_at=datetime.now()
        )
        
        db.session.add(test_customer2)
        db.session.commit()
        print(f"✅ 创建第二个测试客户: {test_customer2.name} (ID: {test_customer2.id})")
        
        return test_customer.id

def create_test_admins(customer_id):
    """创建测试管理员账号"""
    with app.app_context():
        # 检查默认管理员是否存在
        default_admin = Admin.query.filter_by(username='admin').first()
        if not default_admin:
            # 创建默认超级管理员
            default_admin = Admin(
                username='admin',
                role='admin',
                customer_id=None,
                created_at=datetime.now()
            )
            default_admin.set_password('123456')
            db.session.add(default_admin)
            print("✅ 创建默认超级管理员: admin / 123456")
        
        # 检查测试商户管理员是否存在
        test_merchant = Admin.query.filter_by(username='merchant1').first()
        if not test_merchant:
            # 创建测试商户管理员
            test_merchant = Admin(
                username='merchant1',
                role='customer',
                customer_id=customer_id,
                created_at=datetime.now()
            )
            test_merchant.set_password('merchant123')
            db.session.add(test_merchant)
            print(f"✅ 创建测试商户管理员: merchant1 / merchant123 (客户ID: {customer_id})")
        
        # 创建第二个商户管理员
        test_merchant2 = Admin.query.filter_by(username='demo_merchant').first()
        if not test_merchant2:
            # 获取第二个客户
            demo_customer = Customer.query.filter_by(name="演示商户科技有限公司").first()
            if demo_customer:
                test_merchant2 = Admin(
                    username='demo_merchant',
                    role='customer',
                    customer_id=demo_customer.id,
                    created_at=datetime.now()
                )
                test_merchant2.set_password('demo123')
                db.session.add(test_merchant2)
                print(f"✅ 创建演示商户管理员: demo_merchant / demo123 (客户ID: {demo_customer.id})")
        
        db.session.commit()
        return True

def create_test_machines(customer_id):
    """创建测试机器数据"""
    with app.app_context():
        # 检查是否已存在测试机器
        existing_machines = Machine.query.filter_by(customer_id=customer_id).all()
        if existing_machines:
            print(f"⚠️  客户 {customer_id} 已存在 {len(existing_machines)} 台机器，跳过创建")
            return
        
        # 创建3台测试机器
        locations = ["北京朝阳区", "上海浦东新区", "广州天河区"]
        for i in range(1, 4):
            machine = Machine(
                machine_code=f"TEST-MACHINE-{customer_id:03d}-{i:02d}",
                name=f"测试派样机{i}号",
                location=locations[i-1],
                customer_id=customer_id,
                status='online',
                last_heartbeat=datetime.now() - timedelta(minutes=random.randint(1, 60)),
                created_at=datetime.now() - timedelta(days=random.randint(1, 30))
            )
            db.session.add(machine)
            print(f"✅ 创建测试机器: {machine.name} ({machine.machine_code})")
        
        db.session.commit()

def create_test_redeem_codes(customer_id):
    """创建测试兑换码数据"""
    with app.app_context():
        # 生成一些测试兑换码
        today = datetime.now().date()
        
        # 检查今天是否已生成过测试兑换码
        existing_today = RedeemCode.query.filter(
            RedeemCode.customer_id == customer_id,
            RedeemCode.created_at >= datetime.combine(today, datetime.min.time())
        ).count()
        
        if existing_today > 5:
            print(f"⚠️  今天已生成 {existing_today} 个兑换码，跳过创建")
            return
        
        # 生成新的测试兑换码
        for i in range(10):
            code = ''.join(random.choices(string.digits, k=6))
            redeem_code = RedeemCode(
                code=code,
                customer_id=customer_id,
                status='unused',
                created_at=datetime.now() - timedelta(hours=random.randint(0, 24)),
                expired_at=datetime.now() + timedelta(hours=2)
            )
            db.session.add(redeem_code)
        
        # 生成一些已使用的兑换码
        for i in range(5):
            code = ''.join(random.choices(string.digits, k=6))
            redeem_code = RedeemCode(
                code=code,
                customer_id=customer_id,
                status='used',
                created_at=datetime.now() - timedelta(days=random.randint(1, 7)),
                used_at=datetime.now() - timedelta(hours=random.randint(1, 24)),
                expired_at=datetime.now() - timedelta(hours=1)
            )
            db.session.add(redeem_code)
        
        db.session.commit()
        print(f"✅ 为客户 {customer_id} 创建15个测试兑换码 (10个未使用，5个已使用)")

def create_test_stats(customer_id):
    """创建测试统计数据"""
    with app.app_context():
        # 创建最近7天的统计数据
        for i in range(7):
            date = datetime.now().date() - timedelta(days=i)
            
            # 检查是否已存在当天的统计
            existing_stat = Stats.query.filter_by(customer_id=customer_id, date=date).first()
            if existing_stat:
                continue
            
            stat = Stats(
                customer_id=customer_id,
                date=date,
                scan_count=random.randint(50, 200),
                claim_count=random.randint(30, 150),
                redeem_count=random.randint(20, 100)
            )
            db.session.add(stat)
            print(f"✅ 创建统计: {date} 扫码{stat.scan_count}次")
        
        db.session.commit()

def main():
    """主函数"""
    print("=" * 60)
    print("🛠️  创建HI拿管理系统测试数据")
    print("=" * 60)
    
    # 初始化应用上下文
    with app.app_context():
        # 创建所有表（如果不存在）
        db.create_all()
        print("✅ 数据库表已就绪")
        
        # 1. 创建测试客户
        customer_id = create_test_customers()
        if not customer_id:
            print("❌ 创建测试客户失败")
            return
        
        # 2. 创建测试管理员账号
        if not create_test_admins(customer_id):
            print("❌ 创建测试管理员失败")
            return
        
        # 3. 创建测试机器
        create_test_machines(customer_id)
        
        # 4. 创建第二个客户的机器
        demo_customer = Customer.query.filter_by(name="演示商户科技有限公司").first()
        if demo_customer:
            create_test_machines(demo_customer.id)
        
        # 5. 创建测试兑换码
        create_test_redeem_codes(customer_id)
        if demo_customer:
            create_test_redeem_codes(demo_customer.id)
        
        # 6. 创建测试统计数据
        create_test_stats(customer_id)
        if demo_customer:
            create_test_stats(demo_customer.id)
        
        print("=" * 60)
        print("🎉 测试数据创建完成！")
        print("=" * 60)
        print("\n📋 可用测试账号:")
        print("  1. 超级管理员: admin / 123456")
        print("  2. 测试商户: merchant1 / merchant123")
        print("  3. 演示商户: demo_merchant / demo123")
        print("\n💡 提示:")
        print("  - 商户账号登录时选择 '🏪 SaaS商户' 标签")
        print("  - 超级管理员登录时选择 '🏢 超级管理员' 标签")
        print("  - 商户只能看到自己客户的数据")
        print("=" * 60)

if __name__ == "__main__":
    main()