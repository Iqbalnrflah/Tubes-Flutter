import 'package:flutter/material.dart';
import 'package:tubes_flutter/auth/register_page.dart';
import 'dashboard/dashboard.dart';
import 'auth/login_page.dart';

void main() {
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
    theme: ThemeData(
      useMaterial3: false,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: Colors.orange,
    ),
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginPage(toggleTheme: toggleTheme),
      '/register': (context) => const RegisterPage(),
      '/dashboard': (context) => DashboardPage(toggleTheme: toggleTheme),
    },
  );
}

}