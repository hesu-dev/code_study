import 'package:flutter/material.dart';
import 'package:moviehomework/const/consts.dart';
import 'package:moviehomework/services/movieService.dart';
import 'package:moviehomework/widgets/scroll_widget.dart';
import 'package:moviehomework/widgets/text_widget.dart';

// 이하 요구사항
// (1). 앱은 2개 화면이 있어야 합니다: Home 그리고 Detail.
// (2). Home 스크린은 아래와 같은 기능을 갖고있어야 합니다.
// - 가장 인기 있는 영화 목록이 표시되어야 합니다.
// - 극장에서 상영 중인 영화 목록이 표시되어야 합니다.
// - 곧 개봉할 영화 목록이 표시되어야 합니다.
// - movie를 탭하면 세부정보 화면으로 이동해야 합니다.
// - 세부정보 화면에는 다음이 표시되어야 합니다.
//    영화의 포스터/ 영화의 제목 / 영화의 등급 / 영화의 개요 / 영화의 장르
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
