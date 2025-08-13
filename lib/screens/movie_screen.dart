import 'package:flutter/material.dart';
import 'package:webtoonfix/models/movie.dart';
import 'package:webtoonfix/constants/font_data.dart';
import 'package:webtoonfix/service/movie_service.dart';
import 'package:webtoonfix/wedgets/movie_widget.dart';

class MovieScreen extends StatelessWidget {
  final Future<List<MovieModel>> movieModel = MovieApiService().();

  MovieScreen({super.key});

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
                fontTexts['movie'] ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: movieModel,
        builder: (context, snapshot) {
          // print(movieModel);
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(height: 70),
                // Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // UI
  GridView makeList(AsyncSnapshot<List<MovieModel>> snapshot) {
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
        var movie = snapshot.data![index];
        return MoviePage(
          title: movie.title,
          thumb: movie.backdrop_path,
          id: movie.id,
        );
      },
    );
  }
}
