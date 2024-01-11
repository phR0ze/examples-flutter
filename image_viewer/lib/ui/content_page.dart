import 'package:flutter/material.dart';
import 'package:image_viewer/ui/text_view.dart';
import '../model/exports.dart' as model;
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
      body: widget.entry.isImage
          ? ImageView(widget.entry as model.ImageEntry)
          : TextView(widget.entry as model.TextEntry),
      // body: SwipeDetector(
      //     child: Center(
      //         child: GridTile(
      //       header: Padding(
      //         padding: const EdgeInsets.all(20.0),
      //         child: Text(widget.id, style: Theme.of(context).textTheme.displayMedium),
      //       ),
      //       child: Image.asset(
      //         Const.assetImagePlaceholder,
      //         fit: BoxFit.contain,
      //         width: MediaQuery.of(context).size.width,
      //         height: MediaQuery.of(context).size.height,
      //       ),
      //     )),
      //     onSwipeUp: () => showSnackBar('Show image details!'),
      //     onSwipeDown: () => Navigator.pop(context),
      //     onSwipeLeft: () => {
      //           if (widget.index + 1 < widget.images.length - 1)
      //             {
      //               setState(() {
      //                 widget.index++;
      //                 widget.id = '1.${widget.index}';
      //                 widget.image = widget.images[widget.index];
      //               })
      //             }
      //         },
      //     onSwipeRight: () => {
      //           if (widget.index > 0)
      //             {
      //               setState(() {
      //                 widget.index--;
      //                 widget.id = '1.${widget.index}';
      //                 widget.image = widget.images[widget.index];
      //               })
      //             }
      //         }),
    );
  }
}
