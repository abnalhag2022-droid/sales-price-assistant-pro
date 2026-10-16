import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({Key? key}) : super(key: key);

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final _searchController = TextEditingController();
  List<Customer> _customers = [
    Customer(
      id: '1',
      code: 'CUST001',
      nameAr: 'محمد أحمد',
      phone: '0501234567',
      creditLimit: 10000,
    ),
    Customer(
      id: '2',
      code: 'CUST002',
      nameAr: 'فاطمة علي',
      phone: '0502345678',
      creditLimit: 15000,
    ),
    Customer(
      id: '3',
      code: 'CUST003',
      nameAr: 'سارة محمود',
      phone: '0503456789',
      creditLimit: 20000,
    ),
  ];

  List<Customer> _filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    _filteredCustomers = _customers;
  }

  void _filterCustomers(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredCustomers = _customers;
      });
    } else {
      setState(() {
        _filteredCustomers = _customers
            .where((customer) =>
                customer.nameAr.contains(query) ||
                customer.code.contains(query))
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
        title: const Text('اختر عميل'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCustomers,
              decoration: InputDecoration(
                hintText: 'ابحث عن عميل...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredCustomers.isEmpty
                ? const Center(child: Text('لا توجد عملاء'))
                : ListView.builder(
                    itemCount: _filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = _filteredCustomers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(customer.nameAr[0]),
                          ),
                          title: Text(customer.nameAr),
                          subtitle: Text(
                            'الكود: ${customer.code} | الهاتف: ${customer.phone}',
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${customer.creditLimit} ر.س',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'حد الائتمان',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context, customer);
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
