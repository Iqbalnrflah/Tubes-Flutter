import 'package:flutter/material.dart';
import '../shared/kos_shared.dart';
import 'detail_kamar_pages.dart';

class KamarPages extends StatelessWidget {
  final List<KosCard> kosList;

  const KamarPages({super.key, required this.kosList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Kos")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kosList.length,
        itemBuilder: (context, index) {
          final kos = kosList[index];
          return KosCard(
            nama: kos.nama,
            harga: kos.harga,
            
          );
        },
      ),
    );
  }
}
