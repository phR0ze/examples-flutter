import 'dart:io';

class Folder {
  final String _path;
  int count = 0;
  final List<Folder> folders = [];
  final List<FileSystemEntity> files = [];

  String get path => _path;

  Folder(String path) : _path = path;

  // Add a file
  addFile(FileSystemEntity file) {
    count++;
    files.add(file);
  }

  // Add a folder
  addFolder(Folder folder) {
    count++;
    folders.add(folder);
  }
}
