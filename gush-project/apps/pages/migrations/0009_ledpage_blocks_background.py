# Generated manually: add page1_blocks, page2_blocks, page1_background, page2_background to LedPage
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("pages", "0008_devicepageoverride_active_project"),
    ]

    operations = [
        migrations.AddField(
            model_name="ledpage",
            name="page1_blocks",
            field=models.JSONField(blank=True, default=list, verbose_name="Page 1 区块"),
        ),
        migrations.AddField(
            model_name="ledpage",
            name="page2_blocks",
            field=models.JSONField(blank=True, default=list, verbose_name="Page 2 区块"),
        ),
        migrations.AddField(
            model_name="ledpage",
            name="page1_background",
            field=models.JSONField(blank=True, default=dict, verbose_name="Page 1 背景"),
        ),
        migrations.AddField(
            model_name="ledpage",
            name="page2_background",
            field=models.JSONField(blank=True, default=dict, verbose_name="Page 2 背景"),
        ),
    ]
