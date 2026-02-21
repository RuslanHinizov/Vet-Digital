from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from pydantic import BaseModel, Field
from datetime import date, datetime, timezone

from app.database import get_db
from app.dependencies import CurrentUser
from app.models.inventory import InventoryItem, InventoryTransaction

router = APIRouter()


class InventoryItemCreate(BaseModel):
    name_kk: Optional[str] = None
    name_ru: str
    category: str = Field(..., description="vaccine/syringe/needle/cotton/alcohol/other")
    unit: str = Field(..., description="dose/piece/ml/gram/pack")
    current_stock: float = 0
    min_stock_alert: Optional[float] = None
    organization_id: str
    manufacturer: Optional[str] = None
    batch_number: Optional[str] = None
    expiry_date: Optional[date] = None
    state_control_no: Optional[str] = None


class InventoryItemResponse(BaseModel):
    id: str
    name_kk: Optional[str]
    name_ru: str
    category: str
    unit: str
    current_stock: float
    min_stock_alert: Optional[float]
    organization_id: str
    manufacturer: Optional[str]
    batch_number: Optional[str]
    expiry_date: Optional[date]
    state_control_no: Optional[str]

    model_config = {"from_attributes": True}


class ConsumeRequest(BaseModel):
    quantity: float = Field(..., gt=0)
    procedure_act_id: Optional[str] = None
    notes: Optional[str] = None


@router.get("", summary="List inventory items")
async def list_inventory(
    current_user: CurrentUser,
    organization_id: Optional[str] = None,
    category: Optional[str] = None,
    low_stock_only: bool = False,
    db: AsyncSession = Depends(get_db),
):
    query = select(InventoryItem)
    if organization_id:
        query = query.where(InventoryItem.organization_id == organization_id)
    if category:
        query = query.where(InventoryItem.category == category)
    if low_stock_only:
        from sqlalchemy import and_
        query = query.where(
            and_(
                InventoryItem.min_stock_alert != None,
                InventoryItem.current_stock <= InventoryItem.min_stock_alert,
            )
        )

    result = await db.execute(query)
    items = result.scalars().all()
    return {"count": len(items), "items": [InventoryItemResponse.model_validate(i) for i in items]}


@router.post("", response_model=InventoryItemResponse, status_code=status.HTTP_201_CREATED)
async def create_inventory_item(
    current_user: CurrentUser,
    data: InventoryItemCreate,
    db: AsyncSession = Depends(get_db),
):
    item = InventoryItem(**data.model_dump())
    db.add(item)
    await db.commit()
    await db.refresh(item)
    return InventoryItemResponse.model_validate(item)


@router.put("/{item_id}/consume", summary="Record consumption of inventory item")
async def consume_inventory(
    current_user: CurrentUser,
    item_id: str,
    request: ConsumeRequest,
    db: AsyncSession = Depends(get_db),
):
    result = await db.execute(select(InventoryItem).where(InventoryItem.id == item_id))
    item = result.scalar_one_or_none()
    if not item:
        raise HTTPException(status_code=404, detail="Inventory item not found")

    if item.current_stock < request.quantity:
        raise HTTPException(
            status_code=400,
            detail=f"Insufficient stock. Available: {item.current_stock} {item.unit}"
        )

    item.current_stock -= request.quantity

    transaction = InventoryTransaction(
        item_id=item_id,
        transaction_type="consumption",
        quantity=-request.quantity,
        procedure_act_id=request.procedure_act_id,
        performed_by=current_user.id,
        notes=request.notes,
        created_at=datetime.now(timezone.utc).isoformat(),
    )
    db.add(transaction)
    await db.commit()

    return {
        "message": "Consumption recorded",
        "item_id": item_id,
        "consumed": request.quantity,
        "remaining_stock": item.current_stock,
    }
