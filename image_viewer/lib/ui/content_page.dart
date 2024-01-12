import 'package:flutter/material.dart';
import 'text_view.dart';
import '../model/exports.dart' as model;
import 'common/exports.dart';
import 'image_view.dart';

class ContentPage extends StatefulWidget {
  final model.FolderEntry folder;
  final int index;
  const ContentPage(this.folder, this.index, {super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    final entry = widget.folder[widget.index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(entry.name, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SwipeDetector(
        child: entry.isImage
            ? ImageView(entry as model.ImageEntry)
            : TextView(entry as model.TextEntry),
        onSwipeUp: () => showSnackBar('Show image details!'),
        onSwipeDown: () => Navigator.pop(context),
        // onSwipeLeft: () => {
        //   if (widget.index + 1 < widget.images.length - 1)
        //     {
        //       setState(() {
        //         widget.index++;
        //         widget.id = '1.${widget.index}';
        //         widget.image = widget.images[widget.index];
        //       })
        //     }
        // },
        // onSwipeRight: () => {
        //   if (widget.index > 0)
        //     {
        //       setState(() {
        //         widget.index--;
        //         widget.id = '1.${widget.index}';
        //         widget.image = widget.images[widget.index];
        //       })
        //     }
        // },
      ),
    );
  }
}
