import 'dart:io';
import '../const.dart';
import '../utils/log.dart';
import '../utils/file.dart';
import '../utils/mime.dart' as mime;

// Asynchronously load files recursively for the given path.
Future<Folder> loadFolders(String path) async {
  var folder = Folder(path);

  await for (var x in Directory(folder.path).list(followLinks: false)) {
    if (x is Directory) {
      // Skipping well-known folders that won't have data we care about
      if (Const.skipDirs.contains(x.name)) {
        continue;
      }
      var subFolder = await loadFolders(x.path);
      if (subFolder.files.isNotEmpty) {
        //log.green('Adding dir: ${x.path}');
        folder.addFolder(subFolder);
      } else {
        //log.yellow('Skipping dir: ${x.path}');
      }
    } else {
      // Filter formats
      if (mime.isImage(x.path)) {
        //log.cyan('Image: ${x.path}');
        folder.addFile(x);
      } else if (mime.isVideo(x.path)) {
        //log.yellow('Video: ${x.path}');
      } else {
        //log.red('Unknown: ${x.path}');
      }
    }
  }

  return folder;
}

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
