import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/hw_nav_tab.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_page.dart';

class MainNavi extends StatefulWidget {
  const MainNavi({super.key});

  @override
  State<MainNavi> createState() => _MainNaviState();
}

class _MainNaviState extends State<MainNavi> {
  int _seletedIndex = 0;
  final screens = [
    Center(child: PostPage()), //1
    Center(child: Text('Home')), //2
    Center(child: Text('Search')), //3
    Center(child: Text('Search')), //4
  ];

  void _onTap(int index) {
    setState(() {
      _seletedIndex = index;
      // print(_seletedIndex);
    });
  }

  //https://m3.material.io/components/navigation-bar/overview

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
