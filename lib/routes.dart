import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'dashboard/dashboard.dart';
import 'history/history-page.dart';

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
  '/history': (context) => HistoryPage(),
};
