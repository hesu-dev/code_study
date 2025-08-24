// text_widget.dart
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  Widget hText(String h1text, String h2text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            h1text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            h2text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget textWidget(
    String content, {
    double fontSize = 18,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w700,
    Color fontColor = Colors.white,
  }) {
    return Text(
      content,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
