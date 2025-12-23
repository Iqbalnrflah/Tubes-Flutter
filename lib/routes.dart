import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'dashboard/dashboard_page.dart';

final routes = {
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/dashboard': (context) => const DashboardPage(),
};
