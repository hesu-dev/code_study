import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/state_notifier.dart';
import '../screens/detail_screen.dart';

class VerticalStack extends StatelessWidget {
  final ScreenStateNotifier notifier;
  const VerticalStack({super.key, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // detail screen (위에 미리 숨겨둠)
        ValueListenableBuilder(
          valueListenable: notifier.showDetail,
          builder: (_, show, __) {
            return Positioned.fill(
              child: show
                  ? const DetailScreen().animate().slideY(
                      begin: 1,
                      end: 0,
                      duration: 600.ms,
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }
}
