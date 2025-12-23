import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KamarPage extends StatelessWidget {
  final String kosId;
  final String namaKos;

  const KamarPage({
    super.key,
    required this.kosId,
    required this.namaKos,
  });

  @override
  Widget build(BuildContext context) {
    final nomorC = TextEditingController();
    final hargaC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Kamar $namaKos'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('kamar')
            .where('kos_id', isEqualTo: kosId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada kamar'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text('Kamar ${doc['nomor']}'),
                  subtitle: Text('Rp ${doc['harga']}'),
                  trailing: Text(
                    doc['status'],
                    style: TextStyle(
                      color: doc['status'] == 'Kosong'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
              title: const Text('Tambah Kamar'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nomorC,
                    decoration: const InputDecoration(labelText: 'Nomor Kamar'),
                  ),
                  TextField(
                    controller: hargaC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Harga'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (nomorC.text.isEmpty || hargaC.text.isEmpty) return;

                    await FirebaseFirestore.instance.collection('kamar').add({
                      'nomor': nomorC.text,
                      'harga': int.parse(hargaC.text),
                      'status': 'Kosong',
                      'kos_id': kosId, // ⬅️ PENTING
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
