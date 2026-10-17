import 'package:flutter/material.dart';
import 'screens/index.dart';
import 'services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // التحقق من وجود توكن
  final token = await StorageService().getToken();
  if (token != null) {
    ApiService.setAuthToken(token);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Price Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        future: StorageService().getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // إذا كان هناك توكن، اذهب للصفحة الرئيسية
          if (snapshot.hasData && snapshot.data != null) {
            return const HomeScreen();
          }

          // وإلا، اذهب لصفحة تسجيل الدخول
          return const LoginScreen();
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
