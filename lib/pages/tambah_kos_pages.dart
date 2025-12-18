import 'package:flutter/material.dart';

class TambahKostPage extends StatelessWidget {
  const TambahKostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Kost")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input("Nama Pemilik Kost"),
            _input("Nama Kost"),
            _input("Jumlah Kamar"),
            _input("Alamat Kost"),
            _input("Harga Sewa Bulanan"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Selesai"),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
