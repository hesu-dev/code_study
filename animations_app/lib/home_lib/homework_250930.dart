import 'dart:math';
import 'package:flutter/material.dart';

class FlashCardPage extends StatefulWidget {
  const FlashCardPage({super.key});

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  final List<FlashCard> cards = const [
    FlashCard(q: '문제1', a: '답변1'),
    FlashCard(q: '문제2', a: '답변2'),
    FlashCard(q: '문제3', a: '답변3'),
    FlashCard(q: '문제4', a: '답변4'),
  ];

  int index = 0;
  bool isFlipped = false;

  double dragDx = 0;

  Color _backgroundColor() {
    final t = (dragDx.abs() / 150).clamp(0.0, 1.0);
    if (dragDx > 0) {
      return Color.lerp(const Color(0xFF6FD3FF), Colors.green, t)!;
    } else if (dragDx < 0) {
      return Color.lerp(
        const Color(0xFF6FD3FF),
        const Color.fromARGB(255, 255, 136, 68),
        t,
      )!;
    }
    return const Color(0xFF6FD3FF); // 기본 하늘색
  }

  String _titleTxt() {
    if (dragDx > 0) {
      return "I got to right";
    } else if (dragDx < 0) {
      return "Need to review";
    }
    return "";
  }

  void _nextCard() {
    setState(() {
      index = (index + 1) % cards.length;
      isFlipped = false;
      dragDx = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (index + (isFlipped ? 0.5 : 0.0)) / cards.length; // 살짝 재미로 반영
    final safeProgress = progress.clamp(0.0, 1.0); // 범위 제한

    return Scaffold(
      backgroundColor: _backgroundColor(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_titleTxt()),
            Stack(
              children: [
                // 카드 영역
                Center(
                  child: GestureDetector(
                    onTap: () => setState(() => isFlipped = !isFlipped),
                    onHorizontalDragUpdate: (d) {
                      setState(
                        () => dragDx = d.primaryDelta == null
                            ? dragDx
                            : (dragDx + d.primaryDelta!).clamp(-300.0, 300.0),
                      );
                    },
                    onHorizontalDragEnd: (_) => _nextCard(),
                    onHorizontalDragCancel: () => _nextCard(),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: SizedBox(
                        width: min(
                          MediaQuery.of(context).size.width * 0.8,
                          420,
                        ),
                        height: min(
                          MediaQuery.of(context).size.height * 0.85,
                          520,
                        ),
                        child: _FlipCard(
                          isFlipped: isFlipped,
                          front: _CardFace(text: cards[index].q),
                          back: _CardFace(text: cards[index].a),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 30,
                  right: 30,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: 5,
                      child: CustomPaint(
                        painter: ProgressPainter(
                          progress: safeProgress,
                          trackColor: Colors.grey,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FlashCard {
  final String q;
  final String a;
  const FlashCard({required this.q, required this.a});
}

class _CardFace extends StatelessWidget {
  final String text;
  const _CardFace({required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              height: 1.3,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

/// AnimatedSwitcher + Matrix4.rotationY 로 Y축 회전 뒤집기
class _FlipCard extends StatelessWidget {
  final bool isFlipped;
  final Widget front;
  final Widget back;

  const _FlipCard({
    required this.isFlipped,
    required this.front,
    required this.back,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 200),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        // 값 범위 보호
        final v = animation.value.clamp(0.0, 1.0);
        final angle = v * pi;

        // 아래 트릭: 현재 child 가 뒤면 반대로 회전시켜 자연스러운 전환
        final isBack = (child.key as ValueKey).value == 'back';

        return AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (context, child) {
            final m = Matrix4.identity()
              ..setEntry(3, 2, 0.001) // 원근감
              ..rotateY(isBack ? -angle : angle);
            return Transform(
              transform: m,
              alignment: Alignment.center,
              child: child,
            );
          },
        );
      },
      layoutBuilder: (currentChild, previousChildren) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      child: isFlipped
          ? Container(key: const ValueKey('back'), child: back)
          : Container(key: const ValueKey('front'), child: front),
    );
  }
}

/// CustomPainter + Canvas.drawPath 로 진행률 표시줄
class ProgressPainter extends CustomPainter {
  final double progress; // 0..1
  final Color trackColor;
  final Color fillColor;

  ProgressPainter({
    required this.progress,
    required this.trackColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final p = progress.clamp(0.0, 1.0);
    final radius = size.height / 2;

    // 트랙
    final trackPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );
    final trackPaint = Paint()..color = trackColor;
    canvas.drawPath(trackPath, trackPaint);

    // 진행 부분
    final w = (size.width * p).clamp(0.0, size.width);
    if (w > 0) {
      final fillPath = Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, w, size.height),
            Radius.circular(radius),
          ),
        );
      final fillPaint = Paint()..color = fillColor;
      canvas.drawPath(fillPath, fillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.fillColor != fillColor;
  }
}
