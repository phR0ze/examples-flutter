import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import '../utils/logger.dart';
import 'text_view.dart';
import '../model/exports.dart' as model;
import 'common/exports.dart';
import 'image_view.dart';

class ContentProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final model.FolderEntry folder;

  ContentProvider(this.folder, index) : initialIndex = index;

  @override
  int get imageCount => folder.length;

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    return FileImage(File(folder.entries[index].path));
  }
}

class ContentPage extends StatefulWidget {
  final model.FolderEntry folder;
  final int index;
  const ContentPage(this.folder, this.index, {super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  var i = -1;

  @override
  void initState() {
    super.initState();
    i = widget.index;
  }

  // Get the entry widget for the current index
  Widget _entryWidget(model.Entry entry) {
    switch (entry) {
      case model.ImageEntry x:
        return ImageView(x);
      case model.TextEntry x:
        return TextView(x);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.folder[i];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(entry.name, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SwipeDetector(
        child: _entryWidget(entry),
        onSwipeUp: () => showSnackBar('Show image details!'),
        onSwipeDown: () => Navigator.pop(context),
        onSwipeLeft: () {
          if (i + 1 < widget.folder.length - 1) {
            setState(() {
              log.info('Show the next image');
              i++;
            });
          }
        },
        onSwipeRight: () {
          if (i > 0) {
            setState(() {
              log.info('Show the prevous image');
              i--;
            });
          }
        },
      ),
    );
  }
}
