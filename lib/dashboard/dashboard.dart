import 'package:flutter/material.dart';
import '../../kos/kos-page.dart';
import '../../pembayaran/pembayaran-page.dart';
import '../../Profil/Profil.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const DashboardPage({super.key, required this.toggleTheme});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int index = 0;

  final pages = [
    const KosPage(),
    const PembayaranPage(),
    const Profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.orange,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Kos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'Bayar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
