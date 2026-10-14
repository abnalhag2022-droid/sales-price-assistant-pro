import 'dart:async';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  // محاكاة قاعدة بيانات محلية
  final Map<String, dynamic> _storage = {};

  // حفظ بيانات
  Future<void> save(String key, dynamic value) async {
    _storage[key] = value;
  }

  // الحصول على بيانات
  Future<dynamic> get(String key) async {
    return _storage[key];
  }

  // حذف بيانات
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  // حذف جميع البيانات
  Future<void> clear() async {
    _storage.clear();
  }

  // التحقق من وجود مفتاح
  Future<bool> contains(String key) async {
    return _storage.containsKey(key);
  }

  // حفظ التوكن
  Future<void> saveToken(String token) async {
    await save('auth_token', token);
  }

  // الحصول على التوكن
  Future<String?> getToken() async {
    return await get('auth_token');
  }

  // حذف التوكن
  Future<void> clearToken() async {
    await delete('auth_token');
  }

  // حفظ بيانات المستخدم
  Future<void> saveUser(Map<String, dynamic> user) async {
    await save('current_user', user);
  }

  // الحصول على بيانات المستخدم
  Future<Map<String, dynamic>?> getUser() async {
    return await get('current_user');
  }

  // حذف بيانات المستخدم
  Future<void> clearUser() async {
    await delete('current_user');
  }

  // تسجيل الخروج
  Future<void> logout() async {
    await clearToken();
    await clearUser();
  }
}
