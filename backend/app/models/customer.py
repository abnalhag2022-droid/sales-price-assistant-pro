from sqlalchemy import Column, String, DateTime, Float
from sqlalchemy.sql import func
from database import Base
import uuid

class Customer(Base):
    """
    جدول العملاء
    """
    __tablename__ = "customers"

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    code = Column(String, unique=True, index=True, nullable=False)
    name_ar = Column(String, nullable=False)
    name_en = Column(String, nullable=True)
    phone = Column(String, nullable=True)
    email = Column(String, nullable=True)
    address = Column(String, nullable=True)
    credit_limit = Column(Float, default=0)
    discount_percentage = Column(Float, default=0)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    def __repr__(self):
        return f"<Customer(id={self.id}, code={self.code}, name_ar={self.name_ar})>"
