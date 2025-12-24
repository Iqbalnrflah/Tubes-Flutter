import 'dart:convert';
import 'package:http/http.dart' as http;

class KamarService {
  static const String baseUrl =
      'https://judie-unscoffing-mayola.ngrok-free.dev/api';

  static Future<List<dynamic>> getKamar(String kosId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/kos/$kosId/kamar'),
      headers: {'Accept': 'application/json'},
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Gagal memuat kamar');
    }
  }

  static Future<void> tambahKamar({
    required String kosId,
    required String namaKamar,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/kos/$kosId/kamar'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nama_kamar': namaKamar,
      }),
    );

    if (res.statusCode != 201) {
      throw Exception('Gagal tambah kamar (${res.statusCode})');
    }
  }
}
