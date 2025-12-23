import 'package:flutter/material.dart';
import '../kos/kos-page.dart';
import '../kamar/kamar-page.dart';
import '../penghuni/penghuni-page.dart';
import '../pembayaran/pembayaran-page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int index = 0;

  final pages = const [
    KosPage(),
    KamarPage(),
    PenghuniPage(),
    PembayaranPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Kos'),
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Kamar'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Penghuni'),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Bayar'),
        ],
      ),
    );
  }
}
