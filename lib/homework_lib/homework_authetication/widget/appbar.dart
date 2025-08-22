import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class PersonalAppbar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool back;

  PersonalAppbar({super.key, this.back = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // shadowColor: Colors.white,
      // foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: back == true
          ? IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft),
            )
          : Container(),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
