import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MaoNaMassaApp());
}

class MaoNaMassaApp extends StatelessWidget {
  const MaoNaMassaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mão na Massa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE65100),
          brightness: Brightness.light,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const HomePage(),
    );
  }
}
