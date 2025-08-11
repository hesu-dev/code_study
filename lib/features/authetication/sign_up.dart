import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authetication/login_screen.dart';
import 'package:tiktok_clone/features/authetication/widgets/auth_button.dart';
import 'package:tiktok_clone/homework_page/homework0811.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              // Text(
              //   "Sign Up fot TikTok",
              //   style: TextStyle(
              //     fontSize: Sizes.size28,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              // Gaps.v20,
              // Text(
              //   "Create a profile, follpw other accounts, make your own videos, and more",
              //   style: TextStyle(fontSize: Sizes.size16, color: Colors.black45),
              //   textAlign: TextAlign.center,
              // ),
              const Text(
                "See what's happening in the world right now",
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              // AuthButton(
              //   icon: FaIcon(FontAwesomeIcons.user),
              //   text: "Use phone or email",
              // ),
              // Gaps.v16,
              // AuthButton(
              //   icon: FaIcon(FontAwesomeIcons.facebook),
              //   text: "Continue with Facebook",
              // ),
              // Gaps.v16,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.google),
                text: "Continue with Google",
                onTap: () {},
              ),
              Gaps.v16,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.apple),
                text: "Continue with Apple",
                onTap: () {},
              ),
              Gaps.v96,

              // const Text(
              //   "By continuing, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect, use, and share your data",
              //   style: TextStyle(fontSize: Sizes.size16, color: Colors.black45),
              //   textAlign: TextAlign.center,
              // ),
              AuthButton(
                icon: null,
                text: "Create account",
                onTap: () => _onPageTap(context, (context) => Homework0811()),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.size14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onPageTap(context, (context) => LoginScreen()),
                child: Text(
                  "Log in",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
