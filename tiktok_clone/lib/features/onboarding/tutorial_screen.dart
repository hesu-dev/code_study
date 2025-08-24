import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/bottom_btn.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  bool get pageIndicator => _direction == Direction.right;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onNextTap() {
    Navigator.pushNamed(context, "/home");
  }

  void _togglePage() {
    setState(() {
      _showingPage = Page.second;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: Center(
                child: Column(
                  children: [
                    Gaps.v52,
                    Padding(
                      padding: const EdgeInsets.all(Sizes.size96),
                      child: Center(
                        child: Image.asset(
                          'assets/img/onboarding1.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "타이틀", //watch your videos-page1
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      "원하는 것을 즐겨보세요",
                      style: TextStyle(fontSize: Sizes.size20),
                    ),
                  ],
                ),
              ),
              secondChild: Center(
                child: Column(
                  children: [
                    Gaps.v52,
                    Padding(
                      padding: const EdgeInsets.all(Sizes.size96),
                      child: Center(
                        child: Image.asset(
                          'assets/img/onboarding2.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "타이틀",
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 120,
          color: Colors.white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(isActive: pageIndicator),
                  _buildIndicator(isActive: !pageIndicator),
                ],
              ),
              Gaps.v28,
              SizedBox(
                width: double.infinity,
                child: BottomBtn(
                  _showingPage != Page.second
                      ? "Next"
                      : "Get started", //Enter the app!

                  _showingPage != Page.second ? Colors.white : Colors.black,
                  onTap: () {
                    if (_showingPage != Page.second) {
                      _togglePage();
                    } else {
                      _onNextTap();
                    }
                  },
                ),
              ),
              // AnimatedOpacity(
              //   duration: Duration(milliseconds: 300),
              //   opacity: _showingPage == Page.second ? 1 : 0,
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: IgnorePointer(
              //       ignoring: _showingPage != Page.second,
              //       child: BottomBtn(
              //         "앱 시작하기", //Enter the app!
              //         Colors.black,
              //         onTap: () {
              //           _onNextTap();
              //         },
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.redAccent : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
