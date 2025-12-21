import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Pemilik Kos")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailC, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passC, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: () async {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailC.text,
                  password: passC.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
