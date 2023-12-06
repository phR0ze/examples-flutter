import 'package:flutter/material.dart';
import 'package:layouts/comms.dart';
import 'package:layouts/swipe_detector.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image view'),
        backgroundColor: Colors.grey,
      ),
      body: SwipeDetector(
        child: Center(child: Image.asset('assets/images/placeholder.png')),
        onSwipeUp: () => showSnackBar(context, 'Show image details!'),
        onSwipeDown: () => showSnackBar(context, 'Dismiss image view!'),
        onSwipeLeft: () => showSnackBar(context, 'Load next image!'),
        onSwipeRight: () => showSnackBar(context, 'Load previous image!'),
      ),
    );
  }
}
