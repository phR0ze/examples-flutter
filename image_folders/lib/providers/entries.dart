import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/exports.dart' as model;
import '../utils/logger.dart';
import 'exports.dart';

part 'entries.g.dart';

@Riverpod(keepAlive: true)
Future<List<model.Entry>> entries(EntriesRef ref) async {
  var entries = <model.Entry>[];

  // Wait for the folders to be loaded
  final topFolders = await ref.watch(topFoldersProvider.future);

  // Now load the entries from disk as a list of Entry objects
  recurseOnFolder(model.Folder folder) async {
    // TODO: stream files
    for (final x in await Directory(folder.path).list().toList()) {
      if (x is File) {
        log.info('Adding file: ${x.path}');
        folder.addFile(x);
        log.info('after: $folder');
      } else if (x is Directory) {
        log.info('Adding folder: ${x.path}');
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
  }

  log.info('Entries: $entries');
  return entries;
}
