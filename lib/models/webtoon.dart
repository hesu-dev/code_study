// import 'package:flutter/cupertino.dart';

class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel({required this.title, required this.thumb, required this.id});

  WebtoonModel.fromJSON(Map<String, dynamic> json)
    : title = json['title'],
      thumb = json['thumb'],
      id = json['id'];
}
