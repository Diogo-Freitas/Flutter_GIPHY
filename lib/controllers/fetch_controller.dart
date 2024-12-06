import 'package:flutter/material.dart';
import '../models/giphy_model.dart';

class FetchController {
  final TextEditingController fetchController = TextEditingController();
  final GiphyModel giphyModel = GiphyModel();

  Future<Map> fetchData(int offset) {
    return giphyModel.getResponse(
      fetchController.text.isNotEmpty ? fetchController.text : null,
      offset,
    );
  }

  void dispose() {
    fetchController.dispose();
  }
}