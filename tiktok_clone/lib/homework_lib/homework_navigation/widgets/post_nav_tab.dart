import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/homework_lib/homework_common/theme_provider.dart';

class HwNavTab extends StatelessWidget {
  const HwNavTab({
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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: themeProvider.bgColor,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: themeProvider.iconColor,
                ),
                Gaps.v5,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
