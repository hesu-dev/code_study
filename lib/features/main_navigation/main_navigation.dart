import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _seletedIndex = 0;
  final screens = [Center(child: Text('Home')), Center(child: Text('Search'))];

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
        color: Colors.black,
        child: Padding(
          padding: EdgeInsetsGeometry.all(Sizes.size2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: 'home',
                isSelected: _seletedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: 'Discover',
                isSelected: _seletedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
              ),
              NavTab(
                text: 'index',
                isSelected: _seletedIndex == 2,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(2),
              ),
              NavTab(
                text: 'profile',
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
