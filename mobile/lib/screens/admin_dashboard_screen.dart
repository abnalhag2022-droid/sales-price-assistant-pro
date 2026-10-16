import 'package:flutter/material.dart';
import '../models/index.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final DashboardStats stats = DashboardStats(
    totalSales: 156,
    totalRevenue: 45320.00,
    totalCustomers: 48,
    activeUsers: 12,
    salesTrend: [
      DailySalesData(date: 'السبت', amount: 2400, count: 8),
      DailySalesData(date: 'الأحد', amount: 3210, count: 12),
      DailySalesData(date: 'الاثنين', amount: 2290, count: 9),
      DailySalesData(date: 'الثلاثاء', amount: 2000, count: 7),
      DailySalesData(date: 'الأربعاء', amount: 2181, count: 8),
      DailySalesData(date: 'الخميس', amount: 2500, count: 10),
      DailySalesData(date: 'الجمعة', amount: 2100, count: 6),
    ],
    topItems: [
      TopSellingItem(itemName: 'أرز أبيض', quantity: 245, revenue: 12250),
      TopSellingItem(itemName: 'زيت نباتي', quantity: 128, revenue: 15360),
      TopSellingItem(itemName: 'سكر أبيض', quantity: 310, revenue: 10850),
      TopSellingItem(itemName: 'دقيق فاخر', quantity: 180, revenue: 8100),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الإحصائيات الرئيسية
            const Text(
              'الإحصائيات الرئيسية',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _StatCard(
                  title: 'إجمالي المبيعات',
                  value: stats.totalSales.toString(),
                  unit: 'عملية',
                  color: Colors.blue,
                ),
                _StatCard(
                  title: 'الإيرادات',
                  value: stats.totalRevenue.toStringAsFixed(0),
                  unit: 'ر.س',
                  color: Colors.green,
                ),
                _StatCard(
                  title: 'العملاء',
                  value: stats.totalCustomers.toString(),
                  unit: 'عميل',
                  color: Colors.orange,
                ),
                _StatCard(
                  title: 'المستخدمون النشطون',
                  value: stats.activeUsers.toString(),
                  unit: 'مستخدم',
                  color: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 32),
            // أفضل الأصناف مبيعاً
            const Text(
              'أفضل الأصناف مبيعاً',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stats.topItems.length,
                itemBuilder: (context, index) {
                  final item = stats.topItems[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(item.itemName),
                    subtitle: Text('${item.quantity} وحدة'),
                    trailing: Text(
                      '${item.revenue.toStringAsFixed(0)} ر.س',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // أداء المبيعات اليومي
            const Text(
              'أداء المبيعات (آخر 7 أيام)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: stats.salesTrend.length,
                      itemBuilder: (context, index) {
                        final data = stats.salesTrend[index];
                        final maxAmount = stats.salesTrend
                            .map((e) => e.amount)
                            .reduce((a, b) => a > b ? a : b);
                        final barWidth =
                            (data.amount / maxAmount) * 200;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data.date),
                                  Text(
                                    '${data.amount.toStringAsFixed(0)} ر.س',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Container(
                                  height: 24,
                                  color: Colors.blue[200],
                                  child: FractionallySizedBox(
                                    widthFactor: barWidth / 200,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          '${data.count}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              unit,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
