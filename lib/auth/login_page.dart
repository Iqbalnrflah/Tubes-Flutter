import 'package:flutter/material.dart';
import 'auth-service.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const LoginPage({super.key, required this.toggleTheme});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool loading = false;

  void handleLogin() async {
    setState(() => loading = true);

    final result = await AuthService.login(
      email: emailC.text,
      password: passC.text,
    );

    setState(() => loading = false);

    if (result['status'] == 200) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['body']['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: loading ? null : handleLogin,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Masuk'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/register'),
              child: const Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
