import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getResponse('dogs').then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title:
              Text(widget.title, style: const TextStyle(color: Colors.white)),
        ),
        body: const Center());
  }
}

Future<Map> getResponse([String? search]) async {
  late Uri uri;

  if (search == null) {
    uri = Uri.https(
      'api.giphy.com',
      '/v1/gifs/trending',
      {
        'api_key': 'qHxJdD1Hrcw4MToDx5g9ThuIJpaJJbSq',
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
        'api_key': 'qHxJdD1Hrcw4MToDx5g9ThuIJpaJJbSq',
        'limit': '20',
        'offset': '0',
        'rating': 'g',
        'bundle': 'messaging_non_clips',
        'q': search,
      },
    );
  }

  var response = await http.get(uri);

  return json.decode(response.body);
}