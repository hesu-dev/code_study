// app_routes.dart
// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/number_page.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/password_page.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/signForm.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/sign_up_screen.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/main_navi.dart';
import 'package:tiktok_clone/homework_lib/homework_onboarding/interests_page.dart';
import 'package:tiktok_clone/main_btn_page.dart';

class AppRoutes {
  static const String mainbtnpage = 'mainBtnPage';
  //클론
  static const String home = '/home';
  static const String signup = '/sigUp';
  static const String login = '/login';
  static const String interest = '/interest';
  static const String tutorial = '/tutorial';

  //숙제용
  static String hwhome = '/hwhome';
  static const String intereshw = '/intereshw';
  static const String hwsignup = '/hwSignUp';
  static const String signfrom = '/signFrom';
  static const String pinNumber = '/pinNumber';
  static const String password = '/password';
  static const String hwinteres = '/hwinteres';
  // static const String terms = '/terms';
  // static const String privacy = '/privacy';
  // static const String cookie = '/cookie';

  static Map<String, WidgetBuilder> routes = {
    mainbtnpage: (context) => MainBtnPage(),

    //클론
    home: (context) => MainNavigationScreen(),
    signup: (context) => const SignUpScreen(),
    interest: (context) => const InterestsScreen(),
    tutorial: (context) => const TutorialScreen(),
    login: (context) => const LoginScreen(),

    //숙제용
    hwhome: (context) => MainNavi(),
    hwsignup: (context) => const HomeworkSignUpScreen(),
    signfrom: (context) => const Signform(),
    pinNumber: (context) {
      final argument =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      return HomeworkPinCheck(
        email: argument?['email'] ?? 'nell@naver.com',
        length: argument?['length'] ?? 4,
      );
    },
    password: (context) => const PasswordPage(),
    hwinteres: (context) => const InterestsPage(),
    // terms: (context) => const TermsPage(),
    // privacy: (context) => const PrivacyPage(),
    // cookie: (context) => const CookiePage(),
  };
}
