import 'package:flutter/material.dart';
import '../shared/theme_shared.dart';
import '../pages/welcome_pages.dart';

class ProfilPages extends StatelessWidget {
  const ProfilPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            /// AVATAR
            CircleAvatar(
              radius: 45,
              backgroundColor: AppTheme.primary.withOpacity(0.2),
              child: const Icon(Icons.person,
                  size: 50, color: AppTheme.primary),
            ),
            const SizedBox(height: 16),
            const Text(
              "Nama Pengguna",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text("user@email.com"),
            const SizedBox(height: 32),

            _menu(Icons.edit, "Edit Profil"),
            _menu(Icons.home, "Kos Saya"),
            _menu(Icons.logout, "Logout", isLogout: true, context: context),
          ],
        ),
      ),
    );
  }

  Widget _menu(IconData icon, String title,
      {bool isLogout = false, BuildContext? context}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: isLogout ? Colors.red : AppTheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isLogout ? Colors.red : Colors.black,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
