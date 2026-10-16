import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/models/index.dart';

void main() {
  group('User Model Tests', () {
    test('Create user with correct values', () {
      final user = User(
        id: '1',
        username: 'test_user',
        email: 'test@example.com',
        role: 'sales',
        isActive: true,
        createdAt: DateTime.utc(2026, 1, 1),
      );

      expect(user.id, '1');
      expect(user.username, 'test_user');
      expect(user.email, 'test@example.com');
      expect(user.role, 'sales');
      expect(user.isActive, isTrue);
      expect(user.createdAt, DateTime.utc(2026, 1, 1));
    });

    test('User fromJson parsing', () {
      final user = User.fromJson({
        'id': '1',
        'username': 'test_user',
        'email': 'test@example.com',
        'role': 'sales',
        'is_active': true,
        'created_at': '2026-01-01T00:00:00.000Z',
      });

      expect(user.id, '1');
      expect(user.username, 'test_user');
      expect(user.email, 'test@example.com');
      expect(user.role, 'sales');
      expect(user.isActive, isTrue);
      expect(user.createdAt, DateTime.utc(2026, 1, 1));
    });

    test('User toJson serialization', () {
      final user = User(
        id: '1',
        username: 'test_user',
        email: 'test@example.com',
        role: 'admin',
        isActive: true,
        createdAt: DateTime.utc(2026, 1, 1),
      );

      final json = user.toJson();

      expect(json['id'], '1');
      expect(json['username'], 'test_user');
      expect(json['email'], 'test@example.com');
      expect(json['role'], 'admin');
      expect(json['is_active'], isTrue);
      expect(json['created_at'], '2026-01-01T00:00:00.000Z');
    });
  });
}
