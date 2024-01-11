import 'package:path/path.dart';
import 'exports.dart';

abstract class Entry {
  const Entry(this.path);

  /// The path to the file or folder
  final String path;

  /// Returns the ext of the file
  String get ext => extension(path);

  /// Returns the name of the file or folder
  String get name => basename(path);

  /// Returns true if this is None
  bool get isNone => this is NoneEntry;

  /// Returns true if this is an image
  bool get isImage => this is ImageEntry;

  /// Returns true if this is a folder
  bool get isFolder => this is FolderEntry;

  /// Returns true as this is a supported type
  bool get isSupported => !(this is NoneEntry || this is UnsupportedEntry);

  /// Get the total number of entries in this folder and all sub folders
  int get count {
    if (this is FileEntry) {
      return 1;
    } else {
      return (this as FolderEntry).count;
    }
  }
}
