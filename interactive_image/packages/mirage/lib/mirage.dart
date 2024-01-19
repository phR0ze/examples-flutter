library mirage;

import 'package:flutter/material.dart';
import 'image_view.dart';

// Public exports
// export 'image_view.dart' show ImageView;

/// Shows the image resolved from the [imageProvider] in an modal dialog which
/// allows for displaying the original page content behind the dialog when
/// swiping down to dismiss.
///
/// ### Parameters
/// - `context` - The context to show the dialog in.
/// - `imageProvider` - The image provider to get the image from to display.
Future<Dialog?> showImage(BuildContext context, ImageProvider imageProvider) {
  return showDialog<Dialog>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) {
        return ImageView(imageProvider, dismissible: true);
      });
}
