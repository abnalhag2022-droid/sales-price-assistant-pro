import 'customer.dart';
import 'session_item.dart';

class SaleSession {
  final String id;
  final Customer customer;
  final List<SessionItem> items;
  final String status; // open, suspended, completed
  final double totalAmount;
  final double discountAmount;
  final double finalAmount;
  final DateTime createdAt;

  SaleSession({
    required this.id,
    required this.customer,
    required this.items,
    this.status = 'open',
    required this.totalAmount,
    this.discountAmount = 0,
    required this.finalAmount,
    required this.createdAt,
  });

  // حساب الإجمالي
  double get calculatedTotal =>
      items.fold(0, (sum, item) => sum + item.finalPrice);

  factory SaleSession.fromJson(Map<String, dynamic> json) {
    return SaleSession(
      id: json['id'] ?? '',
      customer: Customer.fromJson(json['customer']),
      items: (json['items'] as List?)
              ?.map((item) => SessionItem.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? 'open',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      finalAmount: (json['final_amount'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'status': status,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'final_amount': finalAmount,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() => 'SaleSession(id: $id, customer: ${customer.nameAr}, items: ${items.length})';
}
