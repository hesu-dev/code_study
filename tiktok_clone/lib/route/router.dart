import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/number_page.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/password_page.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/signForm.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/sign_up_screen.dart';
import 'package:tiktok_clone/homework_lib/homework_camera/picture_recording_page.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/main_navi.dart';
import 'package:tiktok_clone/homework_lib/homework_onboarding/interests_page.dart';
import 'package:tiktok_clone/main_btn_page.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpScreen.routeURL &&
            state.matchedLocation != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: InterestsScreen.routeName,
        path: InterestsScreen.routeURL,
        builder: (context, state) => const InterestsScreen(),
      ),
      GoRoute(
        path: "/:tab(home|discover|inbox|profile)",
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.pathParameters["tab"]!;
          return MainNavigationScreen(tab: tab);
        },
      ),
      GoRoute(
        name: ActivityScreen.routeName,
        path: ActivityScreen.routeURL,
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        name: ChatsScreen.routeName,
        path: ChatsScreen.routeURL,
        builder: (context, state) => const ChatsScreen(),
        routes: [
          GoRoute(
            name: ChatDetailScreen.routeName,
            path: ChatDetailScreen.routeURL,
            builder: (context, state) {
              final chatId = state.pathParameters["chatId"]!;
              return ChatDetailScreen(chatId: chatId);
            },
          ),
        ],
      ),
      GoRoute(
        path: VideoRecordingScreen.routeURL,
        name: VideoRecordingScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 200),
          child: const VideoRecordingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final position = Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(position: position, child: child);
          },
        ),
      ),

      GoRoute(
        path: MainBtnPage.routeURL,
        name: MainBtnPage.routeName,
        builder: (context, state) => MainBtnPage(),
      ),
      // 숙제용
      GoRoute(
        path: '/hwhome',
        name: 'hwhome',
        builder: (context, state) => MainNavi(),
      ),
      GoRoute(
        path: '/hwSignUp',
        name: 'hwsignup',
        builder: (context, state) => const HomeworkSignUpScreen(),
      ),
      GoRoute(
        path: '/signFrom',
        name: 'signfrom',
        builder: (context, state) => const Signform(),
      ),
      GoRoute(
        path: '/pinNumber',
        name: 'pinNumber',
        builder: (context, state) {
          final argument = state.extra as Map<String, dynamic>?;
          return HomeworkPinCheck(
            email: argument?['email'] ?? 'nell@naver.com',
            length: argument?['length'] ?? 4,
          );
        },
      ),
      GoRoute(
        path: '/password',
        name: 'password',
        builder: (context, state) => const PasswordPage(),
      ),
      GoRoute(
        path: '/hwinteres',
        name: 'hwinteres',
        builder: (context, state) => const InterestsPage(),
      ),
      GoRoute(
        path: '/hwcamera',
        name: 'hwcamera',
        builder: (context, state) => const PictureRecordingPage(),
      ),
    ],
  );
});
