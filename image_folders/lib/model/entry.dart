import 'package:path/path.dart';

abstract class Entry {
  const Entry(this.path);

  /// The path to the file or folder
  final String path;

  /// Returns the name of the file or folder
  String get name => basename(path);

  /// Returns true as this is a folder
  bool get isFolder => false;
}
