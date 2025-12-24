import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IsiPenyewaPage extends StatefulWidget {
  final String kamarId;

  const IsiPenyewaPage({super.key, required this.kamarId});

  @override
  State<IsiPenyewaPage> createState() => _IsiPenyewaPageState();
}

class _IsiPenyewaPageState extends State<IsiPenyewaPage> {
  final namaC = TextEditingController();

  Future<void> simpan() async {
    if (namaC.text.isEmpty) return;

    final res = await http.post(
      Uri.parse(
        'https://judie-unscoffing-mayola.ngrok-free.dev/api/kamar/${widget.kamarId}/isi',
      ),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'penyewa': namaC.text.trim(),
      }),
    );

    if (res.statusCode == 200) {
      Navigator.pop(context, true); // 🔥 WAJIB
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan penyewa')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isi Penyewa'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaC,
              decoration:
                  const InputDecoration(labelText: 'Nama Penyewa'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: simpan,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
