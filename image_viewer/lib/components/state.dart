import 'package:flutter/material.dart';
import '../const.dart';

class AppState extends ChangeNotifier {
  double _imageSize = Const.imageSizeDefault;
  double get imageSize => _imageSize;

  // Increase the size of all the image thumbnails
  void zoomInImage() {
    _imageSize += 100.0;
    notifyListeners();
  }

  // Decreate the size of all the image thumbnails
  void zoomOutImage() {
    _imageSize -= 100.0;
    if (_imageSize < 100.0) {
      _imageSize = 100.0;
    }
    notifyListeners();
  }
}
