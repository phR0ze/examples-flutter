import 'dart:io';
import 'package:image_folders/model/exports.dart' as model;
import 'package:test/test.dart';

void main() {
  test('Test config read/write', () async {
    var folder = model.FolderEntry('./linux');
    var files = await Directory(folder.path).list().toList();
    for (final x in files) {
      if (x is File) {
        print('Adding file: ${x.path}');
        folder.addFile(x);
      } else if (x is Directory) {
        print('Adding folder: ${x.path}');
        var subFolder = model.FolderEntry(x.path);
        folder.add(subFolder);
      }
    }
  });
}
