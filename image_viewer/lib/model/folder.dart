import 'entry.dart';
import 'file.dart';

class Folder extends Entry {
  int children = 0;
  final List<Folder> folders = [];
  final List<File> files = [];

  Folder(path) : super(path);

  // Add a file
  addFile(File file) {
    children++;
    files.add(file);
  }

  // Add a folder
  addFolder(Folder folder) {
    children++;
    folders.add(folder);
  }
}
