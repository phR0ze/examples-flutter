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
        onSwipeUp: () => showSnackBar(context, 'You swiped up!'),
        onSwipeDown: () => showSnackBar(context, 'You swiped down!'),
        onSwipeLeft: () => showSnackBar(context, 'You swiped left!'),
        onSwipeRight: () => showSnackBar(context, 'You swiped right!'),
      ),
    );
  }
}
