import 'package:flutter/material.dart';
import '../kamar/kamar-page.dart';
import 'kos-service.dart';

class KosPage extends StatefulWidget {
  const KosPage({super.key});

  @override
  State<KosPage> createState() => _KosPageState();
}

class _KosPageState extends State<KosPage> {
  final namaC = TextEditingController();
  final alamatC = TextEditingController();

  late Future<List<dynamic>> kosFuture;

  @override
  void initState() {
    super.initState();
    kosFuture = KosService.getKos();
  }

  void refresh() {
    setState(() {
      kosFuture = KosService.getKos();
    });
  }

  Future<void> simpanKos() async {
    if (namaC.text.isEmpty || alamatC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan alamat wajib diisi')),
      );
      return;
    }

    try {
      await KosService.tambahKos(
        nama: namaC.text.trim(),
        alamat: alamatC.text.trim(),
      );

      namaC.clear();
      alamatC.clear();
      Navigator.pop(context);
      refresh();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kos berhasil ditambahkan')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceAll('Exception: ', ''),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: kosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text('Belum ada data kos'),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final kos = data[i];

              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(
                    kos['nama'] ?? '-',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(kos['alamat'] ?? '-'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                  // 🔥 INI BAGIAN PALING PENTING
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => KamarPage(
                          kosId: kos['id'].toString(),
                          namaKos: kos['nama'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Tambah Kos'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: namaC,
                    decoration:
                        const InputDecoration(labelText: 'Nama Kos'),
                  ),
                  TextField(
                    controller: alamatC,
                    decoration:
                        const InputDecoration(labelText: 'Alamat'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: simpanKos,
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
