import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authetication/login_screen.dart';
import 'package:tiktok_clone/features/authetication/widgets/auth_button.dart';
import 'package:tiktok_clone/homework_page/homework_signForm.dart';

class HomeworkSwitch extends StatefulWidget {
  const HomeworkSwitch({super.key});

  @override
  State<HomeworkSwitch> createState() => _HomeworkSwitchState();
}

class _HomeworkSwitchState extends State<HomeworkSwitch> {
  bool _isSwitched = false;

  void _onPageTap(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                "Customize your experienace",
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              Gaps.v96,
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
              ),
              Text(
                "Terms, Privact Policy, Cookie Use...blah blah blah blah blah blah",
                style: TextStyle(fontSize: Sizes.size16, color: Colors.black45),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        elevation: 5,
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
            decoration: BoxDecoration(
              color: _isSwitched == false
                  ? Colors.grey.shade400
                  : Theme.of(context).primaryColor,
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: const Text(
                'Next',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
