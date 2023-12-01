import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_viewer/log.dart';
import 'package:path/path.dart' as path;
import 'package:image_viewer/utils/file_ext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var folders = SplayTreeMap<String, List<String>>();

  // Load the persisted folders on startup
  Future<List<FileSystemEntity>> _loadFolders() async {
    List<FileSystemEntity> folders = [];

    // Hardcode the root folder for now
    var root = '${Platform.environment['HOME']}${Platform.pathSeparator}Pictures';

    // Asynchronously load the folders from the root
    await for (var x in Directory(root).list(followLinks: false)) {
      log.yellow(x.path);
      folders.add(x);
    }

    return folders;
  }

  void _pickFolder() async {
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Choose a folder to include',
      initialDirectory: '${Platform.environment['HOME']}${Platform.pathSeparator}Pictures',
    );

    // Load the images from the folder
    if (dir != null) {
      setState(() {
        log.cyan(dir);

        if (!folders.containsKey(dir)) {
          folders[dir] = [];
          Directory(dir).listSync(followLinks: false).forEach((x) {
            folders[dir]!.add(x.path);
            log.yellow(x.path);
          });
          return;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var image = Image.asset('assets/images/placeholder.png');
    // if (folders.isNotEmpty) {
    //   image = Image.file(File(folders.values.first.first));
    // }

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
              _pickFolder();
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
      body: FutureBuilder(
        future: _loadFolders(),
        builder: (BuildContext context, AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data!.elementAt(index).name),
                  subtitle: Text(snapshot.data!.elementAt(index).path),
                  onTap: () {
                    // setState(() {
                    //   image = Image.file(File(folders.values.elementAt(index).first));
                    // });
                  },
                );
              },
            );
          } else {
            // Show a loading indicator while waiting for the folders to load
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
