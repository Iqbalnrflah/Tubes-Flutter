import 'package:flutter/material.dart';
import '../pages/welcome_pages.dart';
import '../pages/pages.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // sementara anggap belum login
    bool isLogin = false;

    return isLogin ? const Pages() : const WelcomePages();
  }
}
