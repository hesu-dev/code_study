import 'package:flutter/material.dart';
import '../controllers/page_sync_controller.dart';
import '../screens/detail_screen.dart';

class CardStack extends StatelessWidget {
  final PageSyncController controller;
  final VoidCallback onTap;

  const CardStack({super.key, required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller.delayedController,
          itemBuilder: (_, i) => Stack(
            children: [
              Center(child: Card(child: SizedBox(width: 300, height: 400))),
              Container(
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
                // child: Center(child: Text("Main $i")),
              ),
            ],
          ),
        ),
        PageView.builder(
          controller: controller.mainController,
          onPageChanged: (i) => controller.syncPages(i.toDouble()),
          itemBuilder: (_, i) => Center(
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null &&
                    details.primaryVelocity! < 0) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return FadeTransition(
                          opacity: animation,
                          child: const DetailScreen(),
                        );
                      },
                    ),
                  );
                }
              },
              child: Card(
                elevation: 10,
                child: Container(
                  width: 230,
                  height: 260,
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
                  // child: Center(child: Text("Main $i")),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
