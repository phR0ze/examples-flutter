import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/exports.dart' as model;
import 'exports.dart';

part 'entries.g.dart';

@Riverpod(keepAlive: true)
Future<List<model.Entry>> entries(EntriesRef ref) async {
  var entries = <model.Entry>[];

  // Wait for the folders to be loaded
  final topLevel = await ref.watch(foldersProvider.future);

  // Now load the entries from disk as a list of Entry objects
  recurseOnFolderStructure(folder) {
    var entry = model.Folder(folder);
    entries.add(entry);
  }

  for (final folder in topLevel) {
    recurseOnFolderStructure(folder);
  }

  return entries;
}
