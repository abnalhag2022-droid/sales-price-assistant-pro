import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/models/index.dart';

void main() {
  group('Item Model Tests', () {
    
    test('Create item with correct values', () {
      final item = Item(
        code: 'ITEM001',
        nameAr: 'أرز أبيض',
        basePrice: 50.0,
      );

      expect(item.code, 'ITEM001');
      expect(item.nameAr, 'أرز أبيض');
      expect(item.basePrice, 50.0);
    });

    test('Item price validation', () {
      final item = Item(
        code: 'ITEM001',
        nameAr: 'أرز أبيض',
        basePrice: 100.0,
      );

      expect(item.basePrice, greaterThan(0));
      expect(item.basePrice, 100.0);
    });

    test('Item code not empty', () {
      final item = Item(
        code: 'ITEM002',
        nameAr: 'سكر',
        basePrice: 35.0,
      );

      expect(item.code.isNotEmpty, true);
    });
  });
}
