// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:moviehomework/services/movieService.dart';

class DetailMovie extends StatelessWidget {
  final int id;
  final String title;
  final String backdroppath;
  final String posterpath;

  const DetailMovie({
    super.key,
    required this.id,
    required this.title,
    required this.backdroppath,
    required this.posterpath,
  });

  Widget textWidget(
    String content, {
    double fontSize = 18,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w700,
    Color fontColor = Colors.white,
  }) {
    return Text(
      content,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),

        title: Text(title),
      ),
      body: FutureBuilder(
        future: MovieApiService.fetchMovieId(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final movie = snapshot.data!;
          return Stack(
            children: [
              SizedBox.expand(
                child: Image.network(posterpath, fit: BoxFit.cover),
              ),
              Container(color: Colors.black.withOpacity(0.4)),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //제목
                    textWidget(title, fontSize: 30),

                    textWidget(
                      "\n평점: ${movie.voteAverage.toString()} | ${movie.genres.map((g) => g.name).join(", ")}",

                      fontWeight: FontWeight.w400,
                    ),
                    textWidget(
                      "개봉일: " +
                          // ${movie.release_date}
                          "| ${movie.genres.map((g) => g.name).join(", ")}",

                      fontWeight: FontWeight.w400,
                    ),
                    //개요
                    // textWidget("\n'StoryLine'"),
                    textWidget(
                      "\n\n${movie.overview}",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
