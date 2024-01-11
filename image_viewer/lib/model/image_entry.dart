import 'file_entry.dart';

class ImageEntry extends FileEntry {
  ImageEntry(String path) : super(path);

  @override
  String toString() {
    return 'ImageEntry(path: $path)';
  }
}
