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

  /// Get the number of entries in the root of this folder
  int get length => entries.length;

  /// Get the total number of entries in this folder and all sub folders
  @override
  int get count {
    var count = 0;
    for (final entry in entries) {
      if (entry.isFolder) {
        count += (entry as Folder).count;
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
