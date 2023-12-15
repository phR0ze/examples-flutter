import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Immutable provider state
final titleProvider = Provider((ref) => 'Riverpod counter example');

// Couter provider state
class Counter extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void reset() {
    state = 0;
  }

  void dec() {
    state--;
  }

  void inc() {
    state++;
  }
}

final counterProvider = NotifierProvider<Counter, int>(Counter.new);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Counter value
              Text(
                // Need to use watch here to rebuild the widget when the counter changes
                ref.watch(counterProvider).toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add'),
                      // Using read here is find because we don't need to rebuild the widget
                      onPressed: () => ref.read(counterProvider.notifier).inc(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.remove),
                      label: const Text('Minus'),
                      // Using read here is find because we don't need to rebuild the widget
                      onPressed: () => ref.read(counterProvider.notifier).dec(),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.replay),
                label: const Text('Reset'),
                // Using read here is find because we don't need to rebuild the widget
                onPressed: () => ref.read(counterProvider.notifier).reset(),
              ),
            ],
          ),
        ));
  }
}
