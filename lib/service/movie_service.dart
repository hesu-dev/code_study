import 'dart:convert';
// import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:webtoonfix/models/movie.dart';

enum FetchType {
  popular('popular'),
  nowPlaying('now-playing'),
  comingSoon('coming-soon');

  const FetchType(this.value);
  final String value;

  factory FetchType.getByCode(String code) {
    return FetchType.values.firstWhere((value) => value.value == code);
  }
}

class MovieApiService {
  static const baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<MovieModel>> fetchMovies(FetchType fetchType) async {
    final url = Uri.parse('$baseUrl/${fetchType.value}');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      // print(Error());
      throw Exception("Failed");
    }

    final movies = jsonDecode(response.body)['results'];
    return movies.map<MovieModel>(MovieModel.fromJSON).toList();
  }
}
