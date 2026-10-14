class Customer {
  final String id;
  final String code;
  final String nameAr;
  final String? nameEn;
  final String? phone;
  final String? email;
  final String? address;
  final double creditLimit;
  final double discountPercentage;

  Customer({
    required this.id,
    required this.code,
    required this.nameAr,
    this.nameEn,
    this.phone,
    this.email,
    this.address,
    this.creditLimit = 0,
    this.discountPercentage = 0,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      creditLimit: (json['credit_limit'] ?? 0).toDouble(),
      discountPercentage: (json['discount_percentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name_ar': nameAr,
      'name_en': nameEn,
      'phone': phone,
      'email': email,
      'address': address,
      'credit_limit': creditLimit,
      'discount_percentage': discountPercentage,
    };
  }

  @override
  String toString() => 'Customer(id: $id, code: $code, nameAr: $nameAr)';
}
