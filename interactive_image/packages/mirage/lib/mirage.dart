library mirage;

import 'package:flutter/material.dart';
import 'image_providers.dart';
import 'image_view_pager.dart';

// Public exports
export 'image_providers.dart' show ImageProviders, ImageProviderList;

/// Shows the image resolved from the [imageProvider] in an modal dialog which
/// allows for displaying the original page content behind the dialog when
/// swiping down to dismiss.
///
/// ### Parameters
/// - `context` - The context to show the dialog in.
/// - `imageProviders` - An ImageProviders implementation for retrieving images.
Future<Dialog?> showImageViewPager(
  BuildContext context,
  ImageProviders imageProviders,
) {
  return showDialog<Dialog>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) {
        return ImageViewPager(imageProviders);
      });
}
