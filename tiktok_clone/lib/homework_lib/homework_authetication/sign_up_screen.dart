import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authetication/widgets/auth_button.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/informality.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/signForm.dart';

class HomeworkSignUpScreen extends StatelessWidget {
  const HomeworkSignUpScreen({super.key});

  void _onPageTap(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                "어서오세요!", //See what's happening in the world right now?
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.google),
                text: "구글로 로그인", //Continue with Google
                rounding: Rounding.border,
                onTap: () {},
              ),
              Gaps.v16,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.apple),
                text: "애플로 로그인", //Continue with Apple
                rounding: Rounding.border,
                onTap: () {},
              ),
              Gaps.v32,
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size11,
                    ),
                    child: Text("or", style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),
              Gaps.v12,
              AuthButton(
                icon: null,
                text: "계정 새로 만들기", //Create account
                themeType: ThemeType.dark,
                rounding: Rounding.border,
                onTap: () => _onPageTap(context, (context) => Signform()),
              ),
              Gaps.v60,
              Informality(),
            ],
          ),
        ),
      ),
    );
  }
}
