import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/constants/mokup.dart' as mokup;
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';
import 'package:tiktok_clone/homework_lib/homework_common/theme_provider.dart';
// import 'package:tiktok_clone/utils.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({super.key});

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settingList = mokup.settingList;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: themeProvider.bgColor,
      appBar: PersonalAppbar(title: 'settings', back: true),
      body: SafeArea(
        child: ListView.builder(
          itemCount: settingList.length,
          itemBuilder: (context, index) {
            final item = settingList[index];
            return Column(
              children: [
                if (index == 0)
                  Switch(
                    value: themeProvider.isDarkModeSwich,
                    onChanged: (bool? value) {
                      setState(() {
                        themeProvider.isDarkModeSwich = value ?? false;
                        // print(themeProvider.isDarkModeSwich);
                      });
                    },
                  ),
                ListTile(
                  leading: item["icon"] != null
                      ? FaIcon(item["icon"], color: themeProvider.textColor)
                      : null,

                  //themeProvider.textColor
                  title: Text(
                    item["title"],
                    style: TextStyle(color: themeProvider.textColor),
                  ),
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
