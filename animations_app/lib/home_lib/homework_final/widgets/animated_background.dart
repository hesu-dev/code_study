import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  final int pageIndex;
  const AnimatedBackground({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: Container(
        key: ValueKey<int>(pageIndex),
        color: Colors.primaries[pageIndex % Colors.primaries.length],
      ),
    );
  }
}
