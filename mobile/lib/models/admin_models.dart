class UserRole {
  final String id;
  final String nameAr;
  final List<String> permissions;

  UserRole({
    required this.id,
    required this.nameAr,
    required this.permissions,
  });

  factory UserRole.admin() => UserRole(
    id: 'admin',
    nameAr: 'مسؤول',
    permissions: [
      'view_dashboard',
      'manage_users',
      'view_reports',
      'manage_inventory',
      'export_data',
      'view_audit_log',
    ],
  );

  factory UserRole.manager() => UserRole(
    id: 'manager',
    nameAr: 'مدير',
    permissions: [
      'view_dashboard',
      'view_reports',
      'manage_inventory',
      'export_data',
    ],
  );

  factory UserRole.user() => UserRole(
    id: 'user',
    nameAr: 'مستخدم',
    permissions: [
      'create_sales',
      'view_customer_info',
    ],
  );

  bool hasPermission(String permission) => permissions.contains(permission);
}

class DashboardStats {
  final int totalSales;
  final double totalRevenue;
  final int totalCustomers;
  final int activeUsers;
  final List<DailySalesData> salesTrend;
  final List<TopSellingItem> topItems;

  DashboardStats({
    required this.totalSales,
    required this.totalRevenue,
    required this.totalCustomers,
    required this.activeUsers,
    required this.salesTrend,
    required this.topItems,
  });
}

class DailySalesData {
  final String date;
  final double amount;
  final int count;

  DailySalesData({
    required this.date,
    required this.amount,
    required this.count,
  });
}

class TopSellingItem {
  final String itemName;
  final int quantity;
  final double revenue;

  TopSellingItem({
    required this.itemName,
    required this.quantity,
    required this.revenue,
  });
}

class AuditLog {
  final String id;
  final String userId;
  final String action;
  final String details;
  final DateTime timestamp;

  AuditLog({
    required this.id,
    required this.userId,
    required this.action,
    required this.details,
    required this.timestamp,
  });
}
