"""
活动项目模型
- Project: 一个派样活动（含海报、规则、企业微信二维码、关联设备）
- ProjectMachine: 项目与设备的多对多
- RedeemCode: 兑换码
"""
from django.conf import settings
from django.db import models
from django.urls import reverse


class Project(models.Model):
    """派样活动项目"""

    class Status(models.TextChoices):
        DRAFT = "draft", "草稿"
        RUNNING = "running", "进行中"
        PAUSED = "paused", "已暂停"
        FINISHED = "finished", "已结束"

    name = models.CharField("项目名称", max_length=128)
    description = models.TextField("项目描述", blank=True, default="")
    starts_at = models.DateTimeField("开始时间")
    ends_at = models.DateTimeField("结束时间")

    # H5 配置
    poster_image = models.ImageField("活动海报", upload_to="posters/", blank=True, null=True)
    wechat_qr = models.ImageField("企业微信二维码", upload_to="qrcodes/", blank=True, null=True)
    rules_text = models.TextField("活动规则", blank=True, default="")

    # 兑换码规则
    code_length = models.IntegerField("兑换码长度", default=8)
    code_validity_days = models.IntegerField("兑换码有效天数", default=7)
    max_per_user = models.IntegerField("每用户最多兑换次数", default=1)

    status = models.CharField("状态", max_length=16, choices=Status.choices, default=Status.DRAFT)

    # 关联
    machines = models.ManyToManyField(
        "devices.Machine",
        through="ProjectMachine",
        related_name="projects",
        verbose_name="关联设备",
    )
    products = models.ManyToManyField(
        "products.Product",
        blank=True,
        related_name="projects",
        verbose_name="本活动派发的礼品",
        help_text="勾选后，给本项目设备补货时只能选这些礼品。",
    )
    created_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="projects_created",
        verbose_name="创建人",
    )

    # 客户端看板 Token（新建时自动生成）
    client_token = models.CharField(
        "客户端Token", max_length=64, unique=True, blank=True, default="",
        help_text="用于客户端无登录访问项目数据看板",
    )

    created_at = models.DateTimeField("创建时间", auto_now_add=True)
    updated_at = models.DateTimeField("更新时间", auto_now=True)

    class Meta:
        verbose_name = "活动项目"
        verbose_name_plural = "活动项目"
        db_table = "gush_project"
        ordering = ["-created_at"]

    def save(self, *args, **kwargs):
        if not self.client_token:
            self.client_token = self._generate_token()
        super().save(*args, **kwargs)

    @staticmethod
    def _generate_token() -> str:
        import secrets
        return secrets.token_urlsafe(32)

    def __str__(self) -> str:
        return self.name


class ProjectMachine(models.Model):
    """项目-设备绑定关系"""
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    machine = models.ForeignKey("devices.Machine", on_delete=models.CASCADE)
    bound_at = models.DateTimeField("绑定时间", auto_now_add=True)

    class Meta:
        db_table = "gush_project_machine"
        unique_together = [("project", "machine")]


class RedeemCode(models.Model):
    """
    兑换码 - 用户扫码关注企微后生成，到设备上输入完成兑换
    """

    class Status(models.TextChoices):
        UNUSED = "unused", "未使用"
        USED = "used", "已使用"
        EXPIRED = "expired", "已过期"
        REVOKED = "revoked", "已作废"

    project = models.ForeignKey(
        Project, on_delete=models.CASCADE,
        related_name="redeem_codes",
    )
    code = models.CharField("兑换码", max_length=32, unique=True, db_index=True)
    status = models.CharField("状态", max_length=16, choices=Status.choices, default=Status.UNUSED)

    # 用户信息（关注企微后获取）
    user_openid = models.CharField("用户OpenID", max_length=64, blank=True, default="", db_index=True)
    user_nickname = models.CharField("用户昵称", max_length=64, blank=True, default="")
    # 表单数据（H5 落地页提交的完整表单）
    form_data = models.JSONField("表单数据", default=dict, blank=True)

    expires_at = models.DateTimeField("过期时间")

    # 使用情况
    used_at = models.DateTimeField("使用时间", null=True, blank=True)
    used_on_machine = models.ForeignKey(
        "devices.Machine",
        on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="used_codes",
    )
    used_on_channel_code = models.CharField("使用货道", max_length=4, blank=True, default="")

    # Phase 2.2 漏斗串联
    claim_visit = models.ForeignKey(
        "pages.PageVisitLog", on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="claimed_codes",
        verbose_name="领取来源访问",
    )

    created_at = models.DateTimeField("创建时间", auto_now_add=True)

    class Meta:
        verbose_name = "兑换码"
        verbose_name_plural = "兑换码"
        db_table = "gush_redeem_code"
        ordering = ["-created_at"]
        indexes = [
            models.Index(fields=["project", "status"]),
        ]
