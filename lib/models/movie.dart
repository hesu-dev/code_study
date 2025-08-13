// ignore_for_file: non_constant_identifier_names

class MovieModel {
  final String id;
  final String title;
  final String backdrop_path;
  final String poster_path;

  MovieModel({
    required this.id,
    required this.title,
    required this.backdrop_path,
    required this.poster_path,
  });

  MovieModel.fromJSON(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      backdrop_path =
          "https://image.tmdb.org/t/p/w500${json['backdrop_path'] ?? ""}",
      poster_path = "https://image.tmdb.org/t/p/w500" + json['poster_path'];
}
