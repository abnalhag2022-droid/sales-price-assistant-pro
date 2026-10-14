from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

class UserCreate(BaseModel):
    """
    إنشاء مستخدم جديد
    """
    username: str
    email: EmailStr
    password: str
    full_name: Optional[str] = None

class UserResponse(BaseModel):
    """
    استجابة المستخدم
    """
    id: str
    username: str
    email: str
    full_name: Optional[str]
    role: str
    is_active: bool
    created_at: datetime

    class Config:
        from_attributes = True

class LoginRequest(BaseModel):
    """
    طلب تسجيل الدخول
    """
    username: str
    password: str

class LoginResponse(BaseModel):
    """
    استجابة تسجيل الدخول
    """
    access_token: str
    token_type: str = "bearer"
    user: UserResponse
