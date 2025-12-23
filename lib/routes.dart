import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'dashboard/dashboard.dart';

final routes = {
  '/login': (context) => LoginPage(
        toggleTheme: () {
        },
      ),
  '/register': (context) => const RegisterPage(),
  '/dashboard': (context) => DashboardPage(
        toggleTheme: () {
        },
      ),
};
