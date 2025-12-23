import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../dashboard/dashboard.dart'; // pastikan import sesuai

class LoginPage extends StatelessWidget {
  final VoidCallback toggleTheme; // terima toggleTheme dari MyApp

  const LoginPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login Pemilik Kos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailC.text.trim(),
                    password: passC.text.trim(),
                  );
                  // login sukses, pindah ke dashboard
                  Navigator.pushReplacementNamed(context, '/dashboard');
                } catch (e) {
                  // tampilkan error jika login gagal
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login gagal: $e')),
                  );
                }
              },
              child: const Text('Masuk'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text('Daftar'),
            )
          ],
        ),
      ),
    );
  }
}