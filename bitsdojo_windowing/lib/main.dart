import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Row(
        children: [
          LeftSide(),
          RightSide(),
        ],
      )),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: Colors.yellow,
      ),
    );
  }
}

var backgroundStartColor = const Color(0xFFFFD500);
var backgroundEndColor = const Color(0xFFF6A00C);

class RightSide extends StatelessWidget {
  const RightSide({super.key}) /*  */;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [backgroundStartColor, backgroundEndColor],
          stops: const [0.0, 1.0],
        ),
      )),
    );
  }
}
