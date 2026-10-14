class Item {
  final String id;
  final String code;
  final String nameAr;
  final String? nameEn;
  final String? description;
  final String? category;
  final double basePrice;
  final String unit;
  final double stock;

  Item({
    required this.id,
    required this.code,
    required this.nameAr,
    this.nameEn,
    this.description,
    this.category,
    required this.basePrice,
    this.unit = 'piece',
    this.stock = 0,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'],
      description: json['description'],
      category: json['category'],
      basePrice: (json['base_price'] ?? 0).toDouble(),
      unit: json['unit'] ?? 'piece',
      stock: (json['stock'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description': description,
      'category': category,
      'base_price': basePrice,
      'unit': unit,
      'stock': stock,
    };
  }

  @override
  String toString() => 'Item(id: $id, code: $code, nameAr: $nameAr)';
}
