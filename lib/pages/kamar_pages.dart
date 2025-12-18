import 'package:flutter/material.dart';
import 'detail_kamar_pages.dart';

class KamarPage extends StatelessWidget {
  const KamarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final kamar = List.generate(14, (i) => String.fromCharCode(65 + i));

    return Scaffold(
      appBar: AppBar(title: const Text("Cempaka Kost 1")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: kamar.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailKamarPage(kamar: kamar[i]),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6F61),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                kamar[i],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
