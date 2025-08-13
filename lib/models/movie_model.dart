class MovieModel {
  final int id;
  final String title;
  final String vote_average;
  // final String releasedate;
  final String vote_count;
  final String backdrop_path;
  final String poster_path;

  MovieModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      vote_average = json['vote_average'].toString(),
      // release_date = json['release_date'].toString(),
      vote_count = json['vote_count'].toString(),
      backdrop_path =
          "https://image.tmdb.org/t/p/w500${json['backdrop_path'] ?? ""}",
      poster_path = "https://image.tmdb.org/t/p/w500" + json['poster_path'];
}
