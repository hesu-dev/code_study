import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/colors.dart';

class ThemeProvider extends ChangeNotifier {
  bool isGlobalDarkTheme = false;
  late bool _isDarkModeSwich = isGlobalDarkTheme; // 초기값 설정

  bool get isDarkModeSwich => _isDarkModeSwich;

  set isDarkModeSwich(bool value) {
    _isDarkModeSwich = !_isDarkModeSwich;
    isGlobalDarkTheme = _isDarkModeSwich;
    _updateColors();
    notifyListeners(); // 변경을 구독자에게 알림
  }

  late Color bgColor = _isDarkModeSwich
      ? GlovalColors.bgDarkColor
      : GlovalColors.bgLightColor;
  late Color boxColor = _isDarkModeSwich
      ? GlovalColors.boxDarkColor
      : GlovalColors.boxDarkColor;
  late Color textColor = _isDarkModeSwich
      ? GlovalColors.white
      : GlovalColors.darkGrey;
  late Color iconColor = _isDarkModeSwich
      ? GlovalColors.white
      : GlovalColors.darkGrey;

  void _updateColors() {
    if (_isDarkModeSwich) {
      bgColor = GlovalColors.bgDarkColor;
      boxColor = GlovalColors.boxDarkColor;
      textColor = GlovalColors.white;
      iconColor = GlovalColors.white;
    } else {
      bgColor = GlovalColors.bgLightColor;
      boxColor = GlovalColors.boxLightColor;
      textColor = GlovalColors.darkGrey;
      iconColor = GlovalColors.darkGrey;
    }
  }
}
