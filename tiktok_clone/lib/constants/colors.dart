import 'dart:ui';

import 'package:flutter/material.dart';

class GlovalColors {
  /* GLOBAL COLOR */
  Color bgColor = bgLightColor;
  Color boxColor = boxLightColor;
  Color textColor = darkGrey;
  Color iconColor = darkGrey;
  /* LIGHT THEME COLOR */
  static const Color bgLightColor = Color.fromARGB(255, 255, 255, 255);
  static const Color boxLightColor = Color(0xFFFFFFFF);

  /* DARK THEME COLOR */
  static const Color bgDarkColor = Color(0xFF141414);
  static const Color boxDarkColor = Color(0xFF282828);

  static const Color white = Color(0xFFFFFFFF);

  static const Color red = Color(0xFFFF6969);
  static const Color redLight = Color(0xFFFFB4B4);

  static const Color blue = Color(0xFF3FA2F6);
  static const Color blueLight = Color(0xFF9FD0FA);

  static const Color darkGrey = Color(0xFF333333);
  static const Color darkLight = Color(0xFF999999);

  static const Color mint = Color(0xFF6CE1A8);
}
