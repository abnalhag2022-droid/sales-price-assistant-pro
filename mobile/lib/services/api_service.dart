import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/index.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api/v1';
  static String? _authToken;

  static void setAuthToken(String token) {
    _authToken = token;
  }

  static String? getAuthToken() => _authToken;

  static void clearAuthToken() {
    _authToken = null;
  }

  static Map<String, String> _getHeaders({bool auth = true}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (auth && _authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

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
        return AuthResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      throw Exception('Failed to login: ${response.body}');
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        return User.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      throw Exception('Failed to register: ${response.body}');
    } catch (e) {
      throw Exception('Register error: $e');
    }
  }

  static Future<User> getCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return User.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      throw Exception(
        'Failed to get current user: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      throw Exception('Get user error: $e');
    }
  }

  static Future<List<Item>> getItems({String? query}) async {
    try {
      final uri = Uri.parse('$baseUrl/items/').replace(
        queryParameters:
            query != null && query.isNotEmpty ? {'q': query} : null,
      );

      final response = await http.get(uri, headers: _getHeaders());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((json) => Item.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw Exception(
        'Failed to get items: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      throw Exception('Get items error: $e');
    }
  }

  static Future<Item> getItem(String code) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items/${Uri.encodeComponent(code)}'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        return Item.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      throw Exception(
        'Failed to get item: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      throw Exception('Get item error: $e');
    }
  }

  /// Creates an item through the backend endpoint used by the sync queue.
  static Future<Item> createItem(Map<String, dynamic> payload) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/items/'),
        headers: _getHeaders(),
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Item.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      }
      throw Exception(
        'Failed to create item: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      throw Exception('Create item error: $e');
    }
  }

  static Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8000/health'),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
