from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from database import get_db
from models import Item
from pydantic import BaseModel
from typing import List, Optional

router = APIRouter(prefix="/items", tags=["items"])

class ItemCreate(BaseModel):
    code: str
    name_ar: str
    name_en: Optional[str] = None
    base_price: float
    category: Optional[str] = None

class ItemResponse(BaseModel):
    id: str
    code: str
    name_ar: str
    base_price: float
    stock: float

    class Config:
        from_attributes = True

@router.get("/", response_model=List[ItemResponse])
async def get_items(q: str = Query(None), db: Session = Depends(get_db)):
    """
    الحصول على قائمة الأصناف
    """
    query = db.query(Item)
    
    if q:
        query = query.filter(Item.name_ar.ilike(f"%{q}%"))
    
    return query.all()

@router.get("/{item_code}", response_model=ItemResponse)
async def get_item(item_code: str, db: Session = Depends(get_db)):
    """
    الحصول على صنف محدد
    """
    item = db.query(Item).filter(Item.code == item_code).first()
    
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    
    return ItemResponse.from_orm(item)

@router.post("/", response_model=ItemResponse)
async def create_item(item: ItemCreate, db: Session = Depends(get_db)):
    """
    إنشاء صنف جديد
    """
    # التحقق من عدم وجود الكود
    if db.query(Item).filter(Item.code == item.code).first():
        raise HTTPException(status_code=400, detail="Item code already exists")
    
    new_item = Item(
        code=item.code,
        name_ar=item.name_ar,
        name_en=item.name_en,
        base_price=item.base_price,
        category=item.category
    )
    
    db.add(new_item)
    db.commit()
    db.refresh(new_item)
    
    return ItemResponse.from_orm(new_item)
