import 'package:path/path.dart';
import 'file.dart';
import 'folder.dart';

abstract class Entry {
  const Entry(this.path);

  /// The path to the file or folder
  final String path;

  /// Returns the name of the file or folder
  String get name => basename(path);

  /// Returns true as this is a folder
  bool get isFolder => false;

  /// Get the total number of entries in this folder and all sub folders
  int get count {
    if (this is File) {
      return 1;
    } else {
      return (this as Folder).count;
    }
  }

  @override
  String toString() {
    if (this is File) {
      return (this as File).toString();
    } else {
      return (this as Folder).toString();
    }
  }
}
