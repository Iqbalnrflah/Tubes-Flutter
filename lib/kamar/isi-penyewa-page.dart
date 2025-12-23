import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IsiPenyewaPage extends StatefulWidget {
  final String kamarId;

  const IsiPenyewaPage({
    Key? key,
    required this.kamarId,
  }) : super(key: key);

  @override
  State<IsiPenyewaPage> createState() => _IsiPenyewaPageState();
}

class _IsiPenyewaPageState extends State<IsiPenyewaPage> {
  final namaC = TextEditingController();
  final nikC = TextEditingController();
  final telpC = TextEditingController();

  Future<void> simpan() async {
    if (namaC.text.isEmpty ||
        nikC.text.isEmpty ||
        telpC.text.isEmpty) return;

    final fs = FirebaseFirestore.instance;

    // ==========================
    // AMBIL DATA KAMAR
    // ==========================
    final kamarRef = fs.collection('kamar').doc(widget.kamarId);
    final kamarSnap = await kamarRef.get();
    if (!kamarSnap.exists) return;

    final kamar = kamarSnap.data() as Map<String, dynamic>;
    final int harga = kamar['harga'];
    final String nomorKamar = kamar['nomor'];
    final String kosId = kamar['kos_id'];

    // ==========================
    // AMBIL DATA KOS
    // ==========================
    final kosSnap = await fs.collection('kos').doc(kosId).get();
    final String namaKos = kosSnap.exists ? kosSnap['nama'] : '-';

    // ==========================
    // WAKTU
    // ==========================
    final Timestamp tanggalMasuk = Timestamp.now();
    final DateTime now = DateTime.now();
    final String bulan = '${now.month.toString().padLeft(2, '0')}-${now.year}';
    final Timestamp tanggalTagihan = Timestamp.fromDate(now);

    // ==========================
    // UPDATE KAMAR
    // ==========================
    await kamarRef.update({
      'status': 'Terisi',
      'tanggal_masuk': tanggalMasuk,
      'penyewa': {
        'nama': namaC.text,
        'nik': nikC.text,
        'telp': telpC.text,
      }
    });

    // ==========================
    // BUAT PEMBAYARAN (LENGKAP)
    // ==========================
    await fs.collection('pembayaran').add({
      'kos_id': kosId,
      'nama_kos': namaKos,
      'kamar_id': widget.kamarId,
      'nama_kamar': nomorKamar,
      'nama_penyewa': namaC.text,
      'bulan': bulan,
      'tanggal_masuk': tanggalMasuk,
      'tanggal_tagihan': tanggalTagihan, // field baru
      'jumlah': harga,
      'dibayar': 0,
      'sisa': harga,
      'status': 'Belum Bayar',
      'createdAt': Timestamp.now(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isi Data Penyewa'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaC,
              decoration: const InputDecoration(
                labelText: 'Nama Penyewa',
              ),
            ),
            TextField(
              controller: nikC,
              decoration: const InputDecoration(
                labelText: 'NIK',
              ),
            ),
            TextField(
              controller: telpC,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'No HP',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: simpan,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
