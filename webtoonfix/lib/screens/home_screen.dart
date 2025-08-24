import 'package:flutter/material.dart';
import 'package:webtoonfix/models/webtoon.dart';
import 'package:webtoonfix/service/api_sirvice.dart';
import 'package:webtoonfix/constants/font_data.dart';
import 'package:webtoonfix/wedgets/toon_widget.dart';

class HomeScreen extends StatelessWidget {
  final Future<List<WebtoonModel>> webtoons = ApiService().getTodaysToons();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 250.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                fontTexts['webtoon'] ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8), // 타이틀과 드롭다운 간격
              DropdownButton<String>(
                value: '옵션1',
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                underline: const SizedBox(), // 밑줄 제거
                style: const TextStyle(
                  fontSize: 16, // 타이틀보다 작은 글씨
                  color: Colors.grey,
                ),
                items: const [
                  DropdownMenuItem(value: '옵션1', child: Text('옵션1')),
                  DropdownMenuItem(value: '옵션2', child: Text('옵션2')),
                ],
                onChanged: (value) {
                  // 선택 시 처리
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(height: 70),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // UI
  GridView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.63,
      ),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonPage(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
    );
  }
}
