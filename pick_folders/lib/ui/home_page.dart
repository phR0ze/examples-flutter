import 'package:flutter/material.dart';
import 'utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter file_pick example'),
      ),
      body: const Center(
          // content
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logException('test'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
