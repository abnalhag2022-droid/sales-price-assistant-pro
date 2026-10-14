from fastapi import APIRouter
from .auth import router as auth_router
from .items import router as items_router

api_router = APIRouter(prefix="/api/v1")
api_router.include_router(auth_router)
api_router.include_router(items_router)

__all__ = ["api_router"]
