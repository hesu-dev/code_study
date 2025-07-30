import 'package:flutter/material.dart';
import 'package:webtoonfix/constants/font_data.dart';
import 'package:webtoonfix/screens/detail_screen.dart';

class WebtoonPage extends StatelessWidget {
  final String title, thumb, id;

  const WebtoonPage({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dayOfWeek = weekDays[today.weekday - 1];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(
                  thumb,
                  headers: {'Referer': 'https://comic.naver.com'},
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 63, 63, 63),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    dayOfWeek,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // if (index < 5)
              //   Positioned(
              //     bottom: 0,
              //     right: 0,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 8,
              //         vertical: 4,
              //       ),
              //       decoration: BoxDecoration(
              //         color: Colors.redAccent,
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: Text(
              //         fontTexts['top3'] ?? '',
              //         style: TextStyle(
              //           fontSize: 10,
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
          SizedBox(height: 5),
          Text(title.length > 10 ? '${title.substring(0, 10)}...' : title),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
