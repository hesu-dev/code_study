import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(Sizes.size14)),
      ),
    );
  }
}
