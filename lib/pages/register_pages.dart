import 'package:flutter/material.dart';
import '../auth/auth_service.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  final auth = AuthService();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _input(emailC, "Email"),
            const SizedBox(height: 16),
            _input(passC, "Password", obscure: true),

            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await auth.register(emailC.text, passC.text);
                    Navigator.pop(context);
                  } catch (e) {
                    setState(() => error = "Register gagal");
                  }
                },
                child: const Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String hint,
      {bool obscure = false}) {
    return TextField(
      controller: c,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
