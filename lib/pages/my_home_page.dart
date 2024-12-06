import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/gif_grid_view.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<Map>(
                future: getResponse(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 5,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return GifGridView(snapshot: snapshot);
                  } else {
                    return const Center(
                      child: Text(
                        'Nenhum GIF disponível!',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
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