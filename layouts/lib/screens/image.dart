import 'package:flutter/material.dart';
import 'package:layouts/widgets/comms.dart';
import 'package:layouts/widgets/swipe_detector.dart';

import '../const.dart';

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
        child: Center(
            child: Image.asset(
          Const.imagePlaceholder,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        )),
        onSwipeUp: () => showSnackBar(context, 'Show image details!'),
        onSwipeDown: () => Navigator.pop(context),
        onSwipeLeft: () => showSnackBar(context, 'Load next image!'),
        onSwipeRight: () => showSnackBar(context, 'Load previous image!'),
      ),
    );
  }
}
