import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../const.dart';
import '../model/exports.dart' as model;

class FilePage extends ConsumerWidget {
  final model.FileEntry entry;
  const FilePage(this.entry, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('File: ${entry.name}', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
        child: ImageContent(entry),
      ),
    );
  }
}

class ImageContent extends StatelessWidget {
  final model.FileEntry entry;
  const ImageContent(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (entry) {
      case final model.ImageEntry _:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(entry.path)),
              fit: BoxFit.contain,
            ),
          ),
        );
      default:
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
