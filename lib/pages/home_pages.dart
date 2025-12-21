import 'package:flutter/material.dart';
import 'package:tubes_flutter/pages/detail_kamar_pages.dart';
import 'package:tubes_flutter/pages/tambah_kos_pages.dart';
import 'package:tubes_flutter/services/firestrore_service.dart';
import 'tambah_kos_pages.dart';
import 'detail_kamar_pages.dart';
import '../services/firestrore_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Kos")),
      body: StreamBuilder(
        stream: FirestoreService.kosStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (c, i) {
              final kos = docs[i];
              return ListTile(
                title: Text(kos['nama']),
                subtitle: Text(kos['alamat']),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailKosPage(kosId: kos.id, nama: kos['nama']),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TambahKosPage()),
        ),
      ),
    );
  }
}
