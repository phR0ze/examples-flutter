// Build image widget
import 'package:flutter/material.dart';

import '../screens/image.dart';

// Image tile widget
class ImageTile extends StatelessWidget {
  final String image;

  const ImageTile(
    this.image, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GestureDetector(
            child: Image.asset(image, fit: BoxFit.cover, cacheWidth: 100),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageScreen()));
            }));
  }
}
