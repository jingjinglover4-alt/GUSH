from django.db import transaction
from django.db.models import Count, OuterRef, Q, Subquery, Sum, IntegerField
from django.db.models.functions import Coalesce
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from apps.devices.models import Channel, DispenseLog

from . import services
from .models import Product, StockMovement
from .serializers import (
    ProductDetailSerializer,
    ProductSerializer,
    StockInSerializer,
    StockMovementSerializer,
)


class ProductViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    queryset = Product.objects.all()

    def get_serializer_class(self):
        if self.action == "retrieve":
            return ProductDetailSerializer
        return ProductSerializer

    def get_queryset(self):
        # 用 Subquery 避免多 JOIN 导致 Sum/Count 笛卡尔积膨胀
        on_machine = (
            Channel.objects
            .filter(product=OuterRef("pk"))
            .values("product")
            .annotate(s=Sum("current_stock"))
            .values("s")[:1]
        )
        ch_count = (
            Channel.objects
            .filter(product=OuterRef("pk"))
            .values("product")
            .annotate(c=Count("id"))
            .values("c")[:1]
        )
        dispensed = (
            DispenseLog.objects
            .filter(channel__product=OuterRef("pk"), result=DispenseLog.Result.SUCCESS)
            .values("channel__product")
            .annotate(c=Count("id"))
            .values("c")[:1]
        )
        qs = (
            Product.objects.all()
            .prefetch_related("channels__machine")
            .annotate(
                _channel_count=Coalesce(Subquery(ch_count, output_field=IntegerField()), 0),
                _on_machine_stock=Coalesce(Subquery(on_machine, output_field=IntegerField()), 0),
                _dispensed_count=Coalesce(Subquery(dispensed, output_field=IntegerField()), 0),
            )
        )
        search = self.request.query_params.get("search")
        if search:
            qs = qs.filter(
                Q(name__icontains=search)
                | Q(sku__icontains=search)
                | Q(brand__icontains=search)
            )
        # 仅看仓库还有货的：?has_stock=1
        if self.request.query_params.get("has_stock") == "1":
            qs = qs.filter(total_stock__gt=0)
        return qs

    @action(detail=True, methods=["post"])
    def inbound(self, request, pk=None):
        """
        礼品入库：总库存 += quantity
        body: {"quantity": 100, "note": "首批入库"}
        """
        product = self.get_object()
        ser = StockInSerializer(data=request.data)
        ser.is_valid(raise_exception=True)
        qty = ser.validated_data["quantity"]
        note = ser.validated_data.get("note", "")
        with transaction.atomic():
            # 加行锁，防止并发入库丢更新
            locked = Product.objects.select_for_update().get(pk=product.pk)
            locked.total_stock = (locked.total_stock or 0) + qty
            locked.save(update_fields=["total_stock", "updated_at"])
            services.record_inbound(
                product=locked,
                quantity=qty,
                warehouse_after=locked.total_stock,
                operator=request.user if request.user.is_authenticated else None,
                note=note,
            )
        return Response(
            ProductSerializer(locked, context=self.get_serializer_context()).data
        )


class StockMovementViewSet(viewsets.ReadOnlyModelViewSet):
    """
    库存流水查询
    GET /api/stock-movements/?product=&machine=&channel=&kind=&since=&until=
    支持分页（DRF 默认 PageNumberPagination）。
    """
    permission_classes = (IsAuthenticated,)
    serializer_class = StockMovementSerializer
    queryset = StockMovement.objects.all()

    def get_queryset(self):
        qs = (
            StockMovement.objects
            .select_related("product", "machine", "channel", "operator", "redeem_code")
        )
        p = self.request.query_params
        if p.get("product"):
            qs = qs.filter(product_id=p["product"])
        if p.get("machine"):
            qs = qs.filter(machine_id=p["machine"])
        if p.get("channel"):
            qs = qs.filter(channel_id=p["channel"])
        kind = p.get("kind")
        if kind:
            # 允许传 "restock" 自动展开 restock_out + restock_in；"return" 同理
            if kind == "restock":
                qs = qs.filter(kind__in=[
                    StockMovement.Kind.RESTOCK_OUT,
                    StockMovement.Kind.RESTOCK_IN,
                ])
            elif kind == "return":
                qs = qs.filter(kind__in=[
                    StockMovement.Kind.RETURN_OUT,
                    StockMovement.Kind.RETURN_IN,
                ])
            elif kind in StockMovement.Kind.values:
                qs = qs.filter(kind=kind)
        if p.get("since"):
            qs = qs.filter(created_at__gte=p["since"])
        if p.get("until"):
            qs = qs.filter(created_at__lte=p["until"])
        # 默认隐藏配对中"看起来重复"的那一半？不隐藏 — 让前端按 kind 着色，账本完整
        return qs
