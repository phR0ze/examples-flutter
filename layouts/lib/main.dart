import 'package:flutter/material.dart';
import 'screens/narrow/home.dart' as narrow;
import 'screens/wide/home.dart' as wide;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "layout examples",
      home: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return constraints.maxWidth > 450
              ? wide.HomeScreen(constraints)
              : narrow.HomeScreen(constraints);
        }),
      ),
    );
  }
}
