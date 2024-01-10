import 'file_entry.dart';

class TextEntry extends FileEntry {
  TextEntry(String path) : super(path);

  @override
  String toString() {
    return 'TextEntry(path: $path)';
  }
}
