import 'package:flutter/material.dart';
import 'kamar-service.dart';
import 'isi-penyewa-page.dart';

class KamarPage extends StatefulWidget {
  final String kosId;
  final String namaKos;

  const KamarPage({
    super.key,
    required this.kosId,
    required this.namaKos,
  });

  @override
  State<KamarPage> createState() => _KamarPageState();
}

class _KamarPageState extends State<KamarPage> {
  late Future<List<dynamic>> kamarFuture;
  final kamarC = TextEditingController();

  @override
  void initState() {
    super.initState();
    kamarFuture = KamarService.getKamar(widget.kosId);
  }

  void refresh() {
    setState(() {
      kamarFuture = KamarService.getKamar(widget.kosId);
    });
  }

  Future<void> simpanKamar() async {
    if (kamarC.text.isEmpty) return;

    await KamarService.tambahKamar(
      kosId: widget.kosId,
      namaKamar: kamarC.text.trim(),
    );

    kamarC.clear();
    Navigator.pop(context);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kamar - ${widget.namaKos}'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: kamarFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(child: Text('Belum ada kamar'));
          }

          return ListView.builder(
  itemCount: data.length,
  itemBuilder: (context, i) {
    final kamar = data[i];
    final bool terisi = kamar['terisi'] == 1;

    return ListTile(
      title: Text(kamar['nama_kamar'] ?? '-'),
      trailing: Chip(
        label: Text(terisi ? 'Terisi' : 'Kosong'),
        backgroundColor:
            terisi ? Colors.red[200] : Colors.green[200],
      ),
      onTap: () {
        if (!terisi) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => IsiPenyewaPage(
                kamarId: kamar['id'].toString(),
              ),
            ),
          ).then((_) => refresh());
        }
      },
    ); // ✅ ListTile
  },
); // ✅ ListView.builder


        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Tambah Kamar'),
              content: TextField(
                controller: kamarC,
                decoration:
                    const InputDecoration(labelText: 'Nama Kamar'),
              ),
              actions: [
                TextButton(
                  onPressed: simpanKamar,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
