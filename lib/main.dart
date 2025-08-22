import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/main_navi.dart';
import 'package:tiktok_clone/route/app_routes.dart';

void main() {
  runApp(const TicTokApp());
}

class TicTokApp extends StatelessWidget {
  const TicTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: AppRoutes.tutorial,
      // routes: AppRoutes.routes,
      home: MainNavi(),
      debugShowCheckedModeBanner: false,
      title: 'TicTok Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 255, 73, 97),
        ),
        appBarTheme: const AppBarTheme(
          // backgroundColor: Color.fromARGB(255, 255, 15, 15),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
