import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final namaC = TextEditingController();
    final emailC = TextEditingController();
    final passC = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Pemilik Kos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: namaC, decoration: const InputDecoration(labelText: 'Nama')),
            TextField(controller: emailC, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passC, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: emailC.text, password: passC.text);

                await FirebaseFirestore.instance
                    .collection('pemilik_kos')
                    .doc(user.user!.uid)
                    .set({
                  'nama': namaC.text,
                  'email': emailC.text,
                });

                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: const Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
