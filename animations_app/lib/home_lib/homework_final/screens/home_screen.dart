import 'package:animations_app/home_lib/homework_final/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import '../controllers/page_sync_controller.dart';
import '../controllers/state_notifier.dart';
import '../widgets/card_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageSyncController _pageController = PageSyncController();
  final ScreenStateNotifier _stateNotifier = ScreenStateNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _stateNotifier.dispose();
    super.dispose();
  }

  void _onTap() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(opacity: animation, child: DetailScreen());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [CardStack(controller: _pageController, onTap: _onTap)],
      ),
    );
  }
}
