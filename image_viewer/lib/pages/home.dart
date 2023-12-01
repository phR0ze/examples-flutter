import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_viewer/log.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var folders = SplayTreeMap<String, List<String>>();

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/placeholder.png'),
          ],
        ),
      ),
    );
  }
}
