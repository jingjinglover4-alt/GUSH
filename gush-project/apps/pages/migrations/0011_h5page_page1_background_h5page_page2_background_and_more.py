"""Add page background JSONFields to H5Page"""
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("pages", "0010_ledpage_data_migrate_blocks"),
    ]

    operations = [
        migrations.AddField(
            model_name="h5page",
            name="page1_background",
            field=models.JSONField(blank=True, default=dict, verbose_name="Page 1 背景"),
        ),
        migrations.AddField(
            model_name="h5page",
            name="page2_background",
            field=models.JSONField(blank=True, default=dict, verbose_name="Page 2 背景"),
        ),
        migrations.AddField(
            model_name="h5page",
            name="page3_background",
            field=models.JSONField(blank=True, default=dict, verbose_name="Page 3 背景"),
        ),
    ]
