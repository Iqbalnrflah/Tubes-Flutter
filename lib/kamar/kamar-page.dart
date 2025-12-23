import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'isi-penyewa-page.dart';

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
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Kamar ${data['nomor']}'),
                  subtitle: Text('Rp ${data['harga']}'),
                  trailing: Text(
                    data['status'],
                    style: TextStyle(
                      color: data['status'] == 'Kosong'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    if (data['status'] == 'Kosong') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => IsiPenyewaPage(
                            kamarId: doc.id,
                          ),
                        ),
                      );
                    }
                    else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Kosongkan Kamar'),
                          content: const Text(
                            'Apakah penyewa sudah keluar?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('kamar')
                                    .doc(doc.id)
                                    .update({
                                  'status': 'Kosong',
                                  'penyewa': FieldValue.delete(),
                                  'tanggal_masuk': FieldValue.delete(),
                                });

                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Ya, Kosongkan',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
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
              title: const Text('Tambah Kamar'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nomorC,
                    decoration:
                        const InputDecoration(labelText: 'Nomor Kamar'),
                  ),
                  TextField(
                    controller: hargaC,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'Harga'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (nomorC.text.isEmpty || hargaC.text.isEmpty) return;

                    await FirebaseFirestore.instance
                        .collection('kamar')
                        .add({
                      'nomor': nomorC.text,
                      'harga': int.parse(hargaC.text),
                      'status': 'Kosong',
                      'kos_id': kosId,
                      'nama_kos': namaKos,
                      'nama_kamar': 'Kamar ${nomorC.text}',
                    });

                    Navigator.pop(context);
                  },
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
