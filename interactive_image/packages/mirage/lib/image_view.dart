import 'package:flutter/material.dart';

/// An interactive view to an image providing pan, zoom gestures.
///
/// ### Parameters
/// - `imageProvider` - The image provider to get the image from to display.
/// - `onScale` - Callback that triggers when the image is scaled.
class ImageView extends StatefulWidget {
  const ImageView(this.imageProvider, {Key? key, this.onScale}) : super(key: key);

  /// The image provider to get the image from to display.
  final ImageProvider imageProvider;

  /// Callback that triggers when the image is scaled. Useful for disabling
  /// other gesture based actions while the image is scaled.
  final void Function(double)? onScale;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final _transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      // Default of 0.8 and 2.5 are odd and restrictive
      minScale: 1.0,
      maxScale: 10.0,
      transformationController: _transformationController,
      child: Image(image: widget.imageProvider),
      onInteractionEnd: (_) {
        if (widget.onScale != null) {
          widget.onScale!(_transformationController.value.getMaxScaleOnAxis());
        }
      },
    );
  }
}
