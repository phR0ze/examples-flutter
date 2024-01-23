import 'package:flutter/material.dart';

class AnimateFadeAndGrow extends StatefulWidget {
  const AnimateFadeAndGrow({super.key});

  @override
  State<AnimateFadeAndGrow> createState() => _AnimateFadeAndGrowState();
}

class _AnimateFadeAndGrowState extends State<AnimateFadeAndGrow> with TickerProviderStateMixin {
  late Animation<double> fade;
  late Animation<double> grow;
  late AnimationController fadeController;
  late AnimationController growController;

  @override
  void initState() {
    super.initState();
    growController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    fadeController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    grow = Tween<double>(begin: 0, end: 400).animate(growController)
      ..addListener(() => setState(() {}));
    fade = Tween<double>(begin: 0.1, end: 1).animate(fadeController)
      ..addListener(() => setState(() {}));
    fadeController.forward();
    growController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: fade.value,
        child: Container(
          color: Colors.blue,
          height: grow.value,
          width: grow.value,
        ),
      ),
    );
  }

  // Controllers need to be disposed of to prevent memory leaks
  @override
  void dispose() {
    growController.dispose();
    fadeController.dispose();
    super.dispose();
  }
}
