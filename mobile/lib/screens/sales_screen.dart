import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';
import 'customer_list_screen.dart';
import 'item_search_screen.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  Customer? _selectedCustomer;
  final List<SalesItem> _cartItems = [];
  double _discountPercent = 0;
  final NetworkStatusService _networkStatus = NetworkStatusService();
  final OfflineStorageService _offlineStorage = OfflineStorageService();

  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.total);

  double get _discountAmount => _subtotal * (_discountPercent / 100);

  double get _total => _subtotal - _discountAmount;

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
      setState(() {
        final existingItem = _cartItems.indexWhere((e) => e.code == item.code);
        if (existingItem != -1) {
          _cartItems[existingItem] = SalesItem(
            code: item.code,
            nameAr: item.nameAr,
            quantity: _cartItems[existingItem].quantity + 1,
            price: item.basePrice,
          );
        } else {
          _cartItems.add(SalesItem(
            code: item.code,
            nameAr: item.nameAr,
            quantity: 1,
            price: item.basePrice,
          ));
        }
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  Future<void> _completeSale() async {
    if (_selectedCustomer == null || _cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختر عميل وأضف أصنافاً')),
      );
      return;
    }

    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    final idempotencyKey = DateTime.now().toIso8601String();

    try {
      if (_networkStatus.isOnline) {
        // الإرسال الفوري عند الاتصال
        final payload = {
          'customerId': _selectedCustomer!.id,
          'items': _cartItems
              .map((e) => {
                    'itemId': e.code,
                    'quantity': e.quantity,
                    'price': e.price,
                  })
              .toList(),
          'totalAmount': _total,
          'discount': _discountAmount,
        };

        await ApiService.createSale(payload);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ تمت المعاملة بنجاح')),
        );
      } else {
        // الحفظ المحلي عند عدم الاتصال
        await _offlineStorage.addToSyncQueue(
          endpoint: '/api/v1/sales',
          method: 'POST',
          payload: {
            'customerId': _selectedCustomer!.id,
            'items': _cartItems
                .map((e) => {
                      'itemId': e.code,
                      'quantity': e.quantity,
                      'price': e.price,
                    })
                .toList(),
            'totalAmount': _total,
            'discount': _discountAmount,
          },
          idempotencyKey: idempotencyKey,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('📱 تم الحفظ محلياً - سيتم التزامن تلقائياً'),
          ),
        );
      }

      setState(() {
        _selectedCustomer = null;
        _cartItems.clear();
        _discountPercent = 0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ خطأ: $e')),
      );
    }
  }

  void _suspendSale() {
    if (_selectedCustomer == null || _cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا توجد معاملة لتعليق')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ تم تعليق المعاملة')),
    );

    setState(() {
      _selectedCustomer = null;
      _cartItems.clear();
      _discountPercent = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نقاط البيع'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _networkStatus.isOnline
                      ? Colors.green[100]
                      : Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _networkStatus.isOnline ? '🟢 متصل' : '🔴 غير متصل',
                  style: TextStyle(
                    color: _networkStatus.isOnline
                        ? Colors.green[700]
                        : Colors.red[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اختيار العميل
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'العميل',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    if (_selectedCustomer != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_selectedCustomer!.nameAr),
                          Text('رقم العميل: ${_selectedCustomer!.id}'),
                        ],
                      )
                    else
                      const Text('لم يتم اختيار عميل'),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _selectCustomer,
                      icon: const Icon(Icons.person),
                      label: const Text('اختر عميل'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // سلة المشتريات
            const Text(
              'السلة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (_cartItems.isNotEmpty)
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(item.nameAr),
                          subtitle:
                              Text('${item.quantity} × ${item.price} ر.س'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeItem(index),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add),
                    label: const Text('إضافة صنف'),
                  ),
                ],
              )
            else
              Center(
                child: Column(
                  children: [
                    const Text('السلة فارغة'),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _addItem,
                      icon: const Icon(Icons.add),
                      label: const Text('إضافة صنف'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            // الخصم
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الخصم (%)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _discountPercent = double.tryParse(value) ?? 0;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'أدخل نسبة الخصم',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // الإجمالي
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المجموع الفرعي:'),
                        Text('${_subtotal.toStringAsFixed(2)} ر.س'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('الخصم:'),
                        Text('-${_discountAmount.toStringAsFixed(2)} ر.س'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'الإجمالي:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_total.toStringAsFixed(2)} ر.س',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // الأزرار
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _suspendSale,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('تعليق'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _completeSale,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('إكمال'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SalesItem {
  final String code;
  final String nameAr;
  final int quantity;
  final double price;

  double get total => quantity * price;

  SalesItem({
    required this.code,
    required this.nameAr,
    required this.quantity,
    required this.price,
  });
}
