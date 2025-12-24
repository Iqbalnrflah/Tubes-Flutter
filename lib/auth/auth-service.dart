import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl =
      'https://judie-unscoffing-mayola.ngrok-free.dev/api';
  static Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'nama': nama,
          'email': email,
          'password': password,
        }),
      );

      return {
        'status': res.statusCode,
        'body': _parseBody(res.body),
      };
    } catch (e) {
      return {
        'status': 500,
        'body': {'message': 'Gagal terhubung ke server'},
      };
    }
  }

  /// ================= LOGIN =================
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      return {
        'status': res.statusCode,
        'body': _parseBody(res.body),
      };
    } catch (e) {
      return {
        'status': 500,
        'body': {'message': 'Gagal terhubung ke server'},
      };
    }
  }

  /// ================= SAFE JSON PARSER =================
  static dynamic _parseBody(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return {'message': body};
    }
  }
}
