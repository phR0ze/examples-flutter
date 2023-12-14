import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Immutable provider state
final titleProvider = Provider((ref) => 'Riverpod counter example');

// Updatable provider state
final counterProvider = StateProvider((ref) => 0);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final title = ref.watch(titleProvider);
    final count = ref.watch(counterProvider);

    return Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Counter value
              Text(
                count.toString(),
                style: const TextStyle(color: Colors.white, height: 5, fontSize: 23),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add'),
                      onPressed: () => ref.watch(counterProvider.notifier).state++,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.remove),
                      label: const Text('Minus'),
                      onPressed: () => ref.watch(counterProvider.notifier).state--,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.replay),
                label: const Text('Refresh'),
                onPressed: () => ref.watch(counterProvider.notifier).state = 0,
              ),
            ],
          ),
        ));
  }
}
