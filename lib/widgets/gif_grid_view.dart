import 'package:flutter/material.dart';

class GifGridView extends StatelessWidget {
  const GifGridView({super.key, required this.snapshot, required this.loadMoreGifs});

  final AsyncSnapshot snapshot;
  final VoidCallback loadMoreGifs;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: snapshot.data['data'].length + 1,
        itemBuilder: (context, index) {
          if (index < snapshot.data['data'].length) {
            return GestureDetector(
              child: Image.network(snapshot.data['data'][index]['images']
                  ['fixed_height']['url']),
            );
          } else {
            return GestureDetector(
              onTap: loadMoreGifs,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 70),
                  Text("Carregar mais...", style: TextStyle(color: Colors.white, fontSize: 18))
                ],
              ),
            );
          }
        });
  }
}