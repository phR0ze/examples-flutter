import 'package:flutter/material.dart';
import '../const.dart';
import '../screens/image.dart';

// Image tile widget
class ImageTile extends StatelessWidget {
  final String id;
  final int index;
  final String image;
  final List<String> images;

  const ImageTile(
    this.id,
    this.index,
    this.image,
    this.images, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(id),
        ),
        child: GestureDetector(
            child: Image.asset(image, fit: BoxFit.cover, cacheWidth: Const.imageCacheQuality),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImageScreen(id, index, image, images)));
            }));
  }
}
