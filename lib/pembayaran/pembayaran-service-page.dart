import 'package:cloud_firestore/cloud_firestore.dart';

class PembayaranService {
  static Future<void> generateTagihanBulanan() async {
    final now = DateTime.now();
    final bulanKey = '${now.day}-${now.month}-${now.year}';
    final kamarSnapshot = await FirebaseFirestore.instance
        .collection('kamar')
        .where('status', isEqualTo: 'Terisi')
        .get();

    for (var kamar in kamarSnapshot.docs) {
      final data = kamar.data();
      final tagihan = await FirebaseFirestore.instance
          .collection('pembayaran')
          .where('kamar_id', isEqualTo: kamar.id)
          .where('bulan', isEqualTo: bulanKey)
          .get();

      if (tagihan.docs.isEmpty) {
        await FirebaseFirestore.instance
            .collection('pembayaran')
            .add({
          'kamar_id': kamar.id,
          'nama_penyewa': data['penyewa']['nama'],
          'bulan': bulanKey,
          'jumlah': data['harga'],
          'status': 'Belum Bayar',
          'jatuh_tempo': Timestamp.fromDate(
            DateTime(now.year, now.month, now.day),
          ),
          'createdAt': Timestamp.now(),
        });
      }
    }
  }
}
