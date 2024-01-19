import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// An interactive view to an image providing pan, zoom and dismiss gestures.
///
/// ### Parameters
/// - `imageProvider` - The image provider to get the image from to display.
/// - `dismissible` - Whether the image can be dismissed by swiping down.
/// - `onScale` - Callback that triggers when the image is scaled.
class ImageView extends StatefulWidget {
  const ImageView(this.imageProvider, {Key? key, this.dismissible = false, this.onScale})
      : super(key: key);

  /// The image provider to get the image from to display.
  final ImageProvider imageProvider;

  /// Whether the image can be dismissed by swiping down.
  final bool dismissible;

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

    // Make the experience immersive
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    // Restore the system UI mode back to normal
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('ImageView'),
      direction: widget.dismissible ? DismissDirection.down : DismissDirection.none,
      resizeDuration: null,
      onDismissed: (_) {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.black,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            // Allows image to take the full screen
            SizedBox.expand(
              child: InteractiveViewer(
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
              ),
            ),
            // Close button
            if (widget.dismissible)
              Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ))
          ],
        ),
      ),
    );
  }
}
