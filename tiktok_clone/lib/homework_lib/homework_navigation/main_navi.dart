// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/activity_page.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_nav_tab.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/post_page.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/search_page.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_write_sheet.dart';
import 'package:tiktok_clone/homework_lib/homework_user/user_profile_page.dart';

class MainNavi extends StatefulWidget {
  const MainNavi({super.key});

  @override
  State<MainNavi> createState() => _MainNaviState();
}

class _MainNaviState extends State<MainNavi> {
  int _seletedIndex = 0;
  int _lastIndex = 0;

  void _onTap(int index) {
    setState(() {
      _seletedIndex = index;
      if (_seletedIndex != 2) {
        _lastIndex = _seletedIndex;
      }
      // print(_seletedIndex);
    });
  }

  //https://m3.material.io/components/navigation-bar/overview

  @override
  Widget build(BuildContext context) {
    if (_seletedIndex == 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: false,
          showDragHandle: true,
          builder: (context) {
            final screenHeight = MediaQuery.of(context).size.height;
            return SizedBox(height: screenHeight, child: PostWriteSheet());
          },
        ).then((_) {
          setState(() {
            _seletedIndex = _lastIndex;
          });
        });
      });
    }

    final screens = [
      Offstage(offstage: _seletedIndex != 0, child: PostPage()),
      Offstage(offstage: _seletedIndex != 1, child: SearchPage()), //1
      Offstage(offstage: _seletedIndex != 2, child: Container()), //2
      Offstage(offstage: _seletedIndex != 3, child: ActivityPage()),
      Offstage(offstage: _seletedIndex != 4, child: UserProfilePage()), //4
    ];

    return Scaffold(
      appBar: PersonalAppbar(back: false, title: "로고"),
      body: screens[_seletedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsetsGeometry.all(Sizes.size2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HwNavTab(
                isSelected: _seletedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              HwNavTab(
                isSelected: _seletedIndex == 1,
                icon: FontAwesomeIcons.search,
                selectedIcon: FontAwesomeIcons.solidSquareCheck,
                onTap: () => _onTap(1),
              ),
              HwNavTab(
                isSelected: _seletedIndex == 2,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(2),
              ),
              HwNavTab(
                isSelected: _seletedIndex == 3,
                icon: FontAwesomeIcons.heart,
                selectedIcon: FontAwesomeIcons.heartPulse,
                onTap: () => _onTap(3),
              ),
              HwNavTab(
                isSelected: _seletedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
