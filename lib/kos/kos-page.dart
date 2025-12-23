import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../kamar/kamar-page.dart';

class KosPage extends StatefulWidget {
  const KosPage({super.key});

  @override
  State<KosPage> createState() => _KosPageState();
}

class _KosPageState extends State<KosPage> {
  final TextEditingController namaC = TextEditingController();
  final TextEditingController alamatC = TextEditingController();

  @override
  void dispose() {
    namaC.dispose();
    alamatC.dispose();
    super.dispose();
  }

  Future<void> simpanKos() async {
    if (namaC.text.isEmpty || alamatC.text.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('kos').add({
        'nama': namaC.text.trim(),
        'alamat': alamatC.text.trim(),
        'createdAt': Timestamp.now(),
      });

      namaC.clear();
      alamatC.clear();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kos berhasil ditambahkan')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('kos')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada data kos'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return Card(
                margin: const EdgeInsets.all(8),
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
        child: const Icon(Icons.add),
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
                  onPressed: simpanKos,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
