import 'dart:io';
import 'package:quiver/core.dart';
import 'exports.dart';

class FolderEntry extends Entry {
  List<Entry> entries = [];

  FolderEntry(String path) : super(path);

  /// Returns true as this is a folder
  @override
  bool get isFolder => true;

  /// Add a file to this folder
  void addFile(FileSystemEntity file) {
    entries.add(FileEntry.fromPath(file.path));
  }

  /// Add an entry to this folder
  void add(Entry entry) {
    entries.add(entry);
  }

  /// Add folder to this folder
  void addFolder(FileSystemEntity folder) {
    entries.add(FolderEntry(folder.path));
  }

  /// Get the number of entries in the root of this folder
  int get length => entries.length;

  /// Get the total number of entries in this folder and all sub folders
  @override
  int get count {
    var count = 0;
    for (final entry in entries) {
      if (entry.isFolder) {
        count += (entry as FolderEntry).count;
      } else {
        count++;
      }
    }
    return count;
  }

  @override
  bool operator ==(Object other) {
    return other is FolderEntry && path == other.path && count == other.count;
  }

  /// Returns a hash code value for the object.
  /// Uses the google hash2 function on the path and the type name
  @override
  int get hashCode => hash2(path, 'FolderEntry');

  @override
  String toString() {
    return 'FolderEntry(path: $path, entries: $entries)';
  }
}
