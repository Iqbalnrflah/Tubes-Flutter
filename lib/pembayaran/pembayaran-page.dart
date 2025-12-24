import 'package:flutter/material.dart';
import 'package:tubes_flutter/pembayaran/pembayaran-service-page.dart';
import 'pembayaran-service-page.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: PembayaranService.getPembayaran(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada pembayaran'));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final p = data[i];
              return ListTile(
                title: Text(p['nama'] ?? '-'),
                subtitle: Text(p['jumlah'].toString()),
              );
            },
          );
        },
      ),
    );
  }
}
