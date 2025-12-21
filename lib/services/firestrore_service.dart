import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> kosStream() {
    return _db.collection('kos').snapshots();
  }

  static Future tambahKos(String nama, String alamat) {
    return _db.collection('kos').add({
      'nama': nama,
      'alamat': alamat,
    });
  }

  static Stream<QuerySnapshot> kamarStream(String kosId) {
    return _db.collection('kos').doc(kosId).collection('kamar').snapshots();
  }

  static Future tambahKamar(String kosId) {
    return _db.collection('kos').doc(kosId).collection('kamar').add({
      'terisi': false,
    });
  }
}
