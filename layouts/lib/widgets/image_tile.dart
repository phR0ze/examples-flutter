// Build image widget
import 'package:flutter/material.dart';

import '../screens/image.dart';

// Simulate loading images
Future<List<String>> loadImages() async {
  return List.generate(2000, (index) => 'assets/images/placeholder.png');
}

// Image tile widget
class ImageTile extends StatelessWidget {
  final String _image;

  const ImageTile(
    String image, {
    super.key,
  }) : _image = image;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GestureDetector(
            child: Image.asset(_image, fit: BoxFit.cover, cacheWidth: 100),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageScreen()));
            }));
  }
}
