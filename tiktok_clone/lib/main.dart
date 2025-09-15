import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_common/theme_provider.dart';
import 'package:tiktok_clone/route/app_routes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const TicTokApp(),
    ),
  );
}

class TicTokApp extends StatelessWidget {
  const TicTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.mainbtnpage,
      routes: AppRoutes.routes,
      // home: VideoRecordingScreen(),
      debugShowCheckedModeBanner: false,
      title: 'TicTok',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        // textTheme: TextTheme(
        //   displayLarge: GoogleFonts.openSans(
        //       fontSize: 95, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        //   displayMedium: GoogleFonts.openSans(
        //       fontSize: 59, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        //   displaySmall:
        //       GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
        //   headlineMedium: GoogleFonts.openSans(
        //       fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        //   headlineSmall:
        //       GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
        //   titleLarge: GoogleFonts.openSans(
        //       fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        //   titleMedium: GoogleFonts.openSans(
        //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        //   titleSmall: GoogleFonts.openSans(
        //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        //   bodyLarge: GoogleFonts.roboto(
        //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        //   bodyMedium: GoogleFonts.roboto(
        //       fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        //   labelLarge: GoogleFonts.roboto(
        //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        //   bodySmall: GoogleFonts.roboto(
        //       fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        //   labelSmall: GoogleFonts.roboto(
        //       fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        // ),
        textTheme: GoogleFonts.itimTextTheme(),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      darkTheme: ThemeData(
        tabBarTheme: const TabBarThemeData(indicatorColor: Colors.white),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: GoogleFonts.itimTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
        primaryColor: const Color(0xFFE9435A),
      ),
    );
  }
}
