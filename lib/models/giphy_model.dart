import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GiphyModel {
  final String apiKey = dotenv.get('API_KEY');

  Future<Map> getResponse([String? search, int offset = 0]) async {
    late Uri uri;

    if (search == null) {
      uri = Uri.https(
        'api.giphy.com',
        '/v1/gifs/trending',
        {
          'api_key': apiKey,
          'limit': '19',
          'offset': '$offset',
          'rating': 'g',
          'bundle': 'messaging_non_clips',
        },
      );
    } else {
      uri = Uri.https(
        'api.giphy.com',
        '/v1/gifs/search',
        {
          'api_key': apiKey,
          'limit': '19',
          'offset': '$offset',
          'rating': 'g',
          'bundle': 'messaging_non_clips',
          'q': search,
        },
      );
    }

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}