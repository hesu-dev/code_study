import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/mokup.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/widgets/interrest_button.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/bottom_btn.dart';
// import 'package:tiktok_clone/constants/mokup.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _onNextTap() {
    Navigator.pushNamed(context, "/tutorial");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: Duration(milliseconds: 300),
          child: PersonalAppbar(title: "Choose your interests"),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your interests",
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ), //Choose your interests
                Gaps.v20,
                Text("Get better video recommendations"),
                Gaps.v64,

                Wrap(
                  runSpacing: 20,
                  spacing: 15,
                  children: [
                    for (var interest in interests)
                      InterrestButton(interest: interest),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BottomBtn("Skip", Colors.white, onTap: () => _onNextTap()),
            ),
            Expanded(
              child: BottomBtn(
                "Next",
                Colors.black,
                onTap: () {
                  _onNextTap();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
