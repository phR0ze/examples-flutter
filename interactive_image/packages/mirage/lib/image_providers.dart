import 'package:flutter/material.dart';

/// An flexible way to get user supplied ImageProvider instances
/// for each image that is then passed to the to the [ImageViewPager] for display.
abstract class ImageProviders {
  /// Index of the image provider that will be getting the image to display.
  int get index;

  /// Total number of images availble to build image providers for.
  int get length;

  /// Return the image provider for the image at the given index.
  ImageProvider get(BuildContext context, int index);
}

/// Simple default ImageProviders implementation that takes a list of ImageProvider
class ImageProviderList implements ImageProviders {
  const ImageProviderList(this.imageProviders);

  /// The list of image providers to use.
  final List<ImageProvider> imageProviders;

  @override
  int get index => 0;

  @override
  int get length => imageProviders.length;

  @override
  ImageProvider get(BuildContext context, int index) {
    return imageProviders[index];
  }
}
