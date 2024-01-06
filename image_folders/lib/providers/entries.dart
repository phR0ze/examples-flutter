import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/exports.dart' as model;
import 'exports.dart';

part 'entries.g.dart';

@Riverpod(keepAlive: true)
class Entries extends _$Entries {
  @override
  Future<List<model.Entry>> build() async {
    final entries = <model.Entry>[];

    // Wait for the folders to be loaded
    final topFolders = await ref.watch(topFoldersProvider.future);

    // Now load the entries from disk as a list of Entry objects
    recurseOnFolder(model.Folder folder) async {
      // TODO: stream files
      for (final x in await Directory(folder.path).list().toList()) {
        if (x is File) {
          folder.addFile(x);
        } else if (x is Directory) {
          var subFolder = model.Folder(x.path);
          await recurseOnFolder(subFolder);
          folder.add(subFolder);
        }
      }
    }

    for (final topFolder in topFolders) {
      final folder = model.Folder(topFolder);
      await recurseOnFolder(folder);
      entries.add(folder);

      // Incrementally notifies the UI of the new folder
      state = AsyncData(entries);
    }

    return entries;
  }
}
