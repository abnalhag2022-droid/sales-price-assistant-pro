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

    test('Customer phone length validation', () {
      final customer = Customer(
        id: 'CUST002',
        nameAr: 'فاطمة علي',
        phone: '0509876543',
      );

      expect(customer.phone.length, 10);
    });

    test('Customer name not empty', () {
      final customer = Customer(
        id: 'CUST003',
        nameAr: 'سارة محمود',
        phone: '0505555555',
      );

      expect(customer.nameAr.isNotEmpty, true);
    });
  });
}
