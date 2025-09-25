import 'package:flutter/material.dart';
import 'dart:math' as math;

class TestGlitchScreen extends StatelessWidget {
  const TestGlitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: RedGridAnimation()),
      ),
    );
  }
}

class RedGridAnimation extends StatefulWidget {
  const RedGridAnimation({super.key});

  @override
  State<RedGridAnimation> createState() => _RedGridAnimationState();
}

class _RedGridAnimationState extends State<RedGridAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() => setState(() {}))
      ..repeat(min: 0, max: 100000, period: const Duration(seconds: 100));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 정사각형 캔버스에 맞춰 비율 유지
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _GridPainter(time: _controller.value),
        size: const Size.square(500),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.time});

  final double time;

  // ====== 튜닝 가능한 파라미터 ======
  static const int rows = 5;
  static const int cols = 5;
  static const double gap = 18; // 셀 간격
  static const double corner = 8; // 라운드 정도
  static const double innerPad = 10; // 내부 스크린 패딩
  static const Color baseRed = Color(0xFFFF2A43);

  // 시간·인덱스 기반 의사 난수(프레임마다 결정적)
  double _hash(double x) {
    // 0~1 범위
    return (math.sin(x * 12.9898) * 43758.5453).abs() % 1.0;
  }

  // 부드러운 노이즈(글리치 강도/밝기 변화)
  double _noise2D(int i, int j, double t, {double speed = 1}) {
    final a = _hash(i * 13.0 + j * 17.0 + (t * speed));
    final b = _hash(j * 19.0 + i * 23.0 + (t * speed * 0.5));
    return (a + b) * 0.5;
  }

  // 셀 하나 그리기
  void _paintCell(Canvas canvas, Rect r, int i, int j, double t) {
    final cellSeed = i * 100 + j;
    final glowPhase = _noise2D(i, j, t, speed: 0.35);
    final flicker = _noise2D(i + 3, j + 7, t * 1.6, speed: 3.0);

    // 외곽(살짝 어두운 적색으로 글로우 느낌)
    final outer = RRect.fromRectAndRadius(r, const Radius.circular(corner));
    final outerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = baseRed.withOpacity(0.18 + glowPhase * 0.25); // 주변 글로우(낮은 불투명도)
    canvas.drawRRect(outer, outerPaint);

    // 본체(화면) — 밝기 가변
    final inner = RRect.fromRectAndRadius(
      r.deflate(innerPad),
      const Radius.circular(corner * 0.7),
    );
    final brightness = 0.72 + glowPhase * 0.25 + (flicker > 0.85 ? 0.05 : 0.0);
    final screenColor = HSLColor.fromColor(
      baseRed,
    ).withLightness(brightness.clamp(0.0, 1.0)).toColor();

    final screenPaint = Paint()..color = screenColor;
    canvas.drawRRect(inner, screenPaint);

    // 하이라이트(상단 가장자리)
    final highlight = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        inner.outerRect.left,
        inner.outerRect.top,
        inner.outerRect.width,
        inner.outerRect.height * 0.08,
      ).deflate(2),
      const Radius.circular(corner * 0.5),
    );
    canvas.drawRRect(
      highlight,
      Paint()
        ..blendMode = BlendMode.plus
        ..color = Colors.white.withOpacity(0.07 + glowPhase * 0.06),
    );

    // 글리치 요소들 (줄무늬/블록/체커)
    final rnd = (double k) => _hash(k + cellSeed + t * 60.0);
    final innerRect = inner.outerRect;

    // 1) 가로 스캔라인 (가끔만 강하게)
    final lines = 2 + (rnd(1) * 5).floor();
    for (int k = 0; k < lines; k++) {
      final y = innerRect.top + innerRect.height * rnd(k + 2); // 임의 위치
      final h = 1.0 + 2.0 * rnd(k + 3);
      final opacity = 0.05 + 0.25 * (flicker > 0.8 ? rnd(k + 4) : 0.0);
      final w = innerRect.width * (0.4 + rnd(k + 5) * 0.6);
      final x = innerRect.left + innerRect.width * rnd(k + 6) * 0.6;
      canvas.drawRect(
        Rect.fromLTWH(x, y, w, h),
        Paint()
          ..blendMode = BlendMode.plus
          ..color = Colors.white.withOpacity(opacity),
      );
    }

    // 2) 작은 블록(미세 글리치)
    if (flicker > 0.65) {
      final count = 1 + (rnd(20) * 3).floor();
      for (int k = 0; k < count; k++) {
        final w = 6.0 + rnd(k + 21) * 18.0;
        final h = 6.0 + rnd(k + 22) * 18.0;
        final x = innerRect.left + rnd(k + 23) * (innerRect.width - w);
        final y = innerRect.top + rnd(k + 24) * (innerRect.height - h);
        canvas.drawRect(
          Rect.fromLTWH(x, y, w, h),
          Paint()
            ..blendMode = BlendMode.screen
            ..color = Colors.white.withOpacity(0.06 + rnd(k + 25) * 0.12),
        );
      }
    }

    // 3) 체커/격자(아주 가끔)
    if (rnd(40) > 0.75) {
      final cx = 3 + (rnd(41) * 3).floor(); // 3~5
      final cy = 3 + (rnd(42) * 3).floor();
      final cw = innerRect.width / cx;
      final ch = innerRect.height / cy;
      for (int y = 0; y < cy; y++) {
        for (int x = 0; x < cx; x++) {
          if ((x + y).isOdd && rnd(100 + x * 7 + y * 11) > 0.6) {
            final r = Rect.fromLTWH(
              innerRect.left + x * cw,
              innerRect.top + y * ch,
              cw,
              ch,
            );
            canvas.drawRect(
              r.deflate(0.8),
              Paint()
                ..blendMode = BlendMode.plus
                ..color = Colors.white.withOpacity(0.025),
            );
          }
        }
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 캔버스 마진
    final padding = size.shortestSide * 0.06;
    final field = Rect.fromLTWH(
      padding,
      padding,
      size.width - padding * 2,
      size.height - padding * 2,
    );

    // 셀 크기 계산(정사각형)
    final cellW = (field.width - (cols - 1) * gap) / cols; // 가로 기준 동일 간격
    final cellH = (field.height - (rows - 1) * gap) / rows;
    final cellSize = math.min(cellW, cellH);
    final startX =
        field.left + (field.width - (cellSize * cols + gap * (cols - 1))) / 2;
    final startY =
        field.top + (field.height - (cellSize * rows + gap * (rows - 1))) / 2;

    // 배경 아우라(아주 약한 붉은 빛 번짐)
    final bgPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 30)
      ..color = baseRed.withOpacity(0.05);
    canvas.drawRRect(
      RRect.fromRectAndRadius(field, const Radius.circular(24)),
      bgPaint,
    );

    // 그리드 렌더
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        final left = startX + i * (cellSize + gap);
        final top = startY + j * (cellSize + gap);
        final rect = Rect.fromLTWH(left, top, cellSize, cellSize);
        _paintCell(canvas, rect, i, j, time);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.time != time;
}

extension on int {
  bool get isOdd => this % 2 != 0;
}
