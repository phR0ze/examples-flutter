import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'model/folder.dart';
import 'const.dart';
import 'utils/file.dart';
import 'model/file.dart';
import 'utils/mime.dart' as mime;

class AppState extends ChangeNotifier {
  List<String>? _images;

  // Track folder vs all image view
  bool _folderView = false;
  bool get folderView => _folderView;
  void toggleFolderView() {
    if (_folderView) {
      _folderView = false;
    } else {
      _folderView = true;
    }
    notifyListeners();
  }

  // Route tracking for responsive navigation sharing
  int _currentRoute = 0;
  int get currentRoute => _currentRoute;
  set currentRoute(int value) {
    if (value != _currentRoute) {
      _currentRoute = value;
      notifyListeners();
    }
  }

  // Thumbnail size
  double _imageSize = Const.imageSizeDefault;
  double get imageSize => _imageSize;

  void zoomInImage() {
    _imageSize += 100.0;
    notifyListeners();
  }

  void zoomOutImage() {
    _imageSize -= 100.0;
    if (_imageSize < 100.0) {
      _imageSize = 100.0;
    }
    notifyListeners();
  }

  // // Load folders from disk in an async fashion so as to not block the UI
  // List<Folder> _folders = [];
  // Future<List<Folder>> loadFolders() async {
  //   var rootPath = '${Platform.environment['HOME']}${Platform.pathSeparator}Pictures/2023/';

  //   Folder? folder;

  //   await for (var x in Directory(.path).list(followLinks: false)) {
  //     if (x is Directory) {
  //       // Skipping well-known folders that won't have data we care about
  //       if (Const.skipDirs.contains(x.name)) {
  //         continue;
  //       }
  //       var subFolder = await loadFolders(x.path);
  //       if (subFolder.files.isNotEmpty) {
  //         //log.green('Adding dir: ${x.path}');
  //         folder.addFolder(subFolder);
  //       } else {
  //         //log.yellow('Skipping dir: ${x.path}');
  //       }
  //     } else {
  //       // Filter formats
  //       if (mime.isImage(x.path)) {
  //         //log.cyan('Image: ${x.path}');
  //         folder.addFile(File(x.path));
  //       } else if (mime.isVideo(x.path)) {
  //         //log.yellow('Video: ${x.path}');
  //       } else {
  //         //log.red('Unknown: ${x.path}');
  //       }
  //     }
  //   }

  //   return folder;
  // }

  Future<List<String>> loadExampleImages() async {
    _images ??= List.generate(2000, (index) => Const.assetImagePlaceholder);
    return _images!;
  }
}

// Asynchronously load example folders
Future<Folder> loadExampleFolders() async {
  final String assetJson = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> assetMap = json.decode(assetJson);

  var examples = Folder('examples');
  for (var x in [
    Const.assetImageExamplesAnimals,
    Const.assetImageExamplesHouses,
    Const.assetImageExamplesMeadow,
    Const.assetImageExamplesRivers,
    Const.assetImageExamplesRobots,
    Const.assetImageExamplesValley
  ]) {
    var folder = Folder(x);
    examples.addFolder(folder);
    for (var y
        in assetMap.keys.where((String y) => y.startsWith('${Const.assetImageExamples}/$x'))) {
      // log.cyan('Adding asset: $y');
      folder.addFile(File(y));
    }
  }

  return examples;
}

// // Asynchronously load folders
// Future<Folder> loadFolders(String path) async {
//   var folder = Folder(path);

//   await for (var x in Directory(folder.path).list(followLinks: false)) {
//     if (x is Directory) {
//       // Skipping well-known folders that won't have data we care about
//       if (Const.skipDirs.contains(x.name)) {
//         continue;
//       }
//       var subFolder = await loadFolders(x.path);
//       if (subFolder.files.isNotEmpty) {
//         //log.green('Adding dir: ${x.path}');
//         folder.addFolder(subFolder);
//       } else {
//         //log.yellow('Skipping dir: ${x.path}');
//       }
//     } else {
//       // Filter formats
//       if (mime.isImage(x.path)) {
//         //log.cyan('Image: ${x.path}');
//         folder.addFile(File(x.path));
//       } else if (mime.isVideo(x.path)) {
//         //log.yellow('Video: ${x.path}');
//       } else {
//         //log.red('Unknown: ${x.path}');
//       }
//     }
//   }

//   return folder;
// }
