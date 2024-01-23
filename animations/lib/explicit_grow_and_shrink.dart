import 'package:flutter/material.dart';

class ExplicitGrowAndShrink extends StatefulWidget {
  const ExplicitGrowAndShrink({super.key});

  @override
  State<ExplicitGrowAndShrink> createState() => _ExplicitGrowAndShrinkState();
}

class _ExplicitGrowAndShrinkState extends State<ExplicitGrowAndShrink>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    // The controller and animation work together with the animation just tracking
    // the particular value at a point in time which the controller generates based on
    // the type of animation and duration.
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 400).animate(controller)

      // The listener is called each time the animation value changes and we
      // use that to trigger a rebuild by calling setState to draw the image from sizes
      // between 0 and 400.
      ..addListener(() => setState(() {}))

      // Add a status listener to reverse the animation when it completes
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    // Start the animation running forward
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue,
        height: animation.value,
        width: animation.value,
      ),
    );
  }

  // Controllers need to be disposed of to prevent memory leaks
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
