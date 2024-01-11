import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/top_folders.dart';

List<IconButton> getTopFolderAction(WidgetRef ref) {
  return [
    /// Trigger the folder picker to select a top level folder
    IconButton(
      onPressed: () {
        ref.read(topFoldersProvider.notifier).addFolder();
      },
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
        child: Transform.scale(
          scale: 1.3,
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    ),
  ];
}
