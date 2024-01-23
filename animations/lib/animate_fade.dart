import 'package:flutter/material.dart';

class AnimateFade extends StatefulWidget {
  const AnimateFade({super.key});

  @override
  State<AnimateFade> createState() => _AnimateFadeState();
}

class _AnimateFadeState extends State<AnimateFade> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0.1, end: 1).animate(controller)
      ..addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: animation.value,
        child: Container(
          color: Colors.blue,
          height: 400,
          width: 400,
        ),
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
