import 'package:flutter/material.dart';
import '../shared/kos_shared.dart';
import 'detail_kamar_pages.dart';

class KamarPages extends StatelessWidget {
  const KamarPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Kos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            KosCard(
              nama: "Kos Putra",
              harga: "Rp 800.000 / bulan",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailKamarPages(),
                  ),
                );
              },
            ),
            KosCard(
              nama: "Kos Putri",
              harga: "Rp 900.000 / bulan",
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          // ke tambah_kos_pages.dart
        },
      ),
    );
  }
}
