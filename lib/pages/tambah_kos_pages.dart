import 'package:flutter/material.dart';
import 'package:tubes_flutter/services/firestrore_service.dart';
import '../services/firestrore_service.dart';

class TambahKosPage extends StatefulWidget {
  const TambahKosPage({super.key});

  @override
  State<TambahKosPage> createState() => _TambahKosPageState();
}

class _TambahKosPageState extends State<TambahKosPage> {
  final namaC = TextEditingController();
  final alamatC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Kos")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: namaC, decoration: const InputDecoration(labelText: "Nama Kos")),
            TextField(controller: alamatC, decoration: const InputDecoration(labelText: "Alamat")),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Simpan"),
              onPressed: () async {
                await FirestoreService.tambahKos(namaC.text, alamatC.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
