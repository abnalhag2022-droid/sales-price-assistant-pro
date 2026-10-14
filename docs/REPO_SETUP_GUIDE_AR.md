# 📖 دليل إعداد المستودع

## المتطلبات

- Git
- Python 3.9+
- Flutter 3.13+
- Docker & Docker Compose

## الخطوات

### 1. Clone المستودع

git clone https://github.com/abnalhag2022-droid/sales-price-assistant-pro.git
cd sales-price-assistant-pro

### 2. Backend Setup

cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

### 3. Mobile Setup

cd ../mobile
flutter pub get

### 4. Database Setup

docker-compose up -d

### 5. تشغيل Backend

cd ../backend
uvicorn app.main:app --reload

### 6. تشغيل Mobile

cd ../mobile
flutter run

آخر تحديث: October 2024
