from sqlalchemy import Column, String, DateTime, Float, Text
from sqlalchemy.sql import func
from database import Base
import uuid

class Item(Base):
    """
    جدول الأصناف
    """
    __tablename__ = "items"

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    code = Column(String, unique=True, index=True, nullable=False)
    name_ar = Column(String, nullable=False, index=True)
    name_en = Column(String, nullable=True)
    description = Column(Text, nullable=True)
    category = Column(String, nullable=True)
    base_price = Column(Float, nullable=False)
    unit = Column(String, default="piece")
    stock = Column(Float, default=0)
    is_active = Column(String, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    def __repr__(self):
        return f"<Item(id={self.id}, code={self.code}, name_ar={self.name_ar})>"
