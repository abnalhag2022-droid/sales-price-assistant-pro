# دليل البدء السريع - الإنتاج

## للمسؤول النظام

### 1. التثبيت (أول مرة)

```bash
git clone https://github.com/abnalhag2022-droid/sales-price-assistant-pro.git
cd sales-price-assistant-pro
docker-compose up -d
2. التحقق من التثبيت
# هل API يعمل؟
curl http://localhost:8000/health

# هل قاعدة البيانات متصلة؟
docker-compose exec app python -c "from app.database import engine; print('DB OK')"
3. إنشاء حساب المسؤول
docker-compose exec app python -m app.scripts.create_admin
4. دخول Dashboard
http://your-server:8000
Username: admin
Password: [كما أدخلت في الخطوة 3]
للمستخدم النهائي
تحميل التطبيق
Android:
تحميل من Google Play (متوفر قريباً)
أو download APK مباشرة
iOS:
تحميل من App Store (متوفر قريباً)
أول استخدام
فتح التطبيق
تسجيل حساب جديد أو دخول بحساب موجود
اختيار دور المستخدم (موظف/مدير)
ابدأ العمل!
المتطلبات الأدنى
التطبيق: 50 MB مساحة فارغة
الإنترنت: اختياري (يعمل بدونه)
الجهاز: Android 5+ أو iOS 11+
المشاكل الشائعة
Q: التطبيق بطيء؟
A: تحقق من الإنترنت أو أعد تشغيل التطبيق
Q: لا أستطيع تسجيل الدخول؟
A: تأكد من username و password صحيحة
Q: فقدت بياناتي؟
A: البيانات محفوظة بسحابة آمنة
📞 الدعم
الموقع: https://github.com/abnalhag2022-droid/sales-price-assistant-pro
البريد: support@example.com
