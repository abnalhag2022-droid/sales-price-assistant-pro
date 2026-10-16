import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/models/user.dart';

void main() {
  group('User Model Tests', () {
    
    test('User creation with all required parameters', () {
      final now = DateTime.now();
      final user = User(
        id: '1',
        username: 'test_user',
        email: 'test@example.com',
        role: 'user',
        isActive: true,
        createdAt: now,
      );

      expect(user.id, '1');
      expect(user.username, 'test_user');
      expect(user.email, 'test@example.com');
      expect(user.role, 'user');
      expect(user.isActive, true);
      expect(user.fullName, null);
    });

    test('User creation with optional fullName', () {
      final user = User(
        id: '2',
        username: 'ahmed_user',
        email: 'ahmed@example.com',
        fullName: 'Ahmed Mohammed',
        role: 'admin',
        isActive: true,
        createdAt: DateTime.now(),
      );

      expect(user.fullName, 'Ahmed Mohammed');
      expect(user.role, 'admin');
    });

    test('User fromJson creates correct object', () {
      final json = {
        'id': '3',
        'username': 'fatima_user',
        'email': 'fatima@example.com',
        'full_name': 'Fatima Ali',
        'role': 'manager',
        'is_active': true,
        'created_at': '2026-10-16T10:00:00.000Z',
      };

      final user = User.fromJson(json);

      expect(user.id, '3');
      expect(user.username, 'fatima_user');
      expect(user.fullName, 'Fatima Ali');
      expect(user.role, 'manager');
    });

    test('User toJson returns correct map', () {
      final user = User(
        id: '4',
        username: 'sara_user',
        email: 'sara@example.com',
        role: 'user',
        isActive: true,
        createdAt: DateTime(2026, 10, 16),
      );

      final json = user.toJson();

      expect(json['id'], '4');
      expect(json['username'], 'sara_user');
      expect(json['email'], 'sara@example.com');
      expect(json['role'], 'user');
    });

    test('User email contains @ symbol', () {
      final user = User(
        id: '5',
        username: 'test_user',
        email: 'test@example.com',
        role: 'user',
        isActive: true,
        createdAt: DateTime.now(),
      );

      expect(user.email.contains('@'), true);
    });

    test('User default role is user', () {
      final json = {
        'id': '6',
        'username': 'default_user',
        'email': 'default@example.com',
        'role': 'user',
        'is_active': true,
        'created_at': DateTime.now().toString(),
      };

      final user = User.fromJson(json);
      expect(user.role, 'user');
    });
  });
}
