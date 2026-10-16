import 'package:flutter/material.dart';
import '../models/index.dart';
import 'customer_list_screen.dart';
import 'item_search_screen.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  Customer? _selectedCustomer;
  List<SessionItem> _sessionItems = [];
  double _totalAmount = 0;
  double _discountPercentage = 0;

  Future<void> _selectCustomer() async {
    final customer = await Navigator.push<Customer>(
      context,
      MaterialPageRoute(builder: (context) => const CustomerListScreen()),
    );

    if (customer != null) {
      setState(() {
        _selectedCustomer = customer;
      });
    }
  }

  Future<void> _addItem() async {
    final item = await Navigator.push<Item>(
      context,
      MaterialPageRoute(builder: (context) => const ItemSearchScreen()),
    );

    if (item != null) {
      _showAddItemDialog(item);
    }
  }

  void _showAddItemDialog(Item item) {
    final quantityController = TextEditingController(text: '1');
    final priceController = TextEditingController(text: item.basePrice.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة صنف'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('الصنف: ${item.nameAr}'),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'الكمية',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'السعر',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = double.tryParse(quantityController.text) ?? 1;
              final price = double.tryParse(priceController.text) ?? item.basePrice;
              final totalPrice = quantity * price;

              final sessionItem = SessionItem(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                sessionId: '',
                item: item,
                quantity: quantity,
                unitPrice: price,
                totalPrice: totalPrice,
              );

              setState(() {
                _sessionItems.add(sessionItem);
                _calculateTotal();
              });

              Navigator.pop(context);
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _removeItem(int index) {
    setState(() {
      _sessionItems.removeAt(index);
      _calculateTotal();
    });
  }

  void _calculateTotal() {
    _totalAmount = _sessionItems.fold(0, (sum, item) => sum + item.finalPrice);
  }

  void _completeSale() {
    if (_selectedCustomer == null || _sessionItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختر عميل وأضف أصناف')),
      );
      return;
    }

    final discountAmount = _totalAmount * (_discountPercentage / 100);
    final finalAmount = _totalAmount - discountAmount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد البيع'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('العميل: ${_selectedCustomer!.nameAr}'),
            const SizedBox(height: 8),
            Text('الإجمالي: $_totalAmount ر.س'),
            Text('الخصم: $discountAmount ر.س'),
            Text(
              'المبلغ النهائي: $finalAmount ر.س',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إكمال البيع بنجاح')),
              );
              Navigator.pop(context);
              _resetForm();
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _selectedCustomer = null;
      _sessionItems = [];
      _totalAmount = 0;
      _discountPercentage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نقاط البيع'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // العميل
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('العميل'),
                      Text(
                        _selectedCustomer?.nameAr ?? 'لم يتم اختيار عميل',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _selectCustomer,
                  child: const Text('اختر'),
                ),
              ],
            ),
          ),
          // الأصناف
          Expanded(
            child: _sessionItems.isEmpty
                ? const Center(child: Text('لم يتم إضافة أصناف'))
                : ListView.builder(
                    itemCount: _sessionItems.length,
                    itemBuilder: (context, index) {
                      final item = _sessionItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(item.item.nameAr),
                          subtitle: Text(
                            'الكمية: ${item.quantity} × ${item.unitPrice} = ${item.finalPrice}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // الملخص
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('الإجمالي:'),
                    Text(
                      '$_totalAmount ر.س',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('نسبة الخصم:'),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _discountPercentage = double.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: '0',
                          suffix: Text('%'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _addItem,
                        child: const Text('إضافة صنف'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _completeSale,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('إكمال البيع'),
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
  }
}
