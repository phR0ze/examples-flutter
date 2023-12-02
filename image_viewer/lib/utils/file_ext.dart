import 'dart:io';
import 'package:path/path.dart' as path;

import '../log.dart';
import '../model/folder.dart';
import '../utils/mime_ext.dart' as mime;

extension FileExtention on FileSystemEntity {
  String get name {
    return path.basename(this.path);
  }
}

// Asynchronously load files recursively for the given path.
Future<Folder> loadFolders(String path) async {
  var folder = Folder(path);

  await for (var x in Directory(folder.path).list(followLinks: false)) {
    if (x is Directory) {
      var subFolder = await loadFolders(x.path);
      if (subFolder.files.isNotEmpty) {
        log.green('Adding dir: ${x.path}');
        folder.addFolder(subFolder);
      } else {
        log.yellow('Skipping dir: ${x.path}');
      }
    } else {
      // Filter formats
      if (mime.isImage(x.path)) {
        log.cyan('Image: ${x.path}');
        folder.addFile(x);
      } else if (mime.isVideo(x.path)) {
        log.yellow('Video: ${x.path}');
      } else {
        log.red('Unknown: ${x.path}');
      }
    }
  }

  return folder;
}
