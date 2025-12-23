import 'package:flutter/material.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'dashboard/dashboard.dart';
import 'history/history-page.dart';

final routes = {
  '/login': (context) => LoginPage(
        toggleTheme: () {
          // nanti diisi dari MyApp
        },
      ),
  '/register': (context) => const RegisterPage(),
  '/dashboard': (context) => DashboardPage(
        toggleTheme: () {
          // nanti diisi dari MyApp
        },
      ),
  '/history': (context) => HistoryPage(),
};
