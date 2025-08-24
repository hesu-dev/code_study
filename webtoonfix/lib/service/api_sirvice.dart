import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:webtoonfix/models/webtoon.dart';

class ApiService {
  static const baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const today = "today";
  final logger = Logger();

  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJSON(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
