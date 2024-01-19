import 'package:flutter/material.dart';
import 'package:mirage/mirage.dart' as mirage;
import 'const.dart';

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
        title: const Text(Const.appName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mirage.showImage(
            context,
            const AssetImage(Const.assetFreeImage),
          );
        },
        tooltip: 'Launch ImageView',
        child: const Icon(Icons.launch),
      ),
    );
  }
}
