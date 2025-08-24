class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'], name: json['name']);
  }
}

class MovieDetailModel {
  final int id;
  final String title;
  final String overview;
  final double voteAverage;
  final List<Genre> genres;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] is int)
          ? (json['vote_average'] as int).toDouble()
          : (json['vote_average'] ?? 0.0),
      genres: (json['genres'] as List).map((g) => Genre.fromJson(g)).toList(),
    );
  }
}
