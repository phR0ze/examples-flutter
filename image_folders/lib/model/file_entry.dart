import 'entry.dart';

class FileEntry extends Entry {
  FileEntry(String path) : super(path);

  @override
  String toString() {
    return 'FileEntry(path: $path)';
  }
}
