import 'dart:io';
import 'package:flutter/material.dart';
import '../model/exports.dart' as model;

class ImageView extends StatelessWidget {
  final model.ImageEntry entry;
  const ImageView(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.file(File(entry.path)).image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
