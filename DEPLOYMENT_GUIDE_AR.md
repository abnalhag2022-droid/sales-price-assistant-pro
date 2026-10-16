# دليل الإطلاق - Sales Price Assistant Pro

## 📋 قائمة الفحص قبل الإطلاق

### قبل الإطلاق
- [ ] جميع الاختبارات تمر
- [ ] التوثيق محدث
- [ ] Version bumped
- [ ] Git tags إنشاء
- [ ] Backend مستقر
- [ ] Database مهيأة

---

## 🚀 خطوات الإطلاق

### 1. إعداد البيئة

```bash
# Clone المستودع
git clone https://github.com/abnalhag2022-droid/sales-price-assistant-pro.git
cd sales-price-assistant-pro

# Backend setup
cd backend
pip install -r requirements.txt
python -m app.main

# في نافذة أخرى - Mobile setup
cd ../mobile
flutter pub get
flutter run
2. تشغيل الاختبارات
# Backend tests
cd backend
pytest

# Mobile tests
cd ../mobile
flutter test
3. بناء الإصدار
Mobile Build
cd mobile

# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS Build
flutter build ios --release
Backend Build
cd backend

# Docker Build
docker build -t sales-price-assistant:v1.0.0 .

# Push to Registry
docker push your-registry/sales-price-assistant:v1.0.0
📦 الملفات المُنتجة
Android
mobile/build/app/outputs/apk/release/
├── app-release.apk (50-60 MB)
└── app-release.aab (30-40 MB)
iOS
mobile/build/ios/ipa/
└── app.ipa
Backend Docker
sales-price-assistant:v1.0.0
🌐 خادم الإنتاج
المتطلبات الأساسية
- OS: Linux (Ubuntu 20.04+)
- CPU: 2 cores minimum
- RAM: 4GB minimum
- Storage: 20GB SSD
- Network: Static IP
التثبيت على الخادم
# 1. تثبيت Docker و Docker Compose
sudo apt-get update
sudo apt-get install docker.io docker-compose

# 2. Clone المستودع
git clone https://github.com/abnalhag2022-droid/sales-price-assistant-pro.git
cd sales-price-assistant-pro

# 3. تشغيل Docker Compose
docker-compose up -d

# 4. التحقق من الحالة
docker-compose ps
URLs بعد الإطلاق
- API: http://your-server:8000
- Docs: http://your-server:8000/docs
- Health: http://your-server:8000/health
📊 Post-Deployment Checks
# 1. تحقق من الـ API
curl http://your-server:8000/health

# 2. تحقق من قاعدة البيانات
docker-compose logs db

# 3. تحقق من الخدمة
docker-compose logs app

# 4. اختبر endpoint
curl -X POST http://your-server:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"test"}'
🔐 إعدادات الأمان
Environment Variables
أنشئ ملف .env.production:
DATABASE_URL=postgresql://user:pass@db:5432/sales_db
SECRET_KEY=your-secret-key-here-change-this
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
ENVIRONMENT=production
قاعدة البيانات
# Backup تلقائي يومي
0 2 * * * /path/to/backup-script.sh
📈 المراقبة
Logs
# Real-time logs
docker-compose logs -f app

# API logs
docker-compose logs app | grep "POST\|GET\|DELETE"
Health Checks
# Automated health check every 5 minutes
*/5 * * * * curl http://localhost:8000/health
🐛 Troubleshooting
المشكلة: API غير متجاوب
# الحل:
docker-compose restart app
docker-compose logs app
المشكلة: Database connection error
# الحل:
docker-compose down
docker-compose up -d
المشكلة: Port مشغول
# الحل:
lsof -i :8000
kill -9 <PID>
📞 الدعم
للمساعدة:
الموقع: https://github.com/abnalhag2022-droid/sales-price-assistant-pro
Issues: https://github.com/abnalhag2022-droid/sales-price-assistant-pro/issues
