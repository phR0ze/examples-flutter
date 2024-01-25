import 'package:flutter/material.dart';

class ImplicitSlide extends StatefulWidget {
  const ImplicitSlide({super.key});

  @override
  State<ImplicitSlide> createState() => _ImplicitSlideState();
}

class _ImplicitSlideState extends State<ImplicitSlide> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 1.0),
  ).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: const FlutterLogo(size: 150.0),
    );
  }
}
