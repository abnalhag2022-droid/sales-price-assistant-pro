import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/models/index.dart';

void main() {
  group('User Model Tests', () {
    
    test('Create user with correct values', () {
      final user = User(
        id: '1',
        username: 'test_user',
        email: 'test@example.com',
      );

      expect(user.id, '1');
      expect(user.username, 'test_user');
      expect(user.email, 'test@example.com');
    });

    test('User fromJson parsing', () {
      final json = {
        'id': '1',
        'username': 'test_user',
        'email': 'test@example.com',
      };

      final user = User.fromJson(json);

      expect(user.id, '1');
      expect(user.username, 'test_user');
      expect(user.email, 'test@example.com');
    });

    test('User toJson serialization', () {
      final user = User(
        id: '1',
        username: 'test_user',
        email: 'test@example.com',
      );

      final json = user.toJson();

      expect(json['id'], '1');
      expect(json['username'], 'test_user');
      expect(json['email'], 'test@example.com');
    });
  });
}
