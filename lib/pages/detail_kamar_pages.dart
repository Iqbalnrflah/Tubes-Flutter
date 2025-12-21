import 'package:flutter/material.dart';

class DetailKamarPages extends StatefulWidget {
  const DetailKamarPages({super.key});

  @override
  State<DetailKamarPages> createState() => _DetailKamarPagesState();
}

class _DetailKamarPagesState extends State<DetailKamarPages> {
  List<Map<String, dynamic>> kamarList = [
    {'kode': 'A', 'kosong': true, 'nama': '', 'hp': ''},
    {'kode': 'B', 'kosong': true, 'nama': '', 'hp': ''},
    {'kode': 'C', 'kosong': true, 'nama': '', 'hp': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cempaka Kost 1")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: kamarList.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final kamar = kamarList[index];

                  return GestureDetector(
                    onTap: () {
                      if (kamar['kosong']) {
                        isiKamar(index);
                      } else {
                        lihatPenghuni(kamar);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kamar['kosong']
                            ? const Color(0xFFFF6B6B)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          kamar['kode'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kamar['kosong']
                                ? Colors.white
                                : Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Tambah Kamar"),
                onPressed: tambahKamar,
              ),
            )
          ],
        ),
      ),
    );
  }

  // ➕ TAMBAH KAMAR
  void tambahKamar() {
    setState(() {
      String kode =
          String.fromCharCode(65 + kamarList.length);
      kamarList.add({
        'kode': kode,
        'kosong': true,
        'nama': '',
        'hp': '',
      });
    });
  }

  // 📝 ISI DATA PENGHUNI
  void isiKamar(int index) {
    TextEditingController namaController = TextEditingController();
    TextEditingController hpController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Isi Kamar ${kamarList[index]['kode']}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: "Nama Penghuni"),
            ),
            TextField(
              controller: hpController,
              decoration: const InputDecoration(labelText: "No HP"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Simpan"),
            onPressed: () {
              setState(() {
                kamarList[index]['nama'] = namaController.text;
                kamarList[index]['hp'] = hpController.text;
                kamarList[index]['kosong'] = false;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // 👤 LIHAT DATA PENGHUNI
  void lihatPenghuni(Map kamar) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Kamar ${kamar['kode']}"),
        content: Text(
          "Nama: ${kamar['nama']}\nNo HP: ${kamar['hp']}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }
}
