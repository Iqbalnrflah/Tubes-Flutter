import 'package:flutter/material.dart';
import '../shared/kos_shared.dart';

class TambahKosPages extends StatelessWidget {
  const TambahKosPages({super.key});

  @override
  Widget build(BuildContext context) {
    final namaController = TextEditingController();
    final hargaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Kos Baru")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(hintText: "Nama Kos"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(
                hintText: "Harga / bulan",
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: const Text("Simpan Kos"),
                onPressed: () {
                  Navigator.pop(
                    context,
                    KosCard(
                      nama: namaController.text,
                      harga: hargaController.text,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
