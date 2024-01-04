import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_folders/ui/loading.dart';
import '../providers/paths.dart';
import 'utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final double fieldWidth = 400.0;
  final dialogTitleCtrl = TextEditingController();
  final initDirectoryCtrl = TextEditingController();
  final defaultFileNameCtrl = TextEditingController();
  final fileExtCtrl = TextEditingController();
  var filePickType = FileType.any;
  String? ext;
  bool allowMultiple = false;

  // Setup a text field listener such that when the text controller changes
  // the extension is updated with the new value.
  @override
  void initState() {
    super.initState();
    fileExtCtrl.addListener(() => ext = fileExtCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(pathsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter file_pick example', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          // Align widgets to start on the left
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleWidget(context, 'Configuration'),

            // Wrap to make this responsive in a simple way
            Wrap(
              // Add horizontal space between the widgets
              spacing: 10,
              // Add vertical space between the widgets
              runSpacing: 10,
              children: [
                _inputTextField(fieldWidth, 'Set the file picker dialog title', dialogTitleCtrl),
                _inputTextField(fieldWidth, 'Initial directory for dialog', initDirectoryCtrl),
                _inputTextField(fieldWidth, 'Default file name for saving', defaultFileNameCtrl),

                // Show the dropdown for the file type selection
                SizedBox(
                  width: fieldWidth,
                  child: DropdownButtonFormField<FileType>(
                    value: filePickType,
                    icon: const Icon(Icons.expand_more),
                    alignment: Alignment.centerLeft,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: FileType.values
                        .map(
                          (fileType) => DropdownMenuItem<FileType>(
                            value: fileType,
                            child: Text(fileType.toString()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(
                      () {
                        filePickType = value!;
                        if (filePickType != FileType.custom) {
                          fileExtCtrl.text = ext = '';
                        }
                      },
                    ),
                  ),
                ),

                // Show the file extension field only when the file type is custom
                filePickType == FileType.custom
                    ? SizedBox(
                        width: fieldWidth,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'File Extension',
                              hintText: 'jpg, png, gif'),
                          autovalidateMode: AutovalidateMode.always,
                          controller: fileExtCtrl,
                          keyboardType: TextInputType.text,
                          maxLength: 15,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: fieldWidth),
                  child: SwitchListTile.adaptive(
                    title: const Text(
                      'Pick multiple files',
                      textAlign: TextAlign.left,
                    ),
                    onChanged: (bool value) => setState(() => allowMultiple = value),
                    value: allowMultiple,
                  ),
                ),
              ],
            ),

            // Add a divider line
            const Divider(),

            // Show the actions title
            _titleWidget(context, 'Actions'),

            // Add the action buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: FloatingActionButton.extended(
                        onPressed: () => ref.read(pathsProvider.notifier).getFiles(
                            type: filePickType,
                            dialogTitle: dialogTitleCtrl.text,
                            initialDir: initDirectoryCtrl.text,
                            allowMultiple: allowMultiple,
                            allowedExts: ext?.split(',')),
                        label: Text(allowMultiple ? 'Select files' : 'Select file'),
                        icon: const Icon(Icons.description)),
                  ),
                  SizedBox(
                    width: 120,
                    child: FloatingActionButton.extended(
                      onPressed: () => const Placeholder(), //_selectFolder(),
                      label: const Text('Pick folder'),
                      icon: const Icon(Icons.folder),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: FloatingActionButton.extended(
                      onPressed: () => const Placeholder(), //_saveFile(),
                      label: const Text('Save file'),
                      icon: const Icon(Icons.save_as),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: FloatingActionButton.extended(
                      onPressed: () => showSnackBar('Clear temporary files'),
                      label: const Text('Clear temporary files'),
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // File selection results
            asyncValue.when(
              skipError: true,
              data: (paths) {
                if (paths.isEmpty) {
                  return const Text('No paths selected');
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var path in paths) Text(path.name),
                  ],
                );
              },
              loading: () => const LoadingIndicator(),
              error: (error, stack) => const Text('error'), //showSnackBar('Error: $error'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget _inputTextField(double width, String hint, TextEditingController controller) {
    // Use a sized box here to constrain the text field width
    return SizedBox(
      width: width,
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
        ),
        controller: controller,
      ),
    );
  }
}
