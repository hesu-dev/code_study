import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class OtpBox extends StatelessWidget {
  OtpBox({super.key, required this.txtController, required this.fieldlength});

  final TextEditingController txtController;
  final int fieldlength;

  final List<TextEditingController> textControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<FocusNode> textFocusNodes = List.generate(5, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            return SizedBox(
              width: 50,
              child: TextField(
                controller: textControllers[index],
                focusNode: textFocusNodes[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.size52,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, //숫자만 입력하도록
                  LengthLimitingTextInputFormatter(1), //글자 수 제한(현재 1개)
                ],
                onChanged: (value) {
                  if (value.isNotEmpty && index < 4) {
                    textFocusNodes[index + 1].requestFocus();
                  } else if (value.isEmpty && index > 0) {
                    textFocusNodes[index - 1].requestFocus();
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBox(BuildContext context, String char) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      width: Sizes.size40,
      height: Sizes.size60,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            char,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 48,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
