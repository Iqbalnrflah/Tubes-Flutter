import 'package:flutter/material.dart';

class DetailKamarPages extends StatelessWidget {
  const DetailKamarPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Kos")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.image, size: 60),
            ),
            const SizedBox(height: 16),
            const Text(
              "Kos Putra",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Rp 800.000 / bulan"),
            const SizedBox(height: 16),
            const Text(
              "Fasilitas",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("• AC\n• WiFi\n• Kamar mandi dalam"),
          ],
        ),
      ),
    );
  }
}
