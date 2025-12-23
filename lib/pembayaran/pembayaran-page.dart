import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pembayaran')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada pembayaran'));
          }

          return ListView(
            padding: const EdgeInsets.all(8),
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              // Ambil tanggal masuk
              final Timestamp ts = data['tanggal_masuk'] as Timestamp;
              final tanggal = ts.toDate();
              final formattedTanggal =
                  DateFormat('dd-MM-yyyy').format(tanggal);

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(
                    '${data['nama_kos']} • ${data['nama_kamar']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Penyewa : ${data['nama_penyewa']}'),
                      Text('Bulan : ${data['bulan']}'),
                      Text('Tanggal Masuk: $formattedTanggal'), // <--- tambahan
                      const SizedBox(height: 4),
                      Text('Total   : Rp ${data['jumlah']}'),
                      Text('Dibayar : Rp ${data['dibayar']}'),
                      Text('Sisa    : Rp ${data['sisa']}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['status'],
                        style: TextStyle(
                          color: data['status'] == 'Lunas'
                              ? Colors.green
                              : data['status'] == 'Cicil'
                                  ? Colors.orange
                                  : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (data['status'] != 'Lunas') const Icon(Icons.edit, size: 16),
                    ],
                  ),
                  onTap: data['status'] == 'Lunas'
                      ? null
                      : () => _dialogBayar(context, doc),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _dialogBayar(BuildContext context, QueryDocumentSnapshot doc) {
    final bayarC = TextEditingController();
    final data = doc.data() as Map<String, dynamic>;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Bayar Cicilan'),
        content: TextField(
          controller: bayarC,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Nominal Bayar',
            prefixText: 'Rp ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (bayarC.text.isEmpty) return;

              final int bayar = int.parse(bayarC.text);
              final int jumlah = data['jumlah'];
              final int dibayarLama = data['dibayar'];
              final int sisa = data['sisa'];

              if (bayar <= 0 || bayar > sisa) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nominal tidak valid')),
                );
                return;
              }

              final int dibayarBaru = dibayarLama + bayar;
              final int sisaBaru = jumlah - dibayarBaru;

              await FirebaseFirestore.instance
                  .collection('pembayaran')
                  .doc(doc.id)
                  .update({
                'dibayar': dibayarBaru,
                'sisa': sisaBaru < 0 ? 0 : sisaBaru,
                'status': dibayarBaru >= jumlah ? 'Lunas' : 'Cicil',
              });

              Navigator.pop(context);
            },
            child: const Text('Bayar'),
          ),
        ],
      ),
    );
  }
}
