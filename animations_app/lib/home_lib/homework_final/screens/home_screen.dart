import 'package:animations_app/home_lib/homework_final/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/page_sync_controller.dart';
import '../controllers/state_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageSyncController _pageController = PageSyncController();
  final ScreenStateNotifier _stateNotifier = ScreenStateNotifier();

  final PageController controller = PageController();
  int currentPage = 0;

  late AnimationController _arrowController;
  late Animation<double> _arrowAnimation;

  final ValueNotifier<bool> showDetail = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _arrowAnimation = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _stateNotifier.dispose();

    _arrowController.dispose();
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

  void _toggleDetail(bool value) {
    showDetail.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: showDetail,
        builder: (context, isDetailVisible, _) {
          return GestureDetector(
            onVerticalDragEnd: (details) {
              // _onTap();
              // if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
              //   _onTap();
              // }
              _toggleDetail(true);
            },
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController.delayedController,
                  itemBuilder: (_, i) => Stack(
                    children: [
                      Center(
                        child: Card(child: SizedBox(width: 300, height: 400)),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          key: ValueKey<int>(currentPage),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage("assets/covers/${i + 1}.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.6),
                ),
                Animate(
                  target: isDetailVisible ? 1 : 0,
                  effects: [
                    SlideEffect(
                      begin: Offset(0, 0),
                      end: Offset(0, 1),
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOutCubic,
                    ),
                  ],
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController.mainController,
                        onPageChanged: (i) =>
                            _pageController.syncPages(i.toDouble()),
                        itemBuilder: (_, i) => Center(
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: 370,
                                child: Container(
                                  width: 300,
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    100,
                                    16,
                                    24,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        "Title",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "sub blah~",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          5,
                                          (index) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Add to cart +",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 100,
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/covers/${i + 1}.jpg",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Animate(
                    target: isDetailVisible ? 1 : 0,
                    effects: [
                      SlideEffect(
                        begin: const Offset(0, -1),
                        end: const Offset(0, 0),
                        duration: Duration(seconds: 1),
                        curve: Curves.easeOutCubic,
                      ),
                    ],
                    child: GestureDetector(
                      onVerticalDragEnd: (details) {
                        if (details.primaryVelocity != null &&
                            details.primaryVelocity! > 0) {
                          _toggleDetail(false);
                        }
                      },
                      child: Stack(
                        children: [
                          // Container(
                          //   width: double.infinity,
                          //   height: double.infinity,
                          //   color: Colors.black.withOpacity(0.6),
                          // ),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 100,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "MAIN TITLE",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "official Rating",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      height: 1.4,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.star, color: Colors.amber),
                                      Icon(Icons.star, color: Colors.amber),
                                      Icon(Icons.star, color: Colors.amber),
                                      Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "sub Title",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      height: 1.4,
                                    ),
                                  ),
                                  Text(
                                    "BlahBlahBlahBlah\nBlahBlahBlahBlahBlahBlah.\n"
                                    "BlahBlahBlahBlah\nBlahBlahBlahBlahBlahBlah.",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedBuilder(
                  animation: _arrowAnimation,
                  builder: (context, child) {
                    return Positioned(
                      top: 40 + _arrowAnimation.value,
                      left: 0,
                      right: 0,
                      child: Center(child: child),
                    );
                  },
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      _onTap();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
