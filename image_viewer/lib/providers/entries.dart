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
    recurseOnFolder(model.FolderEntry folder) async {
      for (final x in await Directory(folder.path).list().toList()) {
        if (x is File) {
          folder.addFile(x);
        } else if (x is Directory) {
          var subFolder = model.FolderEntry(x.path);
          await recurseOnFolder(subFolder);
          folder.add(subFolder);
        }
      }
    }

    // Loop over top folders and add any new ones to the state to be processed
    for (final topFolder in topFolders) {
      state = const AsyncLoading();

      // Skip folders that already exist
      if (state.value != null) {
        final entry =
            state.value!.firstWhere((x) => x.path == topFolder, orElse: () => model.NoneEntry());
        if (!entry.isNone) {
          entries.add(entry);

          // Incrementally notifies the UI of the new folder
          state = AsyncData(entries);
          continue;
        }
      }

      // Load the new folder and incrementally notify out
      final folder = model.FolderEntry(topFolder);
      await recurseOnFolder(folder);
      entries.add(folder);
      state = AsyncData(entries);
    }

    return entries;
  }
}
