import 'package:flutter/material.dart';
import 'package:kliclounge/pages/mainscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLIC LOUNGE',
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      home: const MainScreen(),
    );
  }
}
