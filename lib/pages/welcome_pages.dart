import 'package:flutter/material.dart';
import 'register_pages.dart';
import 'pages.dart';

class WelcomePages extends StatelessWidget {
  const WelcomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home_work, size: 90, color: Color(0xFFFF6B6B)),
            const SizedBox(height: 20),
            const Text(
              "Cari Kos Mudah & Cepat",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            /// LOGIN
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B6B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Pages()),
                  );
                },
                child: const Text("Masuk"),
              ),
            ),

            const SizedBox(height: 12),

            /// REGISTER
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPages()),
                );
              },
              child: const Text("Daftar Akun"),
            ),
          ],
        ),
      ),
    );
  }
}
