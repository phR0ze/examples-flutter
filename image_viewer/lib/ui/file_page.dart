import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../const.dart';
import '../model/exports.dart' as model;

class FilePage extends ConsumerWidget {
  final model.FileEntry file;
  const FilePage(this.file, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('File: ${file.name}', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
        child: FullScreenImage(file),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final model.FileEntry entry;
  const FullScreenImage(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    final img = Image.file(File(entry.path));

    if (entry.isImage) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: img.image,
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Const.assetImagePlaceholder),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
