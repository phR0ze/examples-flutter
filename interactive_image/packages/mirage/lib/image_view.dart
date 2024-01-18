import 'package:flutter/material.dart';

/// An interactive view to an image providing pan, zoom and dismiss gestures.
///
/// ### Parameters
/// - `imageProvider` - The image provider get get the image from to display.
class ImageView extends StatefulWidget {
  final ImageProvider imageProvider;

  const ImageView(this.imageProvider, {Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Image(image: widget.imageProvider),
    );
  }
}
