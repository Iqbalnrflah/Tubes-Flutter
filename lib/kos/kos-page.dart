import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../kamar/kamar-page.dart';

class KosPage extends StatelessWidget {
  const KosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final namaC = TextEditingController();
    final alamatC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kos'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('kos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada data kos'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(doc['nama']),
                  subtitle: Text(doc['alamat']),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => KamarPage(
                          kosId: doc.id,
                          namaKos: doc['nama'],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Tambah Kos'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: namaC,
                    decoration: const InputDecoration(labelText: 'Nama Kos'),
                  ),
                  TextField(
                    controller: alamatC,
                    decoration: const InputDecoration(labelText: 'Alamat'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (namaC.text.isEmpty || alamatC.text.isEmpty) return;

                    await FirebaseFirestore.instance.collection('kos').add({
                      'nama': namaC.text,
                      'alamat': alamatC.text,
                      'createdAt': Timestamp.now(),
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
