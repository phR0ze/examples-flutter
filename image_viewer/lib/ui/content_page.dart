import 'package:flutter/material.dart';
import 'text_view.dart';
import '../model/exports.dart' as model;
import 'common/exports.dart';
import 'image_view.dart';

class ContentPage extends StatefulWidget {
  final model.FileEntry entry;
  const ContentPage(this.entry, {super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.entry.name, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SwipeDetector(
        child: widget.entry.isImage
            ? ImageView(widget.entry as model.ImageEntry)
            : TextView(widget.entry as model.TextEntry),
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
