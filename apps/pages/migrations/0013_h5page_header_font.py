from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pages', '0012_h5page_button_text'),
    ]

    operations = [
        migrations.AddField(
            model_name='h5page',
            name='header_font_color',
            field=models.CharField(blank=True, default='#FFFFFF', max_length=16, verbose_name='头部字体颜色'),
        ),
        migrations.AddField(
            model_name='h5page',
            name='header_font_size',
            field=models.CharField(blank=True, default='26', max_length=16, verbose_name='头部字体大小'),
        ),
    ]
