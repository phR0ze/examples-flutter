import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/exports.dart' as model;

class FilePage extends ConsumerWidget {
  final model.File file;
  const FilePage(this.file, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('File: ${file.name}', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(child: Text('File: ${file.name}')),
    );
  }
}
