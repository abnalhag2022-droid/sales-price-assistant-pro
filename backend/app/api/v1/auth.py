from fastapi import APIRouter

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/login")
async def login(username: str, password: str):
    """
    تسجيل الدخول
    """
    return {
        "access_token": "token_example",
        "token_type": "bearer",
        "user": {
            "id": "1",
            "username": username
        }
    }

@router.post("/logout")
async def logout():
    """
    تسجيل الخروج
    """
    return {"message": "logged out"}

@router.get("/me")
async def get_current_user():
    """
    الحصول على بيانات المستخدم الحالي
    """
    return {
        "id": "1",
        "username": "demo_user",
        "email": "demo@example.com"
    }
