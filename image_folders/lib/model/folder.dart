import 'entry.dart';

class Folder extends Entry {
  Folder(String path) : super(path);

  List<Entry> get entries => [];

  /// Returns true as this is a folder
  @override
  bool get isFolder => true;

  @override
  String toString() {
    return 'Folder(path: $path)';
  }
}
