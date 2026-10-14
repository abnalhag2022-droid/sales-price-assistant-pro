# ⚡ دليل البدء السريع

## الخطوات الأساسية

### 1. تشغيل قاعدة البيانات

docker-compose up -d

### 2. Backend Setup

cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload

### 3. Mobile Setup

cd mobile
flutter pub get
flutter run

## التالي

اقرأ ARCHITECTURE_AR.md

آخر تحديث: October 2024
