import 'package:flutter/material.dart';
import 'package:moviehomework/models/movie_model.dart';
import 'package:moviehomework/services/movieService.dart';
import 'package:moviehomework/widgets/detail_movie.dart';

enum ImageType {
  popular(380),
  square(150),
  card(200);

  final double value;
  const ImageType(this.value);
}

class ScrollableMovies extends StatelessWidget {
  final ImageType imageType;
  final bool visibleTitle;
  final FetchType fetchType;
  final double heghit;

  const ScrollableMovies({
    super.key,
    required this.imageType,
    required this.fetchType,
    this.visibleTitle = false,
    this.heghit = 150,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: MovieApiService.fetchMovies(fetchType),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final movie in movies) ...[
                  Stack(
                    children: [
                      SizedBox(
                        width: imageType.value,
                        height: null,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) {
                                      return DetailMovie(
                                        id: movie.id,
                                        title: movie.title,
                                        backdroppath: movie.backdrop_path,
                                        posterpath: movie.poster_path,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    movie.poster_path,
                                    fit: BoxFit.cover,
                                    width: imageType.value,
                                    height: heghit,
                                  ),
                                ),
                              ),
                            ),
                            visibleTitle
                                ? Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      movie.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const Text(""),
                          ],
                        ),
                      ),

                      fetchType == FetchType.popular
                          ? Positioned(
                              left: 10,
                              right: 0,
                              bottom: 20,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "${movie.title} | 평점: ${movie.vote_average} 점",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,

                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: imageType.value,
                  height: heghit,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          );
        }
      },
    );
  }
}
