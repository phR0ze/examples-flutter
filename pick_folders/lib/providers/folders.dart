import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../ui/utils.dart';

// Generated riverpod code
part 'folders.g.dart';

@Riverpod(keepAlive: true)
class Folders extends _$Folders {
  @override
  Future<List<String>> build() async {
    // There won't be any initial paths as the user needs to set these
    return [];
  }

  /// Prompt the user to choose a folder.
  Future<void> getFolder({String? dialogTitle, String? initialDir}) async {
    await AsyncValue.guard(() async {
      var dir = await FilePicker.platform.getDirectoryPath(
        dialogTitle: (dialogTitle == null || dialogTitle.isEmpty) ? 'Select folder' : dialogTitle,
        initialDirectory: (initialDir == null || initialDir.isEmpty) ? null : initialDir,
      );
      if (dir != null) {
        state.value!.add(dir);
        state = state;
      } else {
        showSnackBar('Folder selection cancelled');
      }
    });
  }
}
