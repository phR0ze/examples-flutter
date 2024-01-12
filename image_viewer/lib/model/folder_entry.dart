import 'dart:io';
import 'package:collection/collection.dart';
import 'package:quiver/core.dart';
import 'exports.dart';

class FolderEntry extends Entry {
  List<Entry> entries = [];

  FolderEntry(super.path);

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

  /// Get the entry at the specified index
  Entry operator [](int index) => entries[index];

  /// Get the first image file from this folder
  ImageEntry? get firstImage {
    // First try all the files in the folder then fall back on recursion
    final image = entries.firstWhereOrNull((x) => x.isImage);
    if (image != null) {
      return image as ImageEntry;
    }

    // Fall back on recursing any sub folders
    for (final entry in entries.where((x) => x.isFolder)) {
      final image = (entry as FolderEntry).firstImage;
      if (image != null) {
        return image;
      }
    }
    return null;
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
