import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/index.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.250:8000/api/v1';
  static String? _authToken;

  // تعيين التوكن
  static void setAuthToken(String token) {
    _authToken = token;
  }

  // الحصول على التوكن
  static String? getAuthToken() {
    return _authToken;
  }

  // حذف التوكن
  static void clearAuthToken() {
    _authToken = null;
  }

  // إنشاء headers
  static Map<String, String> _getHeaders({bool auth = true}) {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (auth && _authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  // تسجيل الدخول
  static Future<AuthResponse> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: _getHeaders(auth: false),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  // تسجيل مستخدم جديد
  static Future<User> register(
    String username,
    String email,
    String password,
    String? fullName,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: _getHeaders(auth: false),
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'full_name': fullName,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      throw Exception('Register error: $e');
    }
  }

  // الحصول على بيانات المستخدم الحالي
  static Future<User> getCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Failed to get current user');
      }
    } catch (e) {
      throw Exception('Get user error: $e');
    }
  }

  // الحصول على قائمة الأصناف
  static Future<List<Item>> getItems({String? query}) async {
    try {
      String url = '$baseUrl/items';
      if (query != null && query.isNotEmpty) {
        url += '?q=$query';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Item.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get items');
      }
    } catch (e) {
      throw Exception('Get items error: $e');
    }
  }

  // الحصول على صنف محدد
  static Future<Item> getItem(String code) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items/$code'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Item.fromJson(data);
      } else {
        throw Exception('Failed to get item');
      }
    } catch (e) {
      throw Exception('Get item error: $e');
    }
  }

  // إنشاء صنف جديد
  static Future<void> createItem(Map<String, dynamic> payload) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/items'),
        headers: _getHeaders(),
        body: jsonEncode(payload),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to create item: ${response.body}');
      }
    } catch (e) {
      throw Exception('Create item error: $e');
    }
  }

  // فحص صحة Backend
  static Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.250:8000/health'),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
