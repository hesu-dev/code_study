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
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v52,
                  Text(
                    "watch your videos-page1",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v20,
                  Text("videos~~", style: TextStyle(fontSize: Sizes.size20)),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v80,
                  Text(
                    "watch your videos-page2",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _showingPage == Page.second ? 1 : 0,
            child: BottomBtn(
              "Enter the app!",
              Colors.black,
              onTap: () {
                _onNextTap();
              },
            ),
          ),
        ),
      ),
    );
  }
}
