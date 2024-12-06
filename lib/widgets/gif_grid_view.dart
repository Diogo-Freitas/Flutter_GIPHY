import 'package:transparent_image/transparent_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:giphy/pages/gif_page.dart';
import 'package:flutter/material.dart';

class GifGridView extends StatelessWidget {
  const GifGridView(
      {super.key, required this.snapshot, required this.loadMoreGifs});

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GifPage(gifData: snapshot.data['data'][index]),
                ),
              );
            },
            onLongPress: () {
              Share.share(
                snapshot.data['data'][index]['images']['fixed_height']['url'],
              );
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data['data'][index]['images']['fixed_height']
                  ['url'],
              height: 300,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return GestureDetector(
            onTap: loadMoreGifs,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 70),
                Text("Carregar mais...",
                    style: TextStyle(color: Colors.white, fontSize: 18))
              ],
            ),
          );
        }
      },
    );
  }
}