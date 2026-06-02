"""Add page1_button_text and page2_button_text to H5Page"""
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("pages", "0011_h5page_page1_background_h5page_page2_background_and_more"),
    ]

    operations = [
        migrations.AddField(
            model_name="h5page",
            name="page1_button_text",
            field=models.CharField(
                default="下一步",
                max_length=32,
                verbose_name="Page 1 跳转按钮",
            ),
        ),
        migrations.AddField(
            model_name="h5page",
            name="page2_button_text",
            field=models.CharField(
                default="立即领取",
                max_length=32,
                verbose_name="Page 2 跳转按钮",
            ),
        ),
    ]
