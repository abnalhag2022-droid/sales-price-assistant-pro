import 'package:flutter/material.dart';
import '../models/index.dart';

class SessionHistoryScreen extends StatefulWidget {
  const SessionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SessionHistoryScreen> createState() => _SessionHistoryScreenState();
}

class _SessionHistoryScreenState extends State<SessionHistoryScreen> {
  final List<HistoryItem> _history = [
    HistoryItem(
      id: '1',
      customerName: 'محمد أحمد',
      amount: 1500,
      itemCount: 5,
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'مكتمل',
    ),
    HistoryItem(
      id: '2',
      customerName: 'فاطمة علي',
      amount: 2300,
      itemCount: 8,
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'مكتمل',
    ),
    HistoryItem(
      id: '3',
      customerName: 'سارة محمود',
      amount: 800,
      itemCount: 3,
      date: DateTime.now(),
      status: 'معلق',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل المعاملات'),
        centerTitle: true,
      ),
      body: _history.isEmpty
          ? const Center(child: Text('لا توجد معاملات'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    title: Text(item.customerName),
                    subtitle: Text(
                      '${item.amount} ر.س - ${item.itemCount} أصناف',
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: item.status == 'مكتمل'
                            ? Colors.green[100]
                            : Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.status,
                        style: TextStyle(
                          color: item.status == 'مكتمل'
                              ? Colors.green[700]
                              : Colors.orange[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('رقم المعاملة: ${item.id}'),
                            const SizedBox(height: 8),
                            Text('التاريخ: ${item.date.toString().split(' ')[0]}'),
                            const SizedBox(height: 8),
                            Text('عدد الأصناف: ${item.itemCount}'),
                            const SizedBox(height: 8),
                            Text('المبلغ الإجمالي: ${item.amount} ر.س'),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('تم طباعة الفاتورة'),
                                        ),
                                      );
                                    },
                                    child: const Text('طباعة'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('تم حفظ الفاتورة'),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: const Text('حفظ'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class HistoryItem {
  final String id;
  final String customerName;
  final double amount;
  final int itemCount;
  final DateTime date;
  final String status;

  HistoryItem({
    required this.id,
    required this.customerName,
    required this.amount,
    required this.itemCount,
    required this.date,
    required this.status,
  });
}
