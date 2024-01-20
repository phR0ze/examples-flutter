import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mirage/mirage.dart' as mirage;
import '../const.dart';
import 'common/text_image.dart';
import '../model/exports.dart' as model;

class ContentProvider extends mirage.ImageProviders {
  final model.FolderEntry folder;
  ContentProvider(this.folder, this.index);

  @override
  final int index;

  @override
  int get length => folder.length;

  @override
  ImageProvider<Object> get(BuildContext context, int index) {
    switch (folder.entries[index]) {
      case model.ImageEntry entry:
        // Don't want to sample down here as then we can't zoom in with good quality
        return Image.file(File(entry.path)).image;
      case model.TextEntry entry:
        final size = MediaQuery.of(context).size;
        return TextImage(entry.path, size);
      default:
        return Image.asset(Const.assetImagePlaceholder).image;
    }
  }
}
