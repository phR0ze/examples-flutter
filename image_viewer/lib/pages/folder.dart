import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';
import 'package:image_viewer/utils/file.dart';

class FolderPage extends StatelessWidget {
  final String folder;
  final List<String> entities;
  final List<Directory> folders;
  final List<File> images;

  FolderPage({super.key, required this.folder, required this.entities})
      : images = entities.whereType<File>().toList(),
        folders = entities.whereType<Directory>().toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        // Folder app bar with title and actions
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          title: Text(
            '${folder} (${entities.length})',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {},
            ),
          ],
        ),
        // Display the folder's images filtering out sub-folders for now
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150, mainAxisSpacing: 2.0, crossAxisSpacing: 2.0),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Hero(
                tag: images[index].path,
                child: Image.file(File(images[index].path), cacheHeight: 200, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return Image.asset(Const.assetImagePlaceholder);
                }),
              );
            },
            childCount: images.length,
          ),
        ),
      ],
    ));
  }
}
