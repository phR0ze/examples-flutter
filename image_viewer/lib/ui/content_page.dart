import 'dart:io';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
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
    if (folder.entries[index] is model.TextEntry) {
      return TextImage(folder.entries[index].path, MediaQuery.of(context).size);
    }
    return FileImage(File(folder.entries[index].path));
  }
}
