import 'package:flutter/material.dart';

class ExplicitFadeAndGrow extends StatefulWidget {
  const ExplicitFadeAndGrow({super.key});

  @override
  State<ExplicitFadeAndGrow> createState() => _ExplicitFadeAndGrowState();
}

class _ExplicitFadeAndGrowState extends State<ExplicitFadeAndGrow> with TickerProviderStateMixin {
  late Animation<double> fade;
  late Animation<double> grow;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    // Its perfectly fine to have a single controller for multiple animations
    grow = Tween<double>(begin: 0, end: 400).animate(controller)
      ..addListener(() => setState(() {}));
    fade = Tween<double>(begin: 0.1, end: 1).animate(controller)
      ..addListener(() => setState(() {}));
    controller.forward();
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
    controller.dispose();
    super.dispose();
  }
}
