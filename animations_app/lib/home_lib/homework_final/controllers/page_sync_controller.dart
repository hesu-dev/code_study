import 'package:flutter/material.dart';

class PageSyncController {
  final PageController mainController = PageController();
  final PageController delayedController = PageController();

  void syncPages(double page) {
    delayedController.animateToPage(
      page.round(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void dispose() {
    mainController.dispose();
    delayedController.dispose();
  }
}
