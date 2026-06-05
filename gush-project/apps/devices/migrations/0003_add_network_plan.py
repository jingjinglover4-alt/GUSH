# Generated manually - add network plan fields to Machine
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("devices", "0002_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="machine",
            name="network_plan",
            field=models.CharField(
                blank=True, default="",
                choices=[("wifi", "WiFi"), ("4g", "4G")],
                max_length=8, verbose_name="网络制式",
                help_text="wifi / 4g",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="carrier",
            field=models.CharField(
                blank=True, default="", max_length=16,
                verbose_name="运营商",
                help_text="移动/联通/电信（4G 时填写）",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="iccid",
            field=models.CharField(
                blank=True, default="", max_length=32,
                verbose_name="SIM卡ICCID",
                help_text="4G SIM 卡号",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="data_limit_mb",
            field=models.IntegerField(
                null=True, blank=True,
                verbose_name="月流量上限(MB)",
                help_text="例如 10240 = 10GB",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="data_used_mb",
            field=models.IntegerField(
                null=True, blank=True, default=0,
                verbose_name="当月已用流量(MB)",
                help_text="本月累计流量",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="plan_fee",
            field=models.DecimalField(
                null=True, blank=True,
                max_digits=8, decimal_places=2,
                verbose_name="套餐月费(元)",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="plan_start_date",
            field=models.DateField(
                null=True, blank=True,
                verbose_name="套餐生效日",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="renewal_date",
            field=models.DateField(
                null=True, blank=True,
                verbose_name="续费日期",
                help_text="下次续费提醒",
            ),
        ),
    ]
