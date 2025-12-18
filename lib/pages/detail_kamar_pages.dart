import 'package:flutter/material.dart';

class DetailKamarPage extends StatelessWidget {
  final String kamar;
  const DetailKamarPage({super.key, required this.kamar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kamar $kamar")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            TextField(decoration: InputDecoration(labelText: "Nama Penyewa")),
            TextField(decoration: InputDecoration(labelText: "Nomor Kamar")),
            TextField(decoration: InputDecoration(labelText: "No WhatsApp")),
            TextField(decoration: InputDecoration(labelText: "Tanggal Masuk")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: null, child: Text("Simpan")),
          ],
        ),
      ),
    );
  }
}
