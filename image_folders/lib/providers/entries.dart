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
  recurseOnFolderStructure(String folder, List<model.Entry> entries) {
    var entry = model.Folder(folder);
    entries.add(entry);
  }

  for (final topFolder in topFolders) {
    recurseOnFolderStructure(topFolder, entries);
  }

  log.info('Entries: $entries');
  return entries;
}
