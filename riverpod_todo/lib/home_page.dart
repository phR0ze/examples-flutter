import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final state = StateProvider((ref) => 7);

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          final count = ref.watch(state).toString();
          return Text(count, style: Theme.of(context).textTheme.headlineLarge);
        }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
