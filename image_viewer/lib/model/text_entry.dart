import 'file_entry.dart';

class TextEntry extends FileEntry {
  TextEntry(super.path);

  @override
  String toString() {
    return 'TextEntry(path: $path)';
  }
}
