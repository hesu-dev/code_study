import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authetication/sign_up.dart';
import 'package:tiktok_clone/homework_page/homework_sign_up.dart';

void main() {
  runApp(const TicTokApp());
}

class TicTokApp extends StatelessWidget {
  const TicTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicTok Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 255, 73, 97),
        ),
        appBarTheme: const AppBarTheme(
          // foregroundColor: Colors.black,
          backgroundColor: Color.fromARGB(255, 255, 15, 15),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // home: SignUpScreen(),
      home: HomeworkSignUp(),
    );
  }
}
