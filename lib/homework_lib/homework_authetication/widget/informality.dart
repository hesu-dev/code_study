import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class Informality extends StatelessWidget {
  const Informality({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          children: [
            const TextSpan(text: "회원 가입시, "),
            //By signing up, you agree to our
            TextSpan(
              text: "이용약관", //Terms
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, "/terms");
                },
            ),
            const TextSpan(text: ", "),
            TextSpan(
              text: "개인정보 처리방침", //Privacy Policy
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, "/privacy");
                },
            ),
            const TextSpan(text: ", 그리고 \n"),
            TextSpan(
              text: "쿠키 사용", //Cookie Use
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, "/cookie");
                },
            ),
            TextSpan(text: "에 동의하게 됩니다."),
            const TextSpan(text: ".\n\n"),
            const TextSpan(text: "이미 계정이 있나요? : "),
            //Have an account already?
            TextSpan(
              text: "Log-in",
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, "/login");
                },
            ),
          ],
        ),
      ),
    );
  }
}
