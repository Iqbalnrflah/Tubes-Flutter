import 'package:flutter/material.dart';
import '../shared/kos_model.dart';
import 'kamar_pages.dart';
import 'profil_pages.dart';
import 'tambah_kos_pages.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int index = 0;

  final List<KosModel> kosList = [
    KosModel(nama: "Kos Putra", harga: "Rp 800.000 / bulan"),
    KosModel(nama: "Kos Putri", harga: "Rp 900.000 / bulan"),
  ];

  void tambahKos(KosModel kos) {
    setState(() {
      kosList.add(kos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index == 0
          ? KamarPages(kosList: kosList)
          : const ProfilPages(),

      floatingActionButton: index == 0
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.push<KosModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TambahKosPages(),
                  ),
                );

                if (result != null) {
                  tambahKos(result);
                }
              },
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() => index = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Kos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
