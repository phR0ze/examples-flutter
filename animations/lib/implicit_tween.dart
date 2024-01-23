import 'package:flutter/material.dart';

import 'const.dart';

class ImplicitTween extends StatefulWidget {
  const ImplicitTween({super.key});

  @override
  State<ImplicitTween> createState() => _ImplicitTweenState();
}

class _ImplicitTweenState extends State<ImplicitTween> with SingleTickerProviderStateMixin {
  Color begin = Colors.white;
  Color end = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(begin: begin, end: end),
          duration: const Duration(seconds: 2),

          // Function the tween animation builder runs repeatedly to show a smooth animation
          builder: (_, color, widget) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
              child: widget,
            );
          },

          // Since the image never changes we can pass it in as a child so its not rebuilt
          // every time the animation fires.
          child: Image.asset(Const.assetFreeImage),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final Color temp = begin;
            begin = end;
            end = temp;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
