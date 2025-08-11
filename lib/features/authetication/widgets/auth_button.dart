import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final FaIcon? icon;
  final String text;
  final VoidCallback? onTap;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: EdgeInsets.all(Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200, width: Sizes.size2),
        ),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            alignment: Alignment.center,
            children: [
              if (icon != null)
                Align(alignment: Alignment.centerLeft, child: icon!),
              Align(child: Text(text, textAlign: TextAlign.center)),
            ],
          ),
        ),
      ),
    );
  }
}
