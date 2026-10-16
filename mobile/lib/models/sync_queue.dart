class SyncQueueItem {
  final String id;
  final String endpoint;
  final String method; // POST, PUT, DELETE
  final Map<String, dynamic> payload;
  final DateTime createdAt;
  final int retryCount;
  final String status; // pending, syncing, failed, completed
  final String idempotencyKey;

  SyncQueueItem({
    required this.id,
    required this.endpoint,
    required this.method,
    required this.payload,
    required this.createdAt,
    this.retryCount = 0,
    this.status = 'pending',
    required this.idempotencyKey,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'endpoint': endpoint,
    'method': method,
    'payload': payload,
    'createdAt': createdAt.toIso8601String(),
    'retryCount': retryCount,
    'status': status,
    'idempotencyKey': idempotencyKey,
  };

  factory SyncQueueItem.fromJson(Map<String, dynamic> json) =>
    SyncQueueItem(
      id: json['id'] as String,
      endpoint: json['endpoint'] as String,
      method: json['method'] as String,
      payload: json['payload'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      retryCount: json['retryCount'] as int? ?? 0,
      status: json['status'] as String? ?? 'pending',
      idempotencyKey: json['idempotencyKey'] as String,
    );
}

class OfflineSession {
  final String id;
  final String customerId;
  final List<OfflineSessionItem> items;
  final double totalAmount;
  final double discount;
  final DateTime createdAt;
  final String status; // draft, pending, synced

  OfflineSession({
    required this.id,
    required this.customerId,
    required this.items,
    required this.totalAmount,
    required this.discount,
    required this.createdAt,
    this.status = 'draft',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'customerId': customerId,
    'items': items.map((e) => e.toJson()).toList(),
    'totalAmount': totalAmount,
    'discount': discount,
    'createdAt': createdAt.toIso8601String(),
    'status': status,
  };

  factory OfflineSession.fromJson(Map<String, dynamic> json) =>
    OfflineSession(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      items: (json['items'] as List)
          .map((e) => OfflineSessionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String? ?? 'draft',
    );
}

class OfflineSessionItem {
  final String itemId;
  final String itemName;
  final int quantity;
  final double price;
  final double total;

  OfflineSessionItem({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
    'itemId': itemId,
    'itemName': itemName,
    'quantity': quantity,
    'price': price,
    'total': total,
  };

  factory OfflineSessionItem.fromJson(Map<String, dynamic> json) =>
    OfflineSessionItem(
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
}
