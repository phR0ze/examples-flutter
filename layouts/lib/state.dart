import 'package:flutter/material.dart';
import 'const.dart';

class AppState extends ChangeNotifier {
  List<String>? _images;

  // Route tracking for responsive navigation sharing
  int _currentRoute = 0;
  int get currentRoute => _currentRoute;
  set currentRoute(int value) {
    if (value != _currentRoute) {
      _currentRoute = value;
      notifyListeners();
    }
  }

  // Load images from disk in an async fashion so as to not block the UI
  Future<List<String>> loadImages() async {
    _images ??= List.generate(2000, (index) => Const.imagePlaceholder);
    return _images!;
  }
}
