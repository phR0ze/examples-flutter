import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_viewer/log.dart';
import 'package:image_viewer/utils/file_ext.dart';
import 'package:image_viewer/utils/mime_ext.dart' as mime;

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

    // Pull root folders from persisted config
    var root = '${Platform.environment['HOME']}${Platform.pathSeparator}Pictures/2023/2023.01/';

    // Asynchronously load the folders from the root
    await for (var x in Directory(root).list(followLinks: false)) {
      if (x is Directory) {
        log.yellow('Dir: ${x.path}');
      } else {
        // Filter formats
        if (mime.isImage(x.path)) {
          log.green('Image: ${x.path}');
        } else if (mime.isVideo(x.path)) {
          log.cyan('Video: ${x.path}');
        } else {
          log.red('Unknown: ${x.path}');
        }
      }
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
    var image = Image.asset(Const.imagePlaceholder);
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
                var entity = snapshot.data!.elementAt(index);
                return ListTile(
                  title: Text(entity.name),
                  subtitle: Text(entity.path),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => ImageDialog(entity)));
                    //await showDialog(context: context, builder: (_) => ImageDialog(entity));
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
