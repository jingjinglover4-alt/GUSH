from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('devices', '0004_add_wifi_fields_to_machine'),
    ]

    operations = [
        migrations.AddField(
            model_name='machine',
            name='dispense_strategy',
            field=models.CharField(choices=[('sequential', '顺序出货'), ('random', '随机出货')], default='sequential', max_length=16, verbose_name='出货逻辑'),
        ),
    ]
