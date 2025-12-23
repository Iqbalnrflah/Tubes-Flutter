import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _PenghuniPageState();
}

class _PenghuniPageState extends State<Profil> {
  final namaC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final passC = TextEditingController();

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final doc = await FirebaseFirestore.instance
        .collection('pemilik_kos')
        .doc(uid)
        .get();

    if (doc.exists) {
      namaC.text = doc['nama'] ?? '';
      emailC.text = doc['email'] ?? '';
      phoneC.text = doc['phone'] ?? '';
    }
  }

  Future<void> updateProfile() async {
    await FirebaseFirestore.instance
        .collection('pemilik_kos')
        .doc(uid)
        .update({
      'nama': namaC.text,
      'phone': phoneC.text,
    });

    if (passC.text.isNotEmpty) {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(passC.text);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.orange,
                    child: const Icon(Icons.camera_alt,
                        size: 16, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            TextField(
              controller: namaC,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailC,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password Baru',
                suffixIcon: Icon(Icons.visibility),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneC,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Nomor Handphone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: updateProfile,
              child: const Text('Simpan'),
            ),
            const SizedBox(height: 15),
            TextButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (_) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Keluar',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}