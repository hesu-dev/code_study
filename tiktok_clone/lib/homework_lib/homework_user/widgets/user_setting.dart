import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/mokup.dart' as mokup;
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';

class UserSettingPage extends StatelessWidget {
  const UserSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settingList = mokup.settingList;

    return Scaffold(
      appBar: PersonalAppbar(title: 'settings', back: true),
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
                  onTap: () {
                    final page = item["page"];
                    if (page != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => page),
                      );
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("준비중입니다")));
                    }
                  },
                ),
                if (index == 4)
                  const Divider(thickness: 1, indent: 16, endIndent: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
