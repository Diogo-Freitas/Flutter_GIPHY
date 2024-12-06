import 'package:http/http.dart' as http;
import 'dart:convert';

class GiphyModel {
  final String apiKey = 'qHxJdD1Hrcw4MToDx5g9ThuIJpaJJbSq';

  Future<Map> getResponse([String? search]) async {
    late Uri uri;

    if (search == null) {
      uri = Uri.https(
        'api.giphy.com',
        '/v1/gifs/trending',
        {
          'api_key': apiKey,
          'limit': '20',
          'offset': '0',
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
          'limit': '20',
          'offset': '0',
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