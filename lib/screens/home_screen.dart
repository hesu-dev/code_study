import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, int>> minutes = [
    {"test": 2},
    {"15": 900},
    {"20": 1200},
    {"25": 1500},
    {"30": 1800},
    {"35": 2100},
  ];

  int constMinutes = 0;
  int totalSeconds = 0;
  int totalRest = 0;
  bool isRuning = false;
  int totalPomodoros = 0;
  int totalRound = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        totalRest = totalRest + 1;
        isRuning = false;
        totalSeconds = constMinutes;
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
            flex: 2,
            child: Container(
              width: 280,
              alignment: Alignment.center,

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
          // Expanded(child:
          // ),
          Flexible(
            flex: 0,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: minutes.map((item) {
                    final labelText = item.keys.first;
                    final value = item.values.first;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            totalSeconds = value;
                            constMinutes = value;
                          }),
                          if (totalSeconds != 0) {isRuning = false},
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          '$labelText분',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                onPressed: () {
                  if (isRuning) {
                    onPausePressed();
                  } else {
                    if (totalRest > 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$totalPomodoros회가 지났으니 2초간 쉬어야 합니다.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(Duration(seconds: 2));
                      totalRest = 0;
                      totalRound = totalRound + 1;
                      return;
                    }
                    onStartPressed();
                  }
                },
                icon: Icon(isRuning ? Icons.pause : Icons.play_arrow),
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.white,
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
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.book),
                            // ),
                            Text(
                              '$totalPomodoros/3',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(
                                  context,
                                ).textTheme.headlineLarge!.color,
                              ),
                            ),
                            Text(
                              'ROUND',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(
                                  context,
                                ).textTheme.headlineLarge!.color,
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          thickness: 1.5,
                          color: Colors.grey,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // IconButton(
                            //   onPressed: () async {
                            //     final url = Uri.parse(
                            //       'https://www.youtube.com/watch?v=Hvi8UDXFikk',
                            //     );
                            //     if (await canLaunchUrl(url)) {
                            //       await launchUrl(
                            //         url,
                            //         mode: LaunchMode.externalApplication,
                            //       ); // 외부 앱에서 열기
                            //     } else {
                            //       throw 'Could not launch $url';
                            //     }
                            //   },
                            //   icon: Icon(Icons.headset_outlined),
                            // ),
                            Text(
                              '$totalRound/12',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(
                                  context,
                                ).textTheme.headlineLarge!.color,
                              ),
                            ),
                            Text(
                              'GOAL',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(
                                  context,
                                ).textTheme.headlineLarge!.color,
                              ),
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
