import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String keyLoggedIn = 'isLoggedIn';
  static const String keyUserId = 'userId'; // bisa simpan ID pemilik kos

  // Simpan login
  static Future<void> saveLogin(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyLoggedIn, true);
    await prefs.setString(keyUserId, userId);
  }

  // Logout
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyLoggedIn);
    await prefs.remove(keyUserId);
  }

  // Cek login
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyLoggedIn) ?? false;
  }

  // Ambil userId
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserId);
  }
}
