import 'package:flutter/material.dart';
import 'const.dart';

class AppState extends ChangeNotifier {
  List<String>? _images;

  // Load images from disk
  Future<List<String>> loadImages() async {
    _images ??= List.generate(2000, (index) => Const.imagePlaceholder);
    return _images!;
  }
}
