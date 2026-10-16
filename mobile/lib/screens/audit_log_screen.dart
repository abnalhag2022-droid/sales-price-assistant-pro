import 'package:flutter/material.dart';
import '../models/index.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({Key? key}) : super(key: key);

  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  final List<AuditLog> _logs = [
    AuditLog(
      id: '1',
      userId: 'ahmed_admin',
      action: 'تسجيل دخول',
      details: 'تسجيل الدخول من 192.168.1.100',
      timestamp: DateTime.now(),
    ),
    AuditLog(
      id: '2',
      userId: 'fatima_manager',
      action: 'إنشاء معاملة',
      details: 'معاملة رقم 2024-001 بمبلغ 2500 ر.س',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    AuditLog(
      id: '3',
      userId: 'sara_user',
      action: 'تحديث العميل',
      details: 'تحديث بيانات العميل CUST001',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    AuditLog(
      id: '4',
      userId: 'ahmed_admin',
      action: 'حذف مستخدم',
      details: 'حذف حساب المستخدم inactive_user',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    AuditLog(
      id: '5',
      userId: 'fatima_manager',
      action: 'تصدير تقرير',
      details: 'تصدير تقرير المبيعات لشهر سبتمبر',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  String _getActionColor(String action) {
    if (action.contains('دخول')) return 'الأزرق';
    if (action.contains('إنشاء')) return 'الأخضر';
    if (action.contains('تحديث')) return 'البرتقالي';
    if (action.contains('حذف')) return 'الأحمر';
    return 'الرمادي';
  }

  Color _getActionBgColor(String action) {
    if (action.contains('دخول')) return Colors.blue[100]!;
    if (action.contains('إنشاء')) return Colors.green[100]!;
    if (action.contains('تحديث')) return Colors.orange[100]!;
    if (action.contains('حذف')) return Colors.red[100]!;
    return Colors.grey[100]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل التدقيق'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          final log = _logs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getActionBgColor(log.action),
                child: Icon(
                  log.action.contains('دخول')
                      ? Icons.login
                      : log.action.contains('إنشاء')
                          ? Icons.add
                          : log.action.contains('تحديث')
                              ? Icons.edit
                              : log.action.contains('حذف')
                                  ? Icons.delete
                                  : Icons.info,
                  color: Colors.black,
                ),
              ),
              title: Text(log.action),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    log.details,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'المستخدم: ${log.userId}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                log.timestamp.hour.toString().padLeft(2, '0') +
                    ':' +
                    log.timestamp.minute.toString().padLeft(2, '0'),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
