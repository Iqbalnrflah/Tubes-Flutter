import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('pembayaran').snapshots(),
        builder: (c, s) {
          if (!s.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: s.data!.docs.map((d) {
              return ListTile(
                title: Text(d['bulan']),
                trailing: Text(d['status']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
