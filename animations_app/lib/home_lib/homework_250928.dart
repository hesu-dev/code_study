import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const int totalSeconds = 15;
  int elapsed = 0; // 0 -> 900
  bool isRunning = false;
  Timer? _ticker;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (isRunning) {
      _pause();
    } else {
      _start();
    }
  }

  void _start() {
    setState(() => isRunning = true);
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (elapsed + 1 >= totalSeconds) {
        // 15분 도달 → 초기화 후 정지
        setState(() {
          elapsed = 0;
          isRunning = false;
        });
        t.cancel();
      } else {
        setState(() => elapsed += 1);
      }
    });
  }

  void _pause() {
    setState(() => isRunning = false);
    _ticker?.cancel();
  }

  void _reset() {
    _ticker?.cancel();
    setState(() {
      elapsed = 0;
      isRunning = false;
    });
  }

  String _format(int s) {
    final m = s ~/ 60;
    final ss = s % 60;
    return '${m.toString().padLeft(2, '0')}:${ss.toString().padLeft(2, '0')}';
    // 예: 03:47
  }

  @override
  Widget build(BuildContext context) {
    final progress = elapsed / totalSeconds; // 0.0 ~ 1.0
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            // 원형 타이머
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 260,
                  height: 260,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 배경 링
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 16,
                          valueColor: AlwaysStoppedAnimation(
                            Colors.grey.shade200,
                          ),
                        ),
                      ),
                      // 진행 링
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: CircularProgressIndicator(
                          value: progress == 0 ? 0.001 : progress,
                          strokeWidth: 16,
                          backgroundColor: Colors.transparent,
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.redAccent,
                          ),
                        ),
                      ),
                      // 중앙 시간 텍스트
                      Text(
                        _format(elapsed),
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // 하단 컨트롤(좌: 되감기/리셋, 중: 재생/일시정지, 우: 정지=리셋)
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RoundIconButton(icon: Icons.refresh, onTap: _reset),
                  const SizedBox(width: 28),
                  GestureDetector(
                    onTap: _toggle,
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF7A7A), Color(0xFFFF5252)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 16,
                            spreadRadius: 0,
                            offset: Offset(0, 8),
                            color: Color(0x22FF5252),
                          ),
                        ],
                      ),
                      child: Icon(
                        isRunning
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 44,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 28),
                  _RoundIconButton(icon: Icons.stop_rounded, onTap: _reset),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 28, color: Colors.black54),
      ),
    );
  }
}
