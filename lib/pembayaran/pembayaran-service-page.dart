import 'dart:convert';
import 'package:http/http.dart' as http;

class PembayaranService {
  static const baseUrl =
      'https://judie-unscoffing-mayola.ngrok-free.dev/api';

  static Future<List<dynamic>> getPembayaran() async {
    final res = await http.get(Uri.parse('$baseUrl/pembayaran'));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Gagal mengambil pembayaran');
    }
  }
}
