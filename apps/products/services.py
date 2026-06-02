"""
库存流水写入工具

任何涉及库存数量变化的代码都应通过这里写流水，
避免散落在多处又忘记记账。所有调用都假定外层已开了事务。
"""
from typing import Optional

from .models import Product, StockMovement


def _create(**kwargs) -> StockMovement:
    return StockMovement.objects.create(**kwargs)


def record_inbound(
    *,
    product: Product,
    quantity: int,
    warehouse_after: int,
    operator=None,
    note: str = "",
) -> StockMovement:
    """入库：仓库增加"""
    return _create(
        product=product,
        kind=StockMovement.Kind.INBOUND,
        quantity=quantity,
        warehouse_after=warehouse_after,
        operator=operator,
        source="manual",
        note=note,
    )


def record_restock(
    *,
    product: Product,
    channel,
    quantity: int,
    warehouse_after: int,
    channel_stock_after: int,
    operator=None,
    note: str = "",
):
    """
    补货：仓库 → 货道。写两条流水：
      - restock_out (仓库扣减)
      - restock_in  (货道增加)
    """
    out = _create(
        product=product,
        kind=StockMovement.Kind.RESTOCK_OUT,
        quantity=quantity,
        machine=channel.machine,
        channel=channel,
        channel_code=channel.channel_code,
        warehouse_after=warehouse_after,
        channel_stock_after=channel_stock_after,
        operator=operator,
        source="restock",
        note=note,
    )
    inn = _create(
        product=product,
        kind=StockMovement.Kind.RESTOCK_IN,
        quantity=quantity,
        machine=channel.machine,
        channel=channel,
        channel_code=channel.channel_code,
        warehouse_after=warehouse_after,
        channel_stock_after=channel_stock_after,
        operator=operator,
        source="restock",
        note=note,
        paired_with=out,
    )
    out.paired_with = inn
    out.save(update_fields=["paired_with"])
    return out, inn


def record_dispense(
    *,
    product: Optional[Product],
    channel,
    quantity: int = 1,
    channel_stock_after: int,
    redeem_code=None,
    dispense_log=None,
    source: str = "dispense",
    operator=None,
    note: str = "",
) -> Optional[StockMovement]:
    """派样：货道扣减；product 可能为 None（货道未绑定）"""
    if product is None:
        return None
    return _create(
        product=product,
        kind=StockMovement.Kind.DISPENSE,
        quantity=quantity,
        machine=channel.machine if channel else None,
        channel=channel,
        channel_code=channel.channel_code if channel else "",
        channel_stock_after=channel_stock_after,
        redeem_code=redeem_code,
        dispense_log=dispense_log,
        operator=operator,
        source=source,
        note=note,
    )


def record_return(
    *,
    product: Product,
    channel,
    quantity: int,
    warehouse_after: int,
    channel_stock_after: int,
    operator=None,
    note: str = "",
):
    """
    回库：货道 → 仓库。写两条流水：
      - return_out (货道扣减)
      - return_in  (仓库增加)
    """
    out = _create(
        product=product,
        kind=StockMovement.Kind.RETURN_OUT,
        quantity=quantity,
        machine=channel.machine,
        channel=channel,
        channel_code=channel.channel_code,
        warehouse_after=warehouse_after,
        channel_stock_after=channel_stock_after,
        operator=operator,
        source="return",
        note=note,
    )
    inn = _create(
        product=product,
        kind=StockMovement.Kind.RETURN_IN,
        quantity=quantity,
        machine=channel.machine,
        channel=channel,
        channel_code=channel.channel_code,
        warehouse_after=warehouse_after,
        channel_stock_after=channel_stock_after,
        operator=operator,
        source="return",
        note=note,
        paired_with=out,
    )
    out.paired_with = inn
    out.save(update_fields=["paired_with"])
    return out, inn
