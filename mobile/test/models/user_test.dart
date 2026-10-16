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

    test('User username not empty', () {
      final user = User(
        id: '2',
        username: 'ahmed_user',
        email: 'ahmed@example.com',
      );

      expect(user.username.isNotEmpty, true);
    });

    test('User email contains at symbol', () {
      final user = User(
        id: '3',
        username: 'fatima_user',
        email: 'fatima@example.com',
      );

      expect(user.email.contains('@'), true);
    });
  });
}
