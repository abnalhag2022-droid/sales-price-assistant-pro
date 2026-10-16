import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/models/index.dart';

void main() {
  group('Customer Model Tests', () {
    
    test('Create customer with correct values', () {
      final customer = Customer(
        id: 'CUST001',
        nameAr: 'محمد أحمد',
        phone: '0501234567',
      );

      expect(customer.id, 'CUST001');
      expect(customer.nameAr, 'محمد أحمد');
      expect(customer.phone, '0501234567');
    });

    test('Customer fromJson parsing', () {
      final json = {
        'id': 'CUST001',
        'name_ar': 'محمد أحمد',
        'phone': '0501234567',
      };

      final customer = Customer.fromJson(json);

      expect(customer.id, 'CUST001');
      expect(customer.nameAr, 'محمد أحمد');
      expect(customer.phone, '0501234567');
    });

    test('Customer phone length validation', () {
      final customer = Customer(
        id: 'CUST001',
        nameAr: 'محمد أحمد',
        phone: '0501234567',
      );

      expect(customer.phone.length, 10);
    });
  });
}
