import 'package:flutter/material.dart';
import 'package:tubes_flutter/pages/kamar_pages.dart';
import 'package:tubes_flutter/pages/tambah_kos_pages.dart';
import 'tambah_kos_pages.dart';
import 'kamar_pages.dart';

class WelcomePages extends StatelessWidget {
  const WelcomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: Image.asset(
                'assets/bg_house.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                _kostButton(context, "CEMPAKA KOST 1"),
                const SizedBox(height: 16),
                _kostButton(context, "CEMPAKA KOST 2"),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TambahKostPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _kostButton(BuildContext context, String text) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KamarPage()),
        );
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFFF6F61),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
