import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/homework_lib/homework_user/widgets/user_setting.dart';

class UserSettingBtn extends StatelessWidget {
  const UserSettingBtn({super.key, required this.index});

  final int index;

  void nextSettingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UserSettingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${index + 5}h'),
          Gaps.h10,
          GestureDetector(
            onTap: () {
              // nextSettingPage(context);
            },
            child: FaIcon(FontAwesomeIcons.ellipsisVertical),
          ),
        ],
      ),
    );
  }
}
