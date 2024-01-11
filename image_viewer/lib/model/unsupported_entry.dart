import 'file_entry.dart';

class UnsupportedEntry extends FileEntry {
  UnsupportedEntry(String path) : super(path);

  @override
  String toString() {
    return 'UnsupportedEntry(path: $path)';
  }
}
