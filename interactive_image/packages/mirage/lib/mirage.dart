library mirage;

import 'package:flutter/material.dart';
import 'image_view.dart';

// Public exports
// export 'image_view.dart' show ImageView;

/// Shows the given [imageProvider] in an dialog.
Future<Dialog?> showImage(BuildContext context, ImageProvider imageProvider) {
  return showDialog<Dialog>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) {
        return ImageView(imageProvider);
      });
}
