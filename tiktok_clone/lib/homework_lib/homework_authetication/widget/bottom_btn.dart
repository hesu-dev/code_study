import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_common/theme_provider.dart';

class BottomBtn extends StatelessWidget {
  const BottomBtn(this.text, this.color, {super.key, required this.onTap});

  final String text;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: Sizes.size5),
        child: Container(
          padding: EdgeInsetsGeometry.symmetric(vertical: Sizes.size18),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Sizes.size5),
            boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color == Colors.white ? Colors.black : Colors.white,
              fontSize: Sizes.size16,
            ),
          ),
        ),
      ),
    );
  }
}
