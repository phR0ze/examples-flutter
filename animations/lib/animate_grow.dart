import 'package:flutter/material.dart';

class AnimateGrow extends StatefulWidget {
  const AnimateGrow({super.key});

  @override
  State<AnimateGrow> createState() => _AnimateGrowState();
}

class _AnimateGrowState extends State<AnimateGrow> with SingleTickerProviderStateMixin {
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
      ..addListener(() => setState(() {}));

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

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(vertical: 10),
  //       height: animation.value,
  //       width: animation.value,
  //       child: const FlutterLogo(),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     clipBehavior: Clip.hardEdge,
  //     width: animation.value,
  //     height: animation.value,
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(
  //           image: AssetImage('assets/images/pixabay-free.jpg'), fit: BoxFit.contain),
  //     ),
  //   );
  // }

  // Controllers need to be disposed of to prevent memory leaks
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
