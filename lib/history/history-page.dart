import 'package:flutter/material.dart';
import 'history-model.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final List<HistoryModel> historyList = [
    HistoryModel(
      nama: 'Milea Adnan Husein',
      kos: 'Cempaka Kost 1',
      kamar: 'Kamar A',
      tanggal: DateTime(2025, 1, 24),
      isLunas: true,
    ),
    HistoryModel(
      nama: 'Milea Adnan Husein',
      kos: 'Cempaka Kost 1',
      kamar: 'Kamar A',
      tanggal: DateTime(2025, 1, 20),
      isLunas: false,
    ),
    HistoryModel(
      nama: 'Ancika Mahrunnisa Rabu',
      kos: 'Cempaka Kost 1',
      kamar: 'Kamar B',
      tanggal: DateTime(2025, 1, 7),
      isLunas: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tersimpan'),
        backgroundColor: const Color(0xFFFF6F61),
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          final data = historyList[index];

          return Column(
            children: [
              ListTile(
                title: Text(
                  data.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.kos),
                    Text(data.kamar),
                    Text(
                      "${data.tanggal.day.toString().padLeft(2, '0')}/"
                      "${data.tanggal.month.toString().padLeft(2, '0')}/"
                      "${data.tanggal.year}",
                    ),
                  ],
                ),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: data.isLunas ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    data.isLunas ? 'Lunas' : 'Belum Lunas',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
