import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PenghuniPage extends StatelessWidget {
  const PenghuniPage({super.key});

  @override
  Widget build(BuildContext context) {
    final namaC = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Penghuni')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('penghuni').snapshots(),
        builder: (c, s) {
          if (!s.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: s.data!.docs.map((d) {
              return ListTile(title: Text(d['nama']));
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance.collection('penghuni').add({
            'nama': namaC.text,
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
