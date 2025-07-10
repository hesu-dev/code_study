import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRuning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRuning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(Duration(seconds: 1), onTick);
    setState(() {
      isRuning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRuning = false;
    });
  }

  String formet(int seconds) {
    return Duration(
      seconds: seconds,
    ).toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              width: 280,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Text(
                formet(totalSeconds),
                style: TextStyle(
                  fontSize: 66,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: isRuning ? onPausePressed : onStartPressed,
                icon: Icon(isRuning ? Icons.pause : Icons.play_arrow),
                label: Text('집중 시작하기', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.white,
                  // onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: StadiumBorder(),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '기록',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(
                                  context,
                                ).textTheme.headlineLarge!.color,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.book),
                            ),
                          ],
                        ),
                        // VerticalDivider(
                        //   width: 100,
                        //   thickness: 1.5,
                        //   color: Colors.grey,
                        //   indent: 10,
                        //   endIndent: 10,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '브라운노이즈',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(
                                  context,
                                ).textTheme.headlineLarge!.color,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final url = Uri.parse(
                                  'https://www.youtube.com/watch?v=Hvi8UDXFikk',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  ); // 외부 앱에서 열기
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              icon: Icon(Icons.headset_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
