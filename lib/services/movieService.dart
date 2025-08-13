import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviehomework/models/movie_detail_model.dart';
import 'package:moviehomework/models/movie_model.dart';

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
    final decoded = jsonDecode(response.body);
    List<dynamic> movieJsonList;
    if (decoded is List) {
      movieJsonList = decoded;
    } else if (decoded is Map && decoded.containsKey('results')) {
      movieJsonList = decoded['results'];
    } else {
      throw Exception("Unexpected API response format");
    }

    // print("movieJsonList:");
    // print(movieJsonList);

    return movieJsonList
        .map<MovieModel>(
          (e) => MovieModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();
  }

  static Future<MovieDetailModel> fetchMovieId(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    final Map<String, dynamic> movieJson = jsonDecode(response.body);
    return MovieDetailModel.fromJson(movieJson);
  }
}
