import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/entry.dart';
import 'folders.dart';

part 'entries.g.dart';

@Riverpod(keepAlive: true)
Future<List<Entry>> entries(EntriesRef ref) async {
  // Wait for the folders to be loaded
  final topLevel = await ref.watch(foldersProvider.future);

  var recurse = () {
    for (final folder in topLevel) {
      print(folder);
    }
  };

  // Now load the entries from disk as a list of Entry objects
  for (final folder in topLevel) {
    print(folder);
  }

  return [];
}
