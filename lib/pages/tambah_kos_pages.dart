import 'package:flutter/material.dart';

class TambahKosPages extends StatelessWidget {
  const TambahKosPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Kos")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _input("Nama Kos"),
            const SizedBox(height: 16),
            _input("Alamat"),
            const SizedBox(height: 16),
            _input("Harga / bulan", keyboard: TextInputType.number),
            const SizedBox(height: 16),
            _input("Fasilitas"),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint,
      {TextInputType keyboard = TextInputType.text}) {
    return TextField(
      keyboardType: keyboard,
      decoration: InputDecoration(hintText: hint),
    );
  }
}
