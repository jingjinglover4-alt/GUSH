# Generated manually - add client_token to Project
from django.db import migrations, models


def generate_tokens(apps, schema_editor):
    import secrets
    Project = apps.get_model("projects", "Project")
    for p in Project.objects.filter(client_token=""):
        p.client_token = secrets.token_urlsafe(32)
        p.save(update_fields=["client_token"])


class Migration(migrations.Migration):

    dependencies = [
        ("projects", "0003_redeemcode_claim_visit"),
    ]

    operations = [
        migrations.AddField(
            model_name="project",
            name="client_token",
            field=models.CharField(
                blank=True, default="",
                help_text="用于客户端无登录访问项目数据看板",
                max_length=64, unique=True,
                verbose_name="客户端Token",
            ),
        ),
        migrations.RunPython(generate_tokens, reverse_code=migrations.RunPython.noop),
    ]
