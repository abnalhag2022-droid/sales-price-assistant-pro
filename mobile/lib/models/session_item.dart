import 'item.dart';

class SessionItem {
  final String id;
  final String sessionId;
  final Item item;
  final double quantity;
  final double unitPrice;
  final double discount;
  final double totalPrice;

  SessionItem({
    required this.id,
    required this.sessionId,
    required this.item,
    required this.quantity,
    required this.unitPrice,
    this.discount = 0,
    required this.totalPrice,
  });

  // حساب السعر النهائي
  double get finalPrice => totalPrice - discount;

  factory SessionItem.fromJson(Map<String, dynamic> json) {
    return SessionItem(
      id: json['id'] ?? '',
      sessionId: json['session_id'] ?? '',
      item: Item.fromJson(json['item']),
      quantity: (json['quantity'] ?? 0).toDouble(),
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      totalPrice: (json['total_price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_id': sessionId,
      'item': item.toJson(),
      'quantity': quantity,
      'unit_price': unitPrice,
      'discount': discount,
      'total_price': totalPrice,
    };
  }

  @override
  String toString() => 'SessionItem(id: $id, item: ${item.nameAr}, qty: $quantity)';
}
