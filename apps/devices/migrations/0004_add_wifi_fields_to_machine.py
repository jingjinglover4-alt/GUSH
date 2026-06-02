# Generated manually - add Wi-Fi credential fields to Machine
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("devices", "0003_add_network_plan"),
    ]

    operations = [
        migrations.AddField(
            model_name="machine",
            name="wifi_ssid",
            field=models.CharField(
                blank=True, default="", max_length=64,
                verbose_name="Wi-Fi名称",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="wifi_password",
            field=models.CharField(
                blank=True, default="", max_length=128,
                verbose_name="Wi-Fi密码",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="wifi_login_ip",
            field=models.CharField(
                blank=True, default="", max_length=64,
                verbose_name="登陆IP",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="wifi_login_username",
            field=models.CharField(
                blank=True, default="", max_length=64,
                verbose_name="Wi-Fi设备登陆用户名",
            ),
        ),
        migrations.AddField(
            model_name="machine",
            name="wifi_login_password",
            field=models.CharField(
                blank=True, default="", max_length=128,
                verbose_name="Wi-Fi设备登陆密码",
            ),
        ),
    ]
