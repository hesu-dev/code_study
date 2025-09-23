import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _widthAnimation;
  late Animation<double> _slideAnimation;

  bool _isCircle = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _slideAnimation = Tween<double>(
      begin: 0,
      end: 180,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // 상태 변경 감지
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        // 왼쪽에서 → 오른쪽으로 이동 시작
        setState(() {
          _isCircle = false;
        });
      } else if (status == AnimationStatus.reverse) {
        setState(() {
          _isCircle = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _isCircle ? Colors.white : Colors.black,
      appBar: AppBar(title: const Text('Implict Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedAlign(
            //   duration: const Duration(seconds: 2),
            //   alignment: _visible ? Alignment.topLeft : Alignment.topRight,
            //   child: AnimatedOpacity(
            //     opacity: _visible ? 1 : 0.2,
            //     duration: const Duration(seconds: 2),
            //     child: Container(
            //       width: size.width * 0.02,
            //       height: size.width * 0.01,
            //       color: Colors.amber,
            //     ),
            //   ),
            // ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      shape: _isCircle ? BoxShape.circle : BoxShape.rectangle,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return Positioned(
                        left: _slideAnimation.value,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 20,
                          color: _isCircle ? Colors.black : Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // AnimatedBuilder(
            //   animation: _widthAnimation,
            //   builder: (context, child) {
            //     return Container(
            //       width: _widthAnimation.value,
            //       height: 200,
            //       decoration: BoxDecoration(
            //         color: Colors.red.shade400,
            //         border: Border(
            //           left: BorderSide(color: Colors.grey.shade200, width: 8),
            //         ),
            //       ),
            //     );
            //   },
            // ),

            // AnimatedContainer(
            //   duration: const Duration(seconds: 2),
            //   width: _visible ? size.width : size.width * 0.8,
            //   height: _visible ? size.width : size.width * 0.02,
            //   decoration: BoxDecoration(
            //     color: _visible ? Colors.red : Colors.amber,
            //   ),
            // // ),
            // const SizedBox(height: 10),
            // ElevatedButton(onPressed: _trigger, child: const Text('Go!')),
          ],
        ),
      ),
    );
  }
}
