import 'package:quiver/core.dart';
import 'entry.dart';

class FileEntry extends Entry {
  FileEntry(String path) : super(path);

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
