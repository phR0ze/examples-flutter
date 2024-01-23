import 'package:animations/animate_fade.dart';
import 'package:animations/animate_grow_and_shrink.dart';
import 'package:flutter/material.dart';
import 'animate_fade_and_grow.dart';
import 'animate_grow.dart';
import 'page_button.dart';

const assetImageFree = 'assets/images/pixabay-free.jpg';

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
              title: 'Grow container',
              child: AnimateGrow(),
            ),
            PageButton(
              title: 'Grow and shrink container',
              child: AnimateGrowAndShrink(),
            ),
            PageButton(
              title: 'Fade in',
              child: AnimateFade(),
            ),
            PageButton(
              title: 'Fade and grow',
              child: AnimateFadeAndGrow(),
            ),
          ],
        ),
      ),
    );
  }
}
