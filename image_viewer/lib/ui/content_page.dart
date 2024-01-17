import 'dart:io';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import 'common/text_image.dart';
import '../model/exports.dart' as model;

class ContentProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final model.FolderEntry folder;

  ContentProvider(this.folder, index) : initialIndex = index;

  @override
  int get imageCount => folder.length;

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    final size = MediaQuery.of(context).size;

    switch (folder.entries[index]) {
      case model.ImageEntry entry:
        // Don't want to sample down here as then we can't zoom in with good quality
        return Image.file(File(entry.path)).image;
      case model.TextEntry entry:
        return TextImage(entry.path, size);
      default:
        return Image.asset(Const.assetImagePlaceholder).image;
    }
  }
}
