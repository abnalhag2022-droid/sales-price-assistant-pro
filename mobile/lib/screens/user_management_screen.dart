import 'package:flutter/material.dart';
import '../models/index.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final List<UserWithRole> _users = [
    UserWithRole(
      id: '1',
      username: 'ahmed_admin',
      email: 'ahmed@example.com',
      role: UserRole.admin(),
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      isActive: true,
    ),
    UserWithRole(
      id: '2',
      username: 'fatima_manager',
      email: 'fatima@example.com',
      role: UserRole.manager(),
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      isActive: true,
    ),
    UserWithRole(
      id: '3',
      username: 'sara_user',
      email: 'sara@example.com',
      role: UserRole.user(),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      isActive: true,
    ),
    UserWithRole(
      id: '4',
      username: 'ali_user',
      email: 'ali@example.com',
      role: UserRole.user(),
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      isActive: false,
    ),
  ];

  void _editUser(UserWithRole user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تحرير المستخدم: ${user.username}')),
    );
  }

  void _toggleUserStatus(int index) {
    setState(() {
      _users[index] = UserWithRole(
        id: _users[index].id,
        username: _users[index].username,
        email: _users[index].email,
        role: _users[index].role,
        createdAt: _users[index].createdAt,
        isActive: !_users[index].isActive,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _users[index].isActive ? '✅ تم تفعيل المستخدم' : '❌ تم تعطيل المستخدم',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المستخدمين'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('إضافة مستخدم جديد')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    user.isActive ? Colors.green : Colors.grey,
                child: Icon(
                  user.isActive ? Icons.check : Icons.close,
                  color: Colors.white,
                ),
              ),
              title: Text(user.username),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(user.email),
                  Text(
                    'الدور: ${user.role.nameAr}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () => _editUser(user),
                    child: const Text('تحرير'),
                  ),
                  PopupMenuItem(
                    onTap: () => _toggleUserStatus(index),
                    child: Text(
                      user.isActive ? 'تعطيل' : 'تفعيل',
                    ),
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

class UserWithRole {
  final String id;
  final String username;
  final String email;
  final UserRole role;
  final DateTime createdAt;
  final bool isActive;

  UserWithRole({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.isActive,
  });
}
