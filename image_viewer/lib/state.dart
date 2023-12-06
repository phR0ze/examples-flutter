import 'package:flutter/material.dart';
import 'const.dart';

class AppState extends ChangeNotifier {
  List<String>? _images;

  // Track folder vs all image view
  bool _folderView = false;
  bool get folderView => _folderView;
  void toggleFolderView() {
    if (_folderView) {
      _folderView = false;
    } else {
      _folderView = true;
    }
    notifyListeners();
  }

  // Route tracking for responsive navigation sharing
  int _currentRoute = 0;
  int get currentRoute => _currentRoute;
  set currentRoute(int value) {
    if (value != _currentRoute) {
      _currentRoute = value;
      notifyListeners();
    }
  }

  // Thumbnail size
  double _imageSize = Const.imageSizeDefault;
  double get imageSize => _imageSize;

  void zoomInImage() {
    _imageSize += 100.0;
    notifyListeners();
  }

  void zoomOutImage() {
    _imageSize -= 100.0;
    if (_imageSize < 100.0) {
      _imageSize = 100.0;
    }
    notifyListeners();
  }

  // Load images from disk in an async fashion so as to not block the UI
  Future<List<String>> loadImages() async {
    _images ??= List.generate(2000, (index) => Const.assetImagePlaceholder);
    return _images!;
  }
}
