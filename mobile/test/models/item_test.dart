import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/models/item.dart';

void main() {
  group('Item Model Tests', () {
    
    test('Item creation with required parameters only', () {
      final item = Item(
        id: 'ITEM001',
        code: 'RICE001',
        nameAr: 'أرز أبيض',
        basePrice: 50.0,
      );

      expect(item.id, 'ITEM001');
      expect(item.code, 'RICE001');
      expect(item.nameAr, 'أرز أبيض');
      expect(item.basePrice, 50.0);
      expect(item.unit, 'piece');
      expect(item.stock, 0);
    });

    test('Item creation with all optional parameters', () {
      final item = Item(
        id: 'ITEM002',
        code: 'OIL001',
        nameAr: 'زيت نباتي',
        nameEn: 'Vegetable Oil',
        description: 'Premium quality oil',
        category: 'oils',
        basePrice: 120.0,
        unit: 'liter',
        stock: 100.0,
      );

      expect(item.nameEn, 'Vegetable Oil');
      expect(item.description, 'Premium quality oil');
      expect(item.category, 'oils');
      expect(item.unit, 'liter');
      expect(item.stock, 100.0);
    });

    test('Item fromJson creates correct object', () {
      final json = {
        'id': 'ITEM003',
        'code': 'SUGAR001',
        'name_ar': 'سكر أبيض',
        'name_en': 'White Sugar',
        'description': 'Pure white sugar',
        'category': 'sugar',
        'base_price': 35.0,
        'unit': 'kg',
        'stock': 500.0,
      };

      final item = Item.fromJson(json);

      expect(item.id, 'ITEM003');
      expect(item.code, 'SUGAR001');
      expect(item.nameAr, 'سكر أبيض');
      expect(item.basePrice, 35.0);
      expect(item.unit, 'kg');
    });

    test('Item toJson returns correct map', () {
      final item = Item(
        id: 'ITEM004',
        code: 'FLOUR001',
        nameAr: 'دقيق فاخر',
        basePrice: 45.0,
        unit: 'kg',
        stock: 250.0,
      );

      final json = item.toJson();

      expect(json['id'], 'ITEM004');
      expect(json['code'], 'FLOUR001');
      expect(json['name_ar'], 'دقيق فاخر');
      expect(json['base_price'], 45.0);
    });

    test('Item price validation', () {
      final item = Item(
        id: 'ITEM005',
        code: 'ITEM005',
        nameAr: 'منتج اختبار',
        basePrice: 100.0,
      );

      expect(item.basePrice, greaterThan(0));
      expect(item.basePrice, 100.0);
    });

    test('Item default unit is piece', () {
      final item = Item(
        id: 'ITEM006',
        code: 'DEFAULT001',
        nameAr: 'منتج افتراضي',
        basePrice: 25.0,
      );

      expect(item.unit, 'piece');
    });

    test('Item code is not empty', () {
      final item = Item(
        id: 'ITEM007',
        code: 'CODE007',
        nameAr: 'منتج مع كود',
        basePrice: 60.0,
      );

      expect(item.code.isNotEmpty, true);
    });
  });
}
