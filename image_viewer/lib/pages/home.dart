import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../const.dart';
import '../widgets/folder_cover.dart';
import '../components/folder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Load the persisted folders on startup.
  // This should only be done a needed as it is costly.
  Future<List<Folder>> _loadFolders() async {
    var rootPath = '${Platform.environment['HOME']}${Platform.pathSeparator}Pictures/2023/';

    // Not reading files from root only folders?
    var rootFolder = await loadFolders(rootPath);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text(Const.appName),
        actions: [
          // Change the layout of the view
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.grid_on),
          ),

          // Pick a new folder to include
          IconButton(
            onPressed: () {
              // _pickFolder();
            },
            // Scale a little to match the grid size
            icon: Transform.scale(
              scale: 1.1,
              child: const Icon(Icons.add_box),
            ),
          ),

          // Launch the camera or screen capture tool
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: Const.appName,
                applicationVersion: Const.appVersion,
                applicationIcon: const Icon(Icons.image),
                children: [
                  const Text('This is a simple image viewer app.'),
                ],
              );
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
      body: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder(
          future: _loadFolders(),
          builder: (BuildContext context, AsyncSnapshot<List<Folder>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return CustomScrollView(
                slivers: [
                  snapshot.data!.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Center(child: Text('No folders found')),
                        )
                      : SliverGrid(
                          // Build folder covers lazily as we scroll with SliverGrid
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: constraints.maxWidth >= 600
                                  ? MediaQuery.of(context).size.width * 0.1
                                  : MediaQuery.of(context).size.width * 0.6,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              var folder = snapshot.data!.elementAt(index);
                              return FolderCover(
                                folderPath: folder.path,
                                folderImagePath: folder.files.first.path,
                                folderImageCount: folder.count,
                              );
                            },
                            childCount: snapshot.data!.length,
                          ),
                        ),
                ],
              );
            } else {
              // Show a loading indicator while waiting for the folders to load
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final FileSystemEntity entity;
  const ImageDialog(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GestureDetector(
        // Allow for vertical swiping to close the dialog
        onVerticalDragUpdate: (details) {
          int sensitivity = 10;
          if (details.delta.dy > sensitivity || details.delta.dy < -sensitivity) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(entity.path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
