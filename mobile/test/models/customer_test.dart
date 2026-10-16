import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/models/customer.dart';

void main() {
  group('Customer Model Tests', () {
    
    test('Customer creation with required parameters only', () {
      final customer = Customer(
        id: 'CUST001',
        code: 'C001',
        nameAr: 'محمد أحمد',
      );

      expect(customer.id, 'CUST001');
      expect(customer.code, 'C001');
      expect(customer.nameAr, 'محمد أحمد');
      expect(customer.creditLimit, 0);
      expect(customer.discountPercentage, 0);
    });

    test('Customer creation with all optional parameters', () {
      final customer = Customer(
        id: 'CUST002',
        code: 'C002',
        nameAr: 'فاطمة علي',
        nameEn: 'Fatima Ali',
        phone: '0501234567',
        email: 'fatima@example.com',
        address: 'Riyadh, Saudi Arabia',
        creditLimit: 5000.0,
        discountPercentage: 10.0,
      );

      expect(customer.nameEn, 'Fatima Ali');
      expect(customer.phone, '0501234567');
      expect(customer.creditLimit, 5000.0);
      expect(customer.discountPercentage, 10.0);
    });

    test('Customer fromJson creates correct object', () {
      final json = {
        'id': 'CUST003',
        'code': 'C003',
        'name_ar': 'سارة محمود',
        'name_en': 'Sarah Mahmoud',
        'phone': '0509876543',
        'email': 'sarah@example.com',
        'address': 'Jeddah, Saudi Arabia',
        'credit_limit': 3000,
        'discount_percentage': 5,
      };

      final customer = Customer.fromJson(json);

      expect(customer.id, 'CUST003');
      expect(customer.code, 'C003');
      expect(customer.nameAr, 'سارة محمود');
      expect(customer.creditLimit, 3000.0);
    });

    test('Customer toJson returns correct map', () {
      final customer = Customer(
        id: 'CUST004',
        code: 'C004',
        nameAr: 'أحمد محمود',
        phone: '0505555555',
        creditLimit: 2000.0,
      );

      final json = customer.toJson();

      expect(json['id'], 'CUST004');
      expect(json['code'], 'C004');
      expect(json['name_ar'], 'أحمد محمود');
      expect(json['credit_limit'], 2000.0);
    });

    test('Customer phone validation', () {
      final customer = Customer(
        id: 'CUST005',
        code: 'C005',
        nameAr: 'علي محمد',
        phone: '0501111111',
      );

      expect(customer.phone, '0501111111');
      expect(customer.phone!.length, 10);
    });

    test('Customer default values', () {
      final customer = Customer(
        id: 'CUST006',
        code: 'C006',
        nameAr: 'ليلى أحمد',
      );

      expect(customer.creditLimit, 0);
      expect(customer.discountPercentage, 0);
      expect(customer.nameEn, null);
    });
  });
}
