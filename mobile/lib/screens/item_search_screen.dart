import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

class ItemSearchScreen extends StatefulWidget {
  const ItemSearchScreen({Key? key}) : super(key: key);

  @override
  State<ItemSearchScreen> createState() => _ItemSearchScreenState();
}

class _ItemSearchScreenState extends State<ItemSearchScreen> {
  final _searchController = TextEditingController();
  List<Item> _items = [
    Item(
      id: '1',
      code: 'ITEM001',
      nameAr: 'أرز أبيض',
      basePrice: 50,
      category: 'غذائيات',
      stock: 100,
    ),
    Item(
      id: '2',
      code: 'ITEM002',
      nameAr: 'زيت نباتي',
      basePrice: 120,
      category: 'غذائيات',
      stock: 50,
    ),
    Item(
      id: '3',
      code: 'ITEM003',
      nameAr: 'سكر أبيض',
      basePrice: 35,
      category: 'غذائيات',
      stock: 150,
    ),
    Item(
      id: '4',
      code: 'ITEM004',
      nameAr: 'دقيق فاخر',
      basePrice: 45,
      category: 'غذائيات',
      stock: 80,
    ),
  ];

  List<Item> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = _items;
      });
    } else {
      setState(() {
        _filteredItems = _items
            .where((item) =>
                item.nameAr.contains(query) || item.code.contains(query))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر صنف'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: 'ابحث عن صنف...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(child: Text('لا توجد أصناف'))
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              item.nameAr[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(item.nameAr),
                          subtitle: Text(
                            'الكود: ${item.code} | المخزون: ${item.stock}',
                          ),
                          trailing: Text(
                            '${item.basePrice} ر.س',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context, item);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
