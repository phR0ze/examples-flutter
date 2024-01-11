import 'dart:io';
import 'package:flutter/material.dart';
import '../model/exports.dart' as model;

class FilePage extends StatelessWidget {
  final model.FileEntry entry;
  const FilePage(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(entry.name, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.file(File(entry.path)).image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
