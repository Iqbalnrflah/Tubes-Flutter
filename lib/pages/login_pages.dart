import 'package:flutter/material.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.person_add,
                size: 80, color: Color(0xFFFF6B6B)),
            const SizedBox(height: 24),

            _input("Nama Lengkap"),
            const SizedBox(height: 16),
            _input("Email"),
            const SizedBox(height: 16),
            _input("Password", isPassword: true),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(hintText: hint),
    );
  }
}
