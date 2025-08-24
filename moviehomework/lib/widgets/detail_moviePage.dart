// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:moviehomework/services/movieService.dart';
import 'package:moviehomework/widgets/text_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final T = TextWidget();
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
                    T.textWidget(title, fontSize: 30),
                    T.textWidget(
                      "\n평점: ${movie.voteAverage.toString()} | ${movie.genres.map((g) => g.name).join(", ")}",
                      fontWeight: FontWeight.w400,
                    ),
                    T.textWidget(
                      "${movie.genres.map((g) => g.name).join(", ")}",
                      fontWeight: FontWeight.w400,
                    ),
                    T.textWidget(
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
