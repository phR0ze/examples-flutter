import 'package:flutter/material.dart';

class Const {
  static const appName = 'Image Viewer';
  static const appVer = '0.0.1';

  /// Flutters default image format support
  static const imageExt = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', '.wbmp'];

  // App assets
  static const assetImagePlaceholder = 'assets/images/placeholder.png';

  /// AppBar hight
  static const appBarHeight = 200.0;

  /// Size increment to use when zooming in/out images
  static const tileSizeInc = 50.0;

  /// Minimum tile width
  static const tileWidthMin = 50.0;

  /// Default tile width
  static const tileWidthDefault = 100.0;

  // Tile width to height ratio
  static const tileAspectRatio = 0.75;

  // Padding around the page content
  static const pageOutsidePadding = 5.0;

  // Padding between grid tiles
  static const pageGridPadding = 2.0;

  // screen: 2560
  static const ultraWideThreshold = 1200;
  static const wideThreshold = 800;
  static const narrowThreshold = 450;
}

/// Returns true if the screen is narrow.
bool isNarrow(BoxConstraints size) {
  return size.maxWidth <= Const.narrowThreshold;
}

/// Returns true if the screen is wide.
bool isWide(BoxConstraints size) {
  return size.maxWidth > Const.narrowThreshold;
}

/// Returns true if the screen is ultra wide.
bool isUltraWide(BoxConstraints size) {
  return size.maxWidth > Const.wideThreshold;
}
