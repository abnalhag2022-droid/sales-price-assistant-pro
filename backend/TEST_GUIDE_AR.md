# دليل الاختبارات - Backend

## التشغيل من مجلد المشروع الجذر

cd backend
pip install pytest
pytest

## تشغيل اختبارات محددة

pytest tests/test_auth.py
pytest tests/test_api.py

## مع التقارير المفصلة

pytest -v
pytest -v --tb=short

## قياس التغطية

pip install pytest-cov
pytest --cov=app tests/

## هيكل الاختبارات

backend/tests/
├── test_auth.py
├── test_api.py
└── __init__.py

## معايير الاختبارات
✅ جميع endpoints تم اختبارها
✅ التحقق من صحة البيانات
✅ اختبارات الأخطاء
✅ اختبارات النجاح

## النتائج المتوقعة

collected 8 items

tests/test_auth.py::test_hash_password PASSED
tests/test_auth.py::test_user_creation PASSED
tests/test_auth.py::test_user_validation PASSED
tests/test_auth.py::test_password_requirements PASSED
tests/test_api.py::test_health_endpoint PASSED
tests/test_api.py::test_auth_endpoint PASSED
tests/test_api.py::test_items_endpoint PASSED
tests/test_api.py::test_customer_endpoint PASSED

======================== 8 passed in 0.45s ========================
