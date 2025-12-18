import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profil")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            CircleAvatar(radius: 40),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "Nama")),
            TextField(decoration: InputDecoration(labelText: "Email")),
            TextField(decoration: InputDecoration(labelText: "Password")),
            TextField(decoration: InputDecoration(labelText: "Nomor Handphone")),
          ],
        ),
      ),
    );
  }
}
