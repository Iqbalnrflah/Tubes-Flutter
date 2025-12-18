import 'package:flutter/material.dart';
import '../auth/auth_service.dart';

final auth = AuthService();

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profil")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 40),
            const SizedBox(height: 20),

            const TextField(
              decoration: InputDecoration(labelText: "Nama"),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Email"),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Password"),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Nomor Handphone"),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  await auth.logout();
                  // TIDAK PERLU Navigator.pop / push
                  // AuthWrapper otomatis pindah ke Login
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
