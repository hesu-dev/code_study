import 'package:flutter/material.dart';
import 'package:webtoonfix/screens/home_screen.dart';
// import 'package:webtoonfix/service/api_sirvice.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}
