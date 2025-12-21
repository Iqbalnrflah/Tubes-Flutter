import 'package:flutter/material.dart';
import 'package:tubes_flutter/services/firestrore_service.dart';
import '../services/firestrore_service.dart';

class DetailKosPage extends StatelessWidget {
  final String kosId;
  final String nama;

  const DetailKosPage({super.key, required this.kosId, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(nama)),
      body: StreamBuilder(
        stream: FirestoreService.kamarStream(kosId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final kamar = snapshot.data!.docs;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: kamar.length,
            itemBuilder: (c, i) {
              final isi = kamar[i]['terisi'];
              return Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isi ? Colors.grey : Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text("Kamar ${i + 1}")),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => FirestoreService.tambahKamar(kosId),
      ),
    );
  }
}
