import 'dart:io';
import 'package:image_folders/model/exports.dart' as model;
import 'package:test/test.dart';

void main() {
  test('Test folder entry equality', () async {
    var folder1 = model.FolderEntry('folder1');
    var folder2 = folder1;
    expect(folder1, folder2);
    var folder3 = model.FolderEntry('folder1');
    expect(folder1, folder3);
  });

  test('Test can add entries to folder', () async {
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
