import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/folder.dart';
import 'state.dart';
import 'const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Load the persisted folders on startup.
  // This should only be done a needed as it is costly.
  Future<List<Folder>> _loadFolders() async {
    //var rootPath = '${Platform.environment['HOME']}${Platform.pathSeparator}Pictures/2023/';
    //var rootFolder = await loadFolders(rootPath);
    var rootFolder = await loadExampleFolders();

    return rootFolder.folders;
  }

  // void _pickFolder() async {
  //   final dir = await FilePicker.platform.getDirectoryPath(
  //     dialogTitle: 'Choose a folder to include',
  //     initialDirectory: '${Platform.environment['HOME']}${Platform.pathSeparator}Pictures',
  //   );

  //   // Load the images from the folder
  //   if (dir != null) {
  //     setState(() {
  //       log.cyan(dir);

  //       if (!tree.containsKey(dir)) {
  //         tree[dir] = [];
  //         Directory(dir).listSync(followLinks: false).forEach((x) {
  //           tree[dir]!.add(x.path);
  //           log.yellow(x.path);
  //         });
  //         return;
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text(Const.appName),
        actions: [
          // Launch the camera or screen capture tool
          IconButton(
            onPressed: () {
              // showAboutDialog(
              //   context: context,
              //   applicationName: Const.appName,
              //   applicationVersion: Const.appVersion,
              //   applicationIcon: const Icon(Icons.image),
              //   children: [
              //     const Text('This is a simple image viewer app.'),
              //   ],
              // );
            },

            // Push the icon down a bit to make it not look retarded
            // Scale a little to match the grid size
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 1.5),
              child: Transform.scale(
                scale: 1.1,
                child: const Icon(Icons.add_a_photo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
