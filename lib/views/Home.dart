import 'package:flutter/material.dart';
import 'package:moviehomework/const/consts.dart';
import 'package:moviehomework/services/movieService.dart';
import 'package:moviehomework/widgets/scroll_widget.dart';
import 'package:moviehomework/widgets/text_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final T = TextWidget();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            T.hText('Popular Movies List', '지금 인기있는'),
            Gaps.v10,
            MoviesScrollWidget(
              fetchType: FetchType.popular,
              imageHeight: 380, //popular,
              heghit: 400,
            ),
            Gaps.v20,
            T.hText('Now in Clnemas', '오직 극장에서만'),
            Gaps.v10,
            MoviesScrollWidget(
              fetchType: FetchType.nowPlaying,
              imageHeight: 150,
              visibleTitle: true,
            ),
            Gaps.v20,
            T.hText('Coming soon ', '곧 개봉 예정!'),
            Gaps.v10,
            MoviesScrollWidget(
              fetchType: FetchType.comingSoon,
              imageHeight: 100,
              visibleTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
