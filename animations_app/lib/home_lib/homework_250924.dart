import 'package:flutter/material.dart';

class BlinkingGrid extends StatefulWidget {
  const BlinkingGrid({super.key});

  @override
  State<BlinkingGrid> createState() => _BlinkingGridState();
}

class _BlinkingGridState extends State<BlinkingGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const int rows = 5;
  static const int cols = 5;
  static const int totalCells = rows * cols;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // 계속 반복
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 각 셀의 인덱스를 지그재그 순서대로 매핑
  int _zigzagIndex(int row, int col) {
    int invertedRow = (rows - 1 - row); // 아래에서 위로
    if (invertedRow.isEven) {
      // 왼쪽→오른쪽
      return invertedRow * cols + col;
    } else {
      // 오른쪽→왼쪽
      return invertedRow * cols + (cols - 1 - col);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(rows, (row) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(cols, (col) {
                int order = _zigzagIndex(row, col);
                double cellDuration = 1.0 / totalCells;
                double start = order * cellDuration;
                double end = start + cellDuration;

                // 현재 progress
                double t = _controller.value;

                // 해당 셀이 켜지는 구간
                bool isOn = t >= start && t < end;

                return Container(
                  margin: const EdgeInsets.all(4),
                  width: 30,
                  height: 30,
                  color: isOn ? Colors.red : Colors.red.withOpacity(0.2),
                );
              }),
            );
          }),
        );
      },
    );
  }
}
