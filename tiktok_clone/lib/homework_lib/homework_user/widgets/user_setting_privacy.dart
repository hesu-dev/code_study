import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/mokup.dart' as mokup;
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';

class UserSettingPrivacyPage extends StatelessWidget {
  const UserSettingPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settingList = mokup.privacyList;

    return Scaffold(
      appBar: PersonalAppbar(title: 'privacy', back: true),
      body: SafeArea(
        child: ListView.builder(
          itemCount: settingList.length,
          itemBuilder: (context, index) {
            final item = settingList[index];
            return Column(
              children: [
                ListTile(
                  leading: item["icon"] != null
                      ? FaIcon(item["icon"], color: Colors.black)
                      : null,
                  title: Text(item["title"]),
                  trailing: item["trailing"],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item["title"]} 클릭됨")),
                    );
                  },
                ),
                if (index == 3 || index == 4)
                  const Divider(thickness: 1, indent: 16, endIndent: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
