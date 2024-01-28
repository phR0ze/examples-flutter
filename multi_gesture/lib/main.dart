import 'package:flutter/material.dart';
import 'const.dart';
import 'multi_gesture.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fling = 'none';

  @override
  Widget build(BuildContext context) {
    return MultiGesture(
      onFling: (fling) {
        setState(() {
          _fling = fling.toString();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Gesture research'),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Image.asset(Const.assetFreeImage),
            ),
            Positioned(
              top: 20,
              left: 20,
              child:
                  Text(_fling, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
