import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image view'),
        backgroundColor: Colors.grey,
      ),
      body: GestureDetector(
          // Vertical swiping closes the page
          onVerticalDragUpdate: (details) {
            int sensitivity = 10;
            if (details.delta.dy > sensitivity || details.delta.dy < -sensitivity) {
              Navigator.of(context).pop();
            }
          },
          // Horizontal swiping loads the next image
          child: Center(child: Image.asset('assets/images/placeholder.png'))),
    );
  }
}
