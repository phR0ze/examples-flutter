import 'package:flutter/material.dart';

class Const {
  // App attributes
  static const appName = 'Image Viewer';
  static const appVersion = '1.0.0';

  // App assets
  static const imagePlaceholder = 'assets/images/placeholder.png';

  // App configuration
  static const skipDirs = <String>['.git'];
  static const imageSizeDefault = 100.0;

  /// AppBar hight
  static const appBarHeight = 200.0;

  /// Default tile width
  static const tileWidthDefault = 100.0;

  // Padding around the page content
  static const pageOutsidePadding = 5.0;

  // Padding between grid tiles on the page
  static const pageGridPadding = 10.0;

  static const imageCacheQuality = 100;

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
