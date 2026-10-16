# اختبارات المشروع

## نظرة عامة
يحتوي هذا المجلد على جميع اختبارات المشروع:
- Unit Tests: اختبارات الوحدات للـ Models و Services
- Widget Tests: اختبارات واجهات المستخدم
- Integration Tests: اختبارات التكامل

## تشغيل الاختبارات

### تشغيل جميع الاختبارات
flutter test

### تشغيل اختبارات محددة
flutter test test/models/user_test.dart

### تشغيل مع Coverage
flutter test --coverage

## هيكل الاختبارات

test/
├── models/
│   ├── user_test.dart
│   ├── customer_test.dart
│   └── item_test.dart
├── services/
│   ├── sync_queue_test.dart
│   └── network_status_test.dart
└── README_AR.md

## نسبة التغطية المستهدفة
- Models: 100%
- Services: 90%
- Screens: 70%
- Integration: 80%
