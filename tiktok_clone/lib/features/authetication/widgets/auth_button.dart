import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

enum ThemeType {
  dark('dark'),
  light('light');

  const ThemeType(this.value);
  final String value;

  factory ThemeType.getByCode(String code) {
    return ThemeType.values.firstWhere((value) => value.value == code);
  }
}

enum Rounding {
  border('border'),
  square('square');

  const Rounding(this.value);
  final String value;

  factory Rounding.getByCode(String code) {
    return Rounding.values.firstWhere((value) => value.value == code);
  }
}

class AuthButton extends StatelessWidget {
  final FaIcon? icon;
  final String text;
  final VoidCallback? onTap;
  final ThemeType themeType;
  final Rounding rounding;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.themeType = ThemeType.light,
    this.rounding = Rounding.square,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: EdgeInsets.all(Sizes.size14),
        decoration: BoxDecoration(
          color: themeType == ThemeType.light ? Colors.white : Colors.black,
          border: Border.all(color: Colors.grey.shade200, width: Sizes.size2),
          borderRadius: rounding == Rounding.border
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (icon != null)
                Align(alignment: Alignment.centerLeft, child: icon!),
              Align(
                child: Text(
                  text,
                  style: TextStyle(
                    color: themeType == ThemeType.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
