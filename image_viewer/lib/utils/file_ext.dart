import 'dart:io';
import 'package:path/path.dart' as path;

extension FileExtention on FileSystemEntity {
  String get name {
    return path.basename(this.path);
  }
}
