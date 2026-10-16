import 'package:flutter/material.dart';

class PendingSessionsScreen extends StatefulWidget {
  const PendingSessionsScreen({Key? key}) : super(key: key);

  @override
  State<PendingSessionsScreen> createState() => _PendingSessionsScreenState();
}

class _PendingSessionsScreenState extends State<PendingSessionsScreen> {
  final List<PendingSession> _sessions = [
    PendingSession(
      id: '1',
      customerName: 'أحمد محمود',
      totalAmount: 1200,
      itemCount: 4,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    PendingSession(
      id: '2',
      customerName: 'ليلى علي',
      totalAmount: 850,
      itemCount: 3,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  void _continueSession(PendingSession session) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('استئناف معاملة ${session.customerName}')),
    );
  }

  void _deleteSession(int index) {
    setState(() {
      _sessions.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف المعاملة')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المعاملات المعلقة'),
        centerTitle: true,
      ),
      body: _sessions.isEmpty
          ? const Center(child: Text('لا توجد معاملات معلقة'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _sessions.length,
              itemBuilder: (context, index) {
                final session = _sessions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.pause),
                    ),
                    title: Text(session.customerName),
                    subtitle: Text(
                      '${session.totalAmount} ر.س - ${session.itemCount} أصناف',
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () => _continueSession(session),
                          child: const Text('استئناف'),
                        ),
                        PopupMenuItem(
                          onTap: () => _deleteSession(index),
                          child: const Text('حذف'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class PendingSession {
  final String id;
  final String customerName;
  final double totalAmount;
  final int itemCount;
  final DateTime createdAt;

  PendingSession({
    required this.id,
    required this.customerName,
    required this.totalAmount,
    required this.itemCount,
    required this.createdAt,
  });
}
