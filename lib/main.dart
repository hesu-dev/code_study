import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/sign_up/sign_up.dart';

void main() {
  runApp(const TicTokApp());
}

class TicTokApp extends StatelessWidget {
  const TicTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTok Clone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE9435A)),
      ),
      home: SignUpScreen(),
    );
  }
}
