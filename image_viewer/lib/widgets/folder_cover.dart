import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';
import 'package:path/path.dart' as path;

/// `FolderCover` represents the cover of a folder.
/// It is designed to be used in a list view where each item is a folder.  The folder cover
/// displays the folder name, the number of images in the folder and the folder cover image.
class FolderCover extends StatelessWidget {
  final String folderPath;
  final String folderImagePath;
  final int? folderImageCount;

  // Construct a new FolderCover widget
  const FolderCover(
      {super.key,
      required this.folderPath,
      required this.folderImagePath,
      required this.folderImageCount});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: const Color.fromARGB(120, 0, 0, 0),
        title: Text(
          path.basename(folderPath),
          style: const TextStyle(color: Colors.white),
          maxLines: 1,
        ),
        subtitle: Text(
          '$folderImageCount images',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      child: Image.file(
        File(folderImagePath),
        cacheHeight: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(Const.imagePlaceholder),
      ),
    );
  }
}
