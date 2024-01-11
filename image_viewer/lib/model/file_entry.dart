import 'package:quiver/core.dart';
import 'package:path/path.dart' as p;
import '../../const.dart';
import 'exports.dart';

abstract class FileEntry extends Entry {
  FileEntry(super.path);

  /// Create a subtype of FileEntry based on the file extension
  factory FileEntry.fromPath(String path) {
    final ext = p.extension(path);
    if (Const.imageExt.contains(ext.toLowerCase())) {
      return ImageEntry(path);
    } else if (Const.textExt.contains(ext.toLowerCase())) {
      return TextEntry(path);
    } else {
      return UnsupportedEntry(path);
    }
  }

  @override
  bool operator ==(Object other) {
    return other is FileEntry && path == other.path;
  }

  /// Returns a hash code value for the object.
  /// Uses the google hash2 function on the path and the type name
  @override
  int get hashCode => hash2(path, 'FileEntry');

  @override
  String toString() {
    return 'FileEntry(path: $path)';
  }
}
