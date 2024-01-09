class Const {
  /// Flutters default image format support
  static const imageExt = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', '.wbmp'];

  // App assets
  static const assetImagePlaceholder = 'assets/images/placeholder.png';

  /// Size increment to use when zooming in/out images
  static const tileSizeInc = 50.0;

  /// Minimum tile width
  static const tileWidthMin = 50.0;

  /// Default tile width
  static const tileWidthDefault = 100.0;

  // Tile width to height ratio
  static const tileAspectRatio = 0.8;

  // Padding around the page content
  static const pageOutsidePadding = 5.0;

  // Padding between grid tiles
  static const pageGridPadding = 2.0;

  // Image cache quality
  static const imageCacheQuality = 400;
}
