import 'package:flutter/material.dart';
import 'package:moviehomework/consts.dart';
import 'package:moviehomework/services/movieService.dart';
import 'package:moviehomework/widgets/scrollable_movies.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget hText(String h1text, String h2text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            h1text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            h2text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hText('Popular Movies List', '지금 인기있는'),
            Gaps.v10,
            ScrollableMovies(
              fetchType: FetchType.popular,
              imageType: ImageType.popular,
              heghit: 400,
            ),
            Gaps.v20,
            hText('Now in Clnemas', '오직 극장에서만'),
            Gaps.v10,
            ScrollableMovies(
              fetchType: FetchType.nowPlaying,
              imageType: ImageType.card,
              visibleTitle: true,
            ),
            Gaps.v20,
            //Coming soon 곧 개봉 예정
            hText('Coming soon ', '곧 개봉 예정!'),
            Gaps.v10,
            ScrollableMovies(
              fetchType: FetchType.comingSoon,
              imageType: ImageType.square,
              visibleTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
