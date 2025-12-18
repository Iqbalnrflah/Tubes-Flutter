import 'package:flutter/material.dart';
import 'pages/pages.dart';
import 'shared/theme_shared.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const Pages(),
    );
  }
}
