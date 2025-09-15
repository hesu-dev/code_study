import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../homework_common/theme_provider.dart';

// ignore: must_be_immutable
class PersonalAppbar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool back;

  PersonalAppbar({super.key, this.back = false, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return AppBar(
      backgroundColor: themeProvider.bgColor,
      // shadowColor: Colors.white,
      // foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: back == true
          ? IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: themeProvider.textColor,
              ),
            )
          : Container(),
      title: Text(title, style: TextStyle(color: themeProvider.textColor)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
