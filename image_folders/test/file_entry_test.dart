import 'package:image_folders/model/exports.dart' as model;
import 'package:test/test.dart';

void main() {
  test('Test file entry equality', () async {
    var file1 = model.FileEntry('file1');
    var file2 = file1;
    expect(file1, file2);
    var file3 = model.FileEntry('file1');
    expect(file1, file3);
  });
}
