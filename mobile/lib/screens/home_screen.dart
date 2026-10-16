import 'package:flutter/material.dart';
import '../services/index.dart';
import '../models/index.dart';
import 'sales_screen.dart';
import 'inquiry_screen.dart';
import 'session_history_screen.dart';
import 'pending_sessions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = ApiService.getCurrentUser();
  }

  Future<void> _handleLogout() async {
    await StorageService().logout();
    ApiService.clearAuthToken();
    
    if (!mounted) return;
    
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<User>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('خطأ: ${snapshot.error}');
                }

                final user = snapshot.data;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'مرحباً بك',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('المستخدم: ${user?.username}'),
                        Text('البريد الإلكتروني: ${user?.email}'),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'الخيارات الرئيسية',
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
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _MenuCard(
                  title: 'نقاط البيع',
                  icon: Icons.shopping_cart,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SalesScreen(),
                      ),
                    );
                  },
                ),
                _MenuCard(
                  title: 'استعلام السعر',
                  icon: Icons.search,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InquiryScreen(),
                      ),
                    );
                  },
                ),
                _MenuCard(
                  title: 'معاملات معلقة',
                  icon: Icons.pause_circle,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PendingSessionsScreen(),
                      ),
                    );
                  },
                ),
                _MenuCard(
                  title: 'سجل المعاملات',
                  icon: Icons.history,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SessionHistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
