import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final namaC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final passwordC = TextEditingController();

  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emailC.text = user.email ?? '';
      namaC.text = user.displayName ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Edit Profil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// FOTO PROFIL
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 30),

            _input('Nama', namaC),
            const SizedBox(height: 15),
            _input('Email', emailC, readOnly: true),
            const SizedBox(height: 15),

            /// PASSWORD
            TextField(
              controller: passwordC,
              obscureText: hidePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => hidePassword = !hidePassword);
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),
            _input('Nomor Handphone', phoneC),

            const SizedBox(height: 30),

            /// BUTTON LOGOUT
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Keluar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController c, {bool readOnly = false}) {
    return TextField(
      controller: c,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
