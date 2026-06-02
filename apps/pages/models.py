"""
页面装修模块（Phase 1.1：数据层）

设计要点：
- 项目级（D1）：一个项目一套主题 + 一个 H5 落地页；设备级覆盖留待 Phase 1.5
- D2：本期只做 H5 落地页 + 主题。LED 大屏页留待 Phase 1.5（先保留 redeem.html 不动）
- 区块、字段、样式等灵活内容存 JSON，避免频繁迁移
- PageVersion 留通用快照表，将来 LED 也复用

JSON 结构约定（前端契约）：

PageTheme.shared_assets:
    [{"name": "主视频", "type": "video|image", "url": "..."}]

H5Page.blocks:
    [{"id": "b1", "type": "image|video|carousel|text|rich_text|divider|countdown",
      "props": { 各 block 自己的字段 }
     }]

H5Page.form_fields:
    [{"key": "name", "label": "您的称呼", "type": "text|tel|radio|checkbox|select",
      "required": true, "placeholder": "...",
      "validate_regex": "...", "error_msg": "...",
      "options": [{"value":"...", "label":"...", "sublabel":"..."}]  # radio/select 用
     }]

H5Page.privacy:
    {"enabled": true, "text": "我已阅读并同意《客户隐私协议》",
     "url": "https://..."}

H5Page.submit_button:
    {"text": "立即领取", "color": "#14B450"}

H5Page.success_view:
    {"title": "您今日已领取过", "subtitle": "...", "code_label": "您的兑换码",
     "footer_tip": "请在终端页面输入此码进行核销"}
"""
from django.conf import settings
from django.db import models


# 默认表单字段：参考 cdgushai.com/feidou/claim.html
DEFAULT_FORM_FIELDS = [
    {
        "key": "name",
        "label": "您的称呼",
        "type": "text",
        "required": True,
        "placeholder": "您的称呼",
        "validate_regex": "",
        "error_msg": "请填写称呼",
    },
    {
        "key": "phone",
        "label": "手机号码",
        "type": "tel",
        "required": True,
        "placeholder": "手机号码",
        "validate_regex": r"^1[3-9]\d{9}$",
        "error_msg": "请填写正确的手机号",
    },
    {
        "key": "identity",
        "label": "您的身份",
        "type": "radio",
        "required": True,
        "options": [
            {"value": "visitor", "label": "园区游客", "sublabel": "来园区游玩的客人", "icon": "🎒"},
            {"value": "staff", "label": "园区小伙伴", "sublabel": "园区工作人员", "icon": "👥"},
        ],
    },
]


DEFAULT_PRIVACY = {
    "enabled": True,
    "text": "我已阅读并同意《客户隐私协议》",
    "url": "",
}


DEFAULT_SUBMIT_BUTTON = {
    "text": "立即领取",
    "color": "",  # 空 = 用主题 brand_color
}


DEFAULT_SUCCESS_VIEW = {
    "title": "您今日已领取过",
    "subtitle": "每个设备每天只能领取一次",
    "code_label": "您的兑换码",
    "footer_tip": "请在终端页面输入此码进行核销",
}


# ===== LED 大屏默认值 =====
DEFAULT_LED_ADS = []  # [{"type":"image|video", "url":"...", "duration_sec": 8}]
DEFAULT_LED_QR = {
    "label": "扫码关注 · 领取样品",
    "url": "",  # 企微二维码图片 URL
}
DEFAULT_LED_INPUT = {
    "label": "输入兑换码",
    "placeholder": "请输入兑换码",
    "submit_text": "立即兑换",
    "success_text": "出货中...",
}

def _default_led_page_blocks():
    return []

def _default_led_page_background():
    return {}


# JSONField 默认值必须是模块级可导入的 callable（不能用 lambda），否则迁移生成会报错
def _default_form_fields():
    import copy
    return copy.deepcopy(DEFAULT_FORM_FIELDS)


def _default_privacy():
    return dict(DEFAULT_PRIVACY)


def _default_submit_button():
    return dict(DEFAULT_SUBMIT_BUTTON)


def _default_success_view():
    return dict(DEFAULT_SUCCESS_VIEW)


def _default_led_ads():
    return list(DEFAULT_LED_ADS)


def _default_led_qr():
    return dict(DEFAULT_LED_QR)


def _default_led_input():
    return dict(DEFAULT_LED_INPUT)


class PageTheme(models.Model):
    """
    页面主题（项目级，一对一）
    LED 页 + H5 页共享同一套品牌色 / Logo / 字体 / 资源库
    """
    project = models.OneToOneField(
        "projects.Project",
        on_delete=models.CASCADE,
        related_name="page_theme",
        verbose_name="所属项目",
    )

    brand_color = models.CharField("品牌主色", max_length=16, default="#14B450")
    accent_color = models.CharField("辅助色", max_length=16, default="#0a0a0a")
    text_color = models.CharField("文字主色", max_length=16, default="#FFFFFF")

    logo = models.ImageField("Logo", upload_to="pages/logos/", blank=True, null=True)
    favicon = models.ImageField("Favicon", upload_to="pages/favicons/", blank=True, null=True)

    background_type = models.CharField(
        "背景类型", max_length=16, default="color",
        choices=[("color", "纯色"), ("image", "图片"), ("gradient", "渐变")],
    )
    background_value = models.TextField("背景值", blank=True, default="#0a0a0a")
    background_image = models.ImageField(
        "背景图", upload_to="pages/bg/", blank=True, null=True,
        help_text="background_type=image 时生效",
    )

    font_family = models.CharField(
        "字体", max_length=128,
        default='"Noto Sans SC", -apple-system, sans-serif',
    )

    # 共享资源库：业务方上传的视频/图片可在多个 block 间复用
    shared_assets = models.JSONField("共享资源", default=list, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "页面主题"
        verbose_name_plural = "页面主题"
        db_table = "gush_page_theme"

    def __str__(self) -> str:
        return f"主题 #{self.project_id}"


class H5Page(models.Model):
    """
    H5 落地页（项目级，一对一）
    用户扫码后企微推送此页面 → 填表单 → 拿兑换码
    """

    class Status(models.TextChoices):
        DRAFT = "draft", "草稿"
        PUBLISHED = "published", "已发布"

    class RateLimit(models.TextChoices):
        NONE = "none", "无限制"
        PER_DEVICE_DAY = "per_device_day", "每设备每天 1 次"
        PER_PHONE_DAY = "per_phone_day", "每手机号每天 1 次"
        PER_OPENID_DAY = "per_openid_day", "每微信用户每天 1 次"

    project = models.OneToOneField(
        "projects.Project",
        on_delete=models.CASCADE,
        related_name="h5_page",
        verbose_name="所属项目",
    )

    # 顶部头部
    header_title = models.CharField("页面标题", max_length=64, default="填写信息")
    header_subtitle = models.CharField("副标题", max_length=128, default="获取您的专属兑换码")

    # 自由 blocks（表单上方）
    blocks = models.JSONField("内容区块", default=list, blank=True)

    # 表单
    form_fields = models.JSONField("表单字段", default=_default_form_fields)

    # 隐私协议
    privacy = models.JSONField("隐私协议配置", default=_default_privacy)

    # Phase 2.5 隐私协议正文（可编辑，供 /p/privacy/<id>/ 页面使用）
    privacy_policy = models.TextField("隐私协议正文", blank=True, default="",
        help_text="在此填写隐私协议内容，用户可从表单页链接访问")

    # 提交按钮
    submit_button = models.JSONField("提交按钮", default=_default_submit_button)

    # 频控
    rate_limit = models.CharField(
        "限频策略", max_length=32,
        choices=RateLimit.choices,
        default=RateLimit.PER_DEVICE_DAY,
    )

    # 成功页 / 已领取弹窗
    success_view = models.JSONField("成功视图配置", default=_default_success_view)

    # 各页背景
    page1_background = models.JSONField("Page 1 背景", default=dict, blank=True)
    page2_background = models.JSONField("Page 2 背景", default=dict, blank=True)
    page3_background = models.JSONField("Page 3 背景", default=dict, blank=True)

    # 跳转按钮文字
    page1_button_text = models.CharField("Page 1 跳转按钮", max_length=32, default="下一步")
    header_font_color = models.CharField("头部字体颜色", max_length=32, blank=True, default="#FFFFFF")
    header_font_size = models.CharField("头部字体大小", max_length=32, blank=True, default="26")
    page1_button_font_size = models.CharField("Page 1 按钮字体大小", max_length=16, blank=True, default="")
    page1_button_padding = models.CharField("Page 1 按钮内边距", max_length=32, blank=True, default="")
    page1_button_font_color = models.CharField("Page 1 按钮字体颜色", max_length=32, blank=True, default="")
    page1_button_bg_color = models.CharField("Page 1 按钮背景颜色", max_length=16, blank=True, default="")
    page2_button_text = models.CharField("Page 2 跳转按钮", max_length=32, default="立即领取")

    # Phase 2.5: 自由布局 - 标题和按钮的位置（百分比坐标）
    header_position = models.JSONField("标题位置", default=dict, blank=True,
        help_text="{x: 50, y: 10} 百分比坐标，空=默认居中顶部")
    button_position = models.JSONField("按钮位置", default=dict, blank=True,
        help_text="{x: 50, y: 80} 百分比坐标，空=默认居中底部")

    # 发布
    status = models.CharField("状态", max_length=16, choices=Status.choices, default=Status.DRAFT)
    published_at = models.DateTimeField("最近发布时间", null=True, blank=True)
    current_version = models.IntegerField("当前已发布版本号", default=0)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "H5 落地页"
        verbose_name_plural = "H5 落地页"
        db_table = "gush_h5_page"

    def __str__(self) -> str:
        return f"H5 #{self.project_id} v{self.current_version}"


class PageVersion(models.Model):
    """
    页面发布快照（不可变账本）
    每次「发布」时把当时的草稿状态完整快照下来 → 可回滚 / 可对比
    将来 LedPage 上线后也复用同一张表
    """

    class PageType(models.TextChoices):
        THEME = "theme", "主题"
        H5 = "h5", "H5 落地页"
        LED = "led", "LED 大屏页"

    page_type = models.CharField("页面类型", max_length=16, choices=PageType.choices, db_index=True)
    page_id = models.IntegerField("页面ID", db_index=True)
    project = models.ForeignKey(
        "projects.Project", on_delete=models.CASCADE,
        related_name="page_versions",
        verbose_name="所属项目",
    )
    version = models.IntegerField("版本号")
    snapshot = models.JSONField("快照内容", default=dict)
    note = models.CharField("发布说明", max_length=255, blank=True, default="")

    published_at = models.DateTimeField("发布时间", auto_now_add=True, db_index=True)
    published_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name="page_versions_published",
    )

    class Meta:
        verbose_name = "页面版本"
        verbose_name_plural = "页面版本"
        db_table = "gush_page_version"
        ordering = ["-published_at"]
        unique_together = [("page_type", "page_id", "version")]
        indexes = [
            models.Index(fields=["project", "page_type", "-version"]),
        ]

    def __str__(self) -> str:
        return f"{self.get_page_type_display()}#{self.page_id} v{self.version}"


class LedPage(models.Model):
    """
    LED 大屏页（项目级，一对一）
    派样机 Qt WebView 加载此页：广告轮播 + 二维码 + 兑换码输入框
    """

    class Status(models.TextChoices):
        DRAFT = "draft", "草稿"
        PUBLISHED = "published", "已发布"

    project = models.OneToOneField(
        "projects.Project",
        on_delete=models.CASCADE,
        related_name="led_page",
        verbose_name="所属项目",
    )

    # 顶部文案（可选）
    header_title = models.CharField("标题", max_length=64, blank=True, default="")
    header_subtitle = models.CharField("副标题", max_length=128, blank=True, default="")

    # 广告轮播：[{"type":"image|video", "url":"...", "duration_sec":8}]
    ads = models.JSONField("广告轮播资源", default=_default_led_ads, blank=True)

    # 二维码区域
    qr_image = models.ImageField("企微二维码图", upload_to="pages/led/qr/", blank=True, null=True)
    qr = models.JSONField("二维码文案配置", default=_default_led_qr)

    # 兑换码输入区
    input_config = models.JSONField("输入区配置", default=_default_led_input)

    # 底部提示
    footer_tip = models.CharField("底部提示", max_length=255, blank=True,
                                  default="出货完成请到取货口领取")

    # LED Block Builder: 自由区块设计（Phase 2）
    page1_blocks = models.JSONField("Page 1 区块", default=_default_led_page_blocks, blank=True)
    page2_blocks = models.JSONField("Page 2 区块", default=_default_led_page_blocks, blank=True)
    page1_background = models.JSONField("Page 1 背景", default=_default_led_page_background, blank=True)
    page2_background = models.JSONField("Page 2 背景", default=_default_led_page_background, blank=True)

    # 发布
    status = models.CharField("状态", max_length=16, choices=Status.choices, default=Status.DRAFT)
    published_at = models.DateTimeField("最近发布时间", null=True, blank=True)
    current_version = models.IntegerField("当前已发布版本号", default=0)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "LED 大屏页"
        verbose_name_plural = "LED 大屏页"
        db_table = "gush_led_page"

    def __str__(self) -> str:
        return f"LED #{self.project_id} v{self.current_version}"


class DevicePageOverride(models.Model):
    """
    设备级页面覆盖（Phase 1.7）

    解决：多台设备绑同一个项目时，需要每台呈现差异化内容
    （如不同门店的二维码、不同点位的广告片单）。

    存储策略：稀疏（sparse）JSON
    - theme_override:  只放与项目主题不同的字段
    - h5_override:     只放与项目 H5 页不同的字段
    - led_override:    只放与项目 LED 页不同的字段
    渲染时：项目级 base + 设备级 override 浅合并；JSONField 用浅 merge 即可，
    深层结构（如 ads / blocks）走「整段替换」语义，避免乱。
    """
    machine = models.OneToOneField(
        "devices.Machine",
        on_delete=models.CASCADE,
        related_name="page_override",
        verbose_name="目标设备",
    )

    # 仅放与项目主体差异部分
    theme_override = models.JSONField("主题覆盖", default=dict, blank=True)
    h5_override = models.JSONField("H5 覆盖", default=dict, blank=True)
    led_override = models.JSONField("LED 覆盖", default=dict, blank=True)

    # 二维码图等文件字段：覆盖时也允许独立上传
    led_qr_image = models.ImageField(
        "LED 二维码（覆盖）", upload_to="pages/overrides/led_qr/",
        blank=True, null=True,
    )

    # Phase 4.4：当设备绑多个 running 项目时，强制指定该设备播哪个项目
    # 留空 = 按默认规则（最新的 running）选
    active_project = models.ForeignKey(
        "projects.Project", on_delete=models.SET_NULL,
        related_name="active_on_devices",
        null=True, blank=True,
        verbose_name="活跃项目",
        help_text="此设备 LED / 子域名落地页绑定的项目。多项目共存时必须显式指定。",
    )

    enabled = models.BooleanField("启用覆盖", default=True)
    note = models.CharField("备注", max_length=255, blank=True, default="")

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "设备页面覆盖"
        verbose_name_plural = "设备页面覆盖"
        db_table = "gush_device_page_override"

    def __str__(self) -> str:
        return f"设备覆盖 {self.machine.machine_id}"


class Experiment(models.Model):
    """
    Phase 2.3 - H5 落地页 A/B 实验

    设计：
    - 一个项目同时只能跑一个实验（避免重叠分流复杂度）
    - 双变体 A/B（key='A' 通常是「现状对照组」，'B' 是「新方案」）
    - traffic_split_b：分给 B 的流量百分比（0-100），剩下进 A
    - 完成实验时挑 winner → 直接把该 variant 的 snapshot 推回到 H5Page（沿用回滚机制）
    """

    class Status(models.TextChoices):
        DRAFT = "draft", "草稿"
        RUNNING = "running", "进行中"
        STOPPED = "stopped", "已暂停"
        CONCLUDED = "concluded", "已结束"

    project = models.OneToOneField(
        "projects.Project", on_delete=models.CASCADE,
        related_name="experiment",
        verbose_name="所属项目",
    )
    name = models.CharField("实验名称", max_length=128, default="A/B 实验")
    hypothesis = models.TextField("假设", blank=True, default="",
                                  help_text="例：使用红色按钮可提升点击率")

    status = models.CharField("状态", max_length=16, choices=Status.choices, default=Status.DRAFT)
    traffic_split_b = models.IntegerField(
        "B 变体流量占比(%)", default=50,
        help_text="0-100，剩余流量进 A",
    )

    started_at = models.DateTimeField("启动时间", null=True, blank=True)
    stopped_at = models.DateTimeField("结束时间", null=True, blank=True)
    winner = models.CharField(
        "胜出变体", max_length=4, blank=True, default="",
        choices=[("A", "A"), ("B", "B"), ("C", "C"), ("D", "D")],
    )
    conclusion_note = models.CharField("结论备注", max_length=255, blank=True, default="")

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "A/B 实验"
        verbose_name_plural = "A/B 实验"
        db_table = "gush_experiment"

    def __str__(self) -> str:
        return f"{self.name} [{self.get_status_display()}]"


class ExperimentVariant(models.Model):
    """
    实验变体（A/B/C/D 各一行），快照存当时的 H5 配置
    Phase 4.3: 加 traffic_share，每变体独立流量占比；所有变体之和应 = 100
    """
    experiment = models.ForeignKey(
        Experiment, on_delete=models.CASCADE,
        related_name="variants",
    )
    key = models.CharField("变体 key", max_length=4)  # 'A' / 'B' / 'C' / 'D'
    name = models.CharField("变体名称", max_length=64, default="")
    note = models.CharField("说明", max_length=255, blank=True, default="")
    traffic_share = models.IntegerField("流量占比 %", default=50,
                                        help_text="单个变体的流量分配 0-100；所有变体之和 = 100")

    # H5 快照（与 PageVersion.snapshot.h5 同构）
    h5_snapshot = models.JSONField("H5 内容快照", default=dict)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "实验变体"
        verbose_name_plural = "实验变体"
        db_table = "gush_experiment_variant"
        unique_together = [("experiment", "key")]
        ordering = ["key"]

    def __str__(self) -> str:
        return f"{self.experiment.name} · {self.key}"


class PageVisitLog(models.Model):
    """
    Phase 2.2 - C 端页面访问日志（漏斗第一环）

    设计：尽量轻量
    - 不阻塞渲染：前端用 navigator.sendBeacon 或 fetch keepalive
    - 不强校验：缺字段也接受，IP / UA 走 request 自动填
    - device_fp（前端生成的 UUID，存 localStorage 持久化）→ 去重 UV
    - 上报后返回 visit_id，前端在后续 claim 提交时一起带回来 → 串联漏斗
    """

    class PageType(models.TextChoices):
        H5 = "h5", "H5 落地页"
        LED = "led", "LED 大屏页"

    page_type = models.CharField("页面类型", max_length=16, choices=PageType.choices, db_index=True)
    project = models.ForeignKey(
        "projects.Project", on_delete=models.CASCADE,
        related_name="visits",
        null=True, blank=True,  # LED 页早期可能没绑项目
    )
    machine = models.ForeignKey(
        "devices.Machine", on_delete=models.SET_NULL,
        related_name="visits",
        null=True, blank=True,
    )

    device_fp = models.CharField("设备指纹", max_length=64, blank=True, default="", db_index=True,
                                 help_text="前端 localStorage 持久化的 UUID")
    user_agent = models.CharField("UA", max_length=512, blank=True, default="")
    ip = models.GenericIPAddressField("访客 IP", null=True, blank=True)
    referrer = models.CharField("来源", max_length=512, blank=True, default="")

    # 可选 utm
    utm_source = models.CharField("utm_source", max_length=64, blank=True, default="")
    utm_campaign = models.CharField("utm_campaign", max_length=64, blank=True, default="")

    visited_at = models.DateTimeField("访问时间", auto_now_add=True, db_index=True)

    # Phase 2.3 实验串联：服务端在 SSR 时决定的变体一并落库
    experiment = models.ForeignKey(
        Experiment, on_delete=models.SET_NULL,
        related_name="visits",
        null=True, blank=True,
    )
    variant_key = models.CharField("命中变体", max_length=4, blank=True, default="")

    class Meta:
        verbose_name = "页面访问"
        verbose_name_plural = "页面访问"
        db_table = "gush_page_visit"
        ordering = ["-visited_at"]
        indexes = [
            models.Index(fields=["project", "page_type", "-visited_at"]),
            models.Index(fields=["machine", "-visited_at"]),
            models.Index(fields=["experiment", "variant_key", "-visited_at"]),
        ]

    def __str__(self) -> str:
        return f"{self.get_page_type_display()} #{self.id} @ {self.visited_at:%Y-%m-%d %H:%M}"
