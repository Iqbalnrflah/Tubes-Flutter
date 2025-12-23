import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KosPage extends StatelessWidget {
  const KosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final namaC = TextEditingController();
    final alamatC = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Data Kos')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('kos').snapshots(),
        builder: (c, s) {
          if (!s.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: s.data!.docs.map((d) {
              return ListTile(
                title: Text(d['nama']),
                subtitle: Text(d['alamat']),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Tambah Kos'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: namaC, decoration: const InputDecoration(labelText: 'Nama Kos')),
                  TextField(controller: alamatC, decoration: const InputDecoration(labelText: 'Alamat')),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection('kos').add({
                      'nama': namaC.text,
                      'alamat': alamatC.text,
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Simpan'),
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
