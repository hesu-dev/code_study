import 'package:flutter/material.dart';
import 'package:moviehomework/views/Home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie HomeWork',
      home: Scaffold(appBar: AppBar(), body: const Home()),
    );
  }
}
