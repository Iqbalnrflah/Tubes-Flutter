import 'dart:convert';
import 'package:http/http.dart' as http;

class KosService {
  static const String baseUrl =
      'https://judie-unscoffing-mayola.ngrok-free.dev/api';

  static Future<List<dynamic>> getKos() async {
  final res = await http.get(
    Uri.parse('$baseUrl/kos'),
    headers: {'Accept': 'application/json'},
  );

  if (res.statusCode == 200) {
    final decoded = jsonDecode(res.body);

    if (decoded is List) {
      return decoded;
    }

    if (decoded is Map && decoded['data'] is List) {
      return decoded['data'];
    }

    return [];
  } else {
    throw Exception('Server error ${res.statusCode}');
  }
}


  static Future<void> tambahKos({
  required String nama,
  required String alamat,
}) async {
  final res = await http.post(
    Uri.parse('$baseUrl/kos'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'nama': nama,
      'alamat': alamat,
    }),
  );

  if (res.statusCode != 200 && res.statusCode != 201) {
    throw Exception('Gagal simpan kos (${res.statusCode})');
  }
}

}
