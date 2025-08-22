import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class HwNavTab extends StatelessWidget {
  HwNavTab({
    required this.isSelected,
    required this.icon,
    required this.selectedIcon,
    required this.onTap,
    super.key,
  });

  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: Colors.white,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(isSelected ? selectedIcon : icon, color: Colors.black),
                Gaps.v5,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
