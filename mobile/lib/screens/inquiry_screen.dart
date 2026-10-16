import 'package:flutter/material.dart';
import '../models/index.dart';
import 'item_search_screen.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({Key? key}) : super(key: key);

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  Item? _selectedItem;
  List<PriceRecord> _priceHistory = [
    PriceRecord(
      date: DateTime.now().subtract(const Duration(days: 5)),
      price: 100,
      source: 'العميل الخاص',
    ),
    PriceRecord(
      date: DateTime.now().subtract(const Duration(days: 3)),
      price: 95,
      source: 'مجموعة العميل',
    ),
    PriceRecord(
      date: DateTime.now(),
      price: 90,
      source: 'السعر الأساسي',
    ),
  ];

  Future<void> _selectItem() async {
    final item = await Navigator.push<Item>(
      context,
      MaterialPageRoute(builder: (context) => const ItemSearchScreen()),
    );

    if (item != null) {
      setState(() {
        _selectedItem = item;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('استعلام السعر'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اختيار الصنف
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الصنف المختار',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    if (_selectedItem != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الاسم: ${_selectedItem!.nameAr}'),
                          Text('الكود: ${_selectedItem!.code}'),
                          Text('السعر الأساسي: ${_selectedItem!.basePrice} ر.س'),
                        ],
                      )
                    else
                      const Text('لم يتم اختيار صنف'),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _selectItem,
                      icon: const Icon(Icons.search),
                      label: const Text('اختر صنف'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // سجل الأسعار
            const Text(
              'سجل الأسعار',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedItem != null)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _priceHistory.length,
                itemBuilder: (context, index) {
                  final record = _priceHistory[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          '${record.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      title: Text('${record.price} ر.س'),
                      subtitle: Text(record.source),
                      trailing: Text(
                        '${record.date.day}/${record.date.month}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              )
            else
              const Center(
                child: Text('اختر صنفاً لعرض سجل الأسعار'),
              ),
          ],
        ),
      ),
    );
  }
}

class PriceRecord {
  final DateTime date;
  final double price;
  final String source;

  PriceRecord({
    required this.date,
    required this.price,
    required this.source,
  });
}
