from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker
from sqlalchemy.pool import StaticPool
import os

# قاعدة البيانات
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "sqlite:///./test.db"  # استخدام SQLite للتطوير
)

# إنشاء محرك قاعدة البيانات
if "sqlite" in DATABASE_URL:
    engine = create_engine(
        DATABASE_URL,
        connect_args={"check_same_thread": False},
        poolclass=StaticPool,
    )
else:
    engine = create_engine(
        DATABASE_URL,
        echo=False,
        pool_pre_ping=True,
    )

# إنشاء جلسة
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# القاعدة للـ Models
Base = declarative_base()

# الحصول على جلسة قاعدة البيانات
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
