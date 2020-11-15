import 'package:flutter/foundation.dart';

class Catogory {
  String id;
  dynamic symbol;
  String title;
  String imageUrl;

  Catogory({
    @required this.id,
    @required this.symbol,
    @required this.title,
    @required this.imageUrl,
  });

  factory
  Catogory.fromJson(Map<String, dynamic> parsedJson) {
    return Catogory(
      id: parsedJson['id'],
      symbol: parsedJson['symbol'],
      title: parsedJson['title'],
      imageUrl: parsedJson['imageUrl']
    );
  }

}