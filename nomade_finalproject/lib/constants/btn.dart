import 'package:flutter/material.dart';

class Btn {
  static const Color backgroundBeige = Color(0xFFF2E9C9);
  static Color pinkButton = Color(0xFFFFB3E6);

  static Widget pinkButtonWidget({
    required String text,
    required VoidCallback onTap,
    double horizontalPadding = 48,
    double verticalPadding = 14,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: pinkButton,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            // 오른쪽 아래에 검은 그림자(오프셋) 로 버튼 테두리 느낌
            BoxShadow(color: Colors.black, offset: Offset(4, 4), blurRadius: 0),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
