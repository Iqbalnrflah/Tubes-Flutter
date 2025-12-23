import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tubes_flutter/auth/register_page.dart';
import 'dashboard/dashboard.dart';
import 'auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengelola Kos',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(toggleTheme: toggleTheme),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => DashboardPage(toggleTheme: toggleTheme),
      },
    );
  }
}