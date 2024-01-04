import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as path;

import '../ui/utils.dart';

// Generated riverpod code
part 'paths.g.dart';

@Riverpod(keepAlive: true)
class Paths extends _$Paths {
  @override
  Future<List<PlatformFile>> build() async {
    // There won't be any initial paths as the user needs to set these
    return [];
  }

  /// Prompt the user to save a file by name
  Future<void> saveFile(
      {String? dialogTitle,
      String? initialDir,
      FileType type = FileType.any,
      List<String>? allowedExts}) async {
    state = await AsyncValue.guard(() async {
      var file = await FilePicker.platform.saveFile(
        dialogTitle: (dialogTitle == null || dialogTitle.isEmpty) ? 'Save file' : dialogTitle,
        type: type,
        allowedExtensions: allowedExts,
        initialDirectory: (initialDir == null || initialDir.isEmpty) ? null : initialDir,
      );
      if (file != null) {
        return [PlatformFile(name: path.basename(file), path: file, size: 0)];
      }

      // Show the user the results
      showSnackBar('File save cancelled');
      return [];
    });
  }

  /// Prompt the user to choose one or more files
  Future<void> getFiles(
      {String? dialogTitle,
      String? initialDir,
      FileType type = FileType.any,
      bool allowMultiple = false,
      List<String>? allowedExts}) async {
    state = await AsyncValue.guard(() async {
      var files = (await FilePicker.platform.pickFiles(
            dialogTitle: (dialogTitle == null || dialogTitle.isEmpty)
                ? (allowMultiple ? 'Select files' : 'Select file')
                : dialogTitle,
            type: type,
            allowedExtensions: allowedExts,
            allowMultiple: allowMultiple,
            initialDirectory: (initialDir == null || initialDir.isEmpty) ? null : initialDir,
          ))
              ?.files ??
          [];
      if (files.isEmpty) {
        showSnackBar('File selection cancelled');
      }
      return files;
    });
  }

  /// Prompt the user to choose a folder.
  /// file_picker doesn't support more than one folder nor does it support a common structure
  /// between files and folders.
  Future<void> getFolder({String? dialogTitle, String? initialDir}) async {
    state = await AsyncValue.guard(() async {
      var dir = await FilePicker.platform.getDirectoryPath(
        dialogTitle: (dialogTitle == null || dialogTitle.isEmpty) ? 'Select folder' : dialogTitle,
        initialDirectory: (initialDir == null || initialDir.isEmpty) ? null : initialDir,
      );
      if (dir != null) {
        return [PlatformFile(name: path.basename(dir), path: dir, size: 0)];
      }

      // Show the user the results
      showSnackBar('Folder selection cancelled');
      return [];
    });
  }
}
