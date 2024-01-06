import 'dart:io';
import 'entry.dart';
import 'file.dart';

class Folder extends Entry {
  List<Entry> entries = [];

  Folder(String path) : super(path);

  /// Returns true as this is a folder
  @override
  bool get isFolder => true;

  /// Add a file to this folder
  void addFile(FileSystemEntity file) {
    entries.add(File(file.path));
  }

  /// Add an entry to this folder
  void add(Entry entry) {
    entries.add(entry);
  }

  /// Add folder to this folder
  void addFolder(FileSystemEntity folder) {
    entries.add(Folder(folder.path));
  }

  /// Get recursive total entry count for this folder
  int get totalEntries {
    var count = 0;
    for (final entry in entries) {
      if (entry.isFolder) {
        count += (entry as Folder).totalEntries;
      } else {
        count++;
      }
    }
    return count;
  }

  @override
  String toString() {
    return 'Folder(path: $path, entries: $entries)';
  }
}
