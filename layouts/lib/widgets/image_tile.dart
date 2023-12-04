// Build image widget
import 'package:flutter/material.dart';

GridTile buildImage(String image) {
  return GridTile(child: Image.asset(image, fit: BoxFit.cover, cacheWidth: 100));
}

// Simulate loading images
Future<List<String>> loadImages() async {
  return List.generate(2000, (index) => 'assets/images/placeholder.png');
}
