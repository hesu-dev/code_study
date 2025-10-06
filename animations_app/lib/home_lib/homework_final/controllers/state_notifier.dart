import 'package:flutter/material.dart';

class ScreenStateNotifier {
  final ValueNotifier<bool> showDetail = ValueNotifier(false);

  void toggleDetail() {
    showDetail.value = !showDetail.value;
  }

  void dispose() {
    showDetail.dispose();
  }
}
