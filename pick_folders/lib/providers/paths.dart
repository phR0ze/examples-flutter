import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Generated riverpod code
part 'paths.g.dart';

@Riverpod(keepAlive: true)
class Paths extends _$Paths {
  @override
  Future<List<PlatformFile>> build() async {
    // There won't be any initial paths as the user needs to set these
    return [];
  }

  /// Prompt the user to choose one or more system paths and return the result.
  Future<void> getFiles(
      {String? dialogTitle,
      String? initialDir,
      FileType type = FileType.any,
      bool allowMultiple = false,
      List<String>? allowedExts}) async {
    state = await AsyncValue.guard(() async {
      return (await FilePicker.platform.pickFiles(
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
    });
  }
}
