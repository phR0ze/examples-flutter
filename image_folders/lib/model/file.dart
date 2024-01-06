import 'entry.dart';

class File extends Entry {
  File(String path) : super(path);

  @override
  String toString() {
    return 'File(path: $path)';
  }
}
