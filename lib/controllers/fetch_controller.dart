import 'package:flutter/material.dart';
import '../models/giphy_model.dart';

class FetchController {
  final TextEditingController fetchController = TextEditingController();
  final GiphyModel giphyModel = GiphyModel();

  Future<Map> fetchData() {
    return giphyModel.getResponse(
      fetchController.text.isNotEmpty ? fetchController.text : null,
    );
  }

  void dispose() {
    fetchController.dispose();
  }
}