import 'package:flutter/material.dart';

class GifGridView extends StatelessWidget {
  const GifGridView({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: snapshot.data['data'].length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Image.network(
                snapshot.data['data'][index]['images']['fixed_height']['url']),
          );
        });
  }
}