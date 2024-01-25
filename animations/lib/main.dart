import 'package:flutter/material.dart';
import 'explicit_grow_and_shrink.dart';
import 'explicit_fade_and_grow.dart';
import 'explicit_slide.dart';
import 'implicit_hero.dart';
import 'implicit_slide.dart';
import 'implicit_tween.dart';
import 'implicit_container.dart';
import 'pull_down_page.dart';
import 'page_button.dart';
import 'pull_down.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Animation examples'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PageButton(
              title: 'Implicit - Slide',
              child: ImplicitSlide(),
            ),
            PageButton(
              title: 'Implicit - Hero',
              child: ImplicitHero(),
            ),
            PageButton(
              title: 'Implicit Tween',
              child: ImplicitTween(),
            ),
            PageButton(
              title: 'Implicit - AnimatedContainer',
              child: ImplicitContainer(),
            ),
            PageButton(
              title: 'Explicit - Slide ',
              child: ExplicitSlide(),
            ),
            PageButton(
              dialog: true,
              title: 'Explicit - Pull Down 3/4',
              child: PullDown(child: PullDownPage()),
            ),
            PageButton(
              title: 'Explicit - Grow and shrink container',
              child: ExplicitGrowAndShrink(),
            ),
            PageButton(
              title: 'Explicit - Fade and grow',
              child: ExplicitFadeAndGrow(),
            ),
          ],
        ),
      ),
    );
  }
}
