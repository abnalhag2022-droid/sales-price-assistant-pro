from fastapi import APIRouter, Query
from typing import List

router = APIRouter(prefix="/items", tags=["items"])

# بيانات تجريبية
DEMO_ITEMS = [
    {"id": 1, "code": "ITEM001", "name_ar": "صنف 1", "price": 100},
    {"id": 2, "code": "ITEM002", "name_ar": "صنف 2", "price": 200},
    {"id": 3, "code": "ITEM003", "name_ar": "صنف 3", "price": 300},
]

@router.get("/")
async def get_items(q: str = Query(None)):
    """
    الحصول على قائمة الأصناف
    """
    if q:
        return [item for item in DEMO_ITEMS if q.lower() in item["name_ar"].lower()]
    return DEMO_ITEMS

@router.get("/{item_code}")
async def get_item(item_code: str):
    """
    الحصول على صنف محدد
    """
    for item in DEMO_ITEMS:
        if item["code"] == item_code:
            return item
    return {"error": "Item not found"}

@router.post("/")
async def create_item(code: str, name_ar: str, price: float):
    """
    إنشاء صنف جديد
    """
    new_item = {
        "id": len(DEMO_ITEMS) + 1,
        "code": code,
        "name_ar": name_ar,
        "price": price
    }
    DEMO_ITEMS.append(new_item)
    return new_item
