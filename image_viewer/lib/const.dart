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

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006491),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFC9E6FF),
    onPrimaryContainer: Color(0xFF001E2F),
    secondary: Color(0xFF50606E),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD3E5F5),
    onSecondaryContainer: Color(0xFF0C1D29),
    tertiary: Color(0xFF00658E),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFC7E7FF),
    onTertiaryContainer: Color(0xFF001E2E),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFCFCFF),
    onBackground: Color(0xFF1A1C1E),
    surface: Color(0xFFFCFCFF),
    onSurface: Color(0xFF1A1C1E),
    surfaceVariant: Color(0xFFDDE3EA),
    onSurfaceVariant: Color(0xFF41474D),
    outline: Color(0xFF72787E),
    onInverseSurface: Color(0xFFF0F0F3),
    inverseSurface: Color(0xFF2E3133),
    inversePrimary: Color(0xFF8ACEFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006491),
    outlineVariant: Color(0xFFC1C7CE),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF8ACEFF),
    onPrimary: Color(0xFF00344E),
    primaryContainer: Color(0xFF004B6F),
    onPrimaryContainer: Color(0xFFC9E6FF),
    secondary: Color(0xFFB7C9D9),
    onSecondary: Color(0xFF22323F),
    secondaryContainer: Color(0xFF384956),
    onSecondaryContainer: Color(0xFFD3E5F5),
    tertiary: Color(0xFF84CFFF),
    onTertiary: Color(0xFF00344C),
    tertiaryContainer: Color(0xFF004C6C),
    onTertiaryContainer: Color(0xFFC7E7FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C1E),
    onBackground: Color(0xFFE2E2E5),
    surface: Color(0xFF1A1C1E),
    onSurface: Color(0xFFE2E2E5),
    surfaceVariant: Color(0xFF41474D),
    onSurfaceVariant: Color(0xFFC1C7CE),
    outline: Color(0xFF8B9198),
    onInverseSurface: Color(0xFF1A1C1E),
    inverseSurface: Color(0xFFE2E2E5),
    inversePrimary: Color(0xFF006491),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF8ACEFF),
    outlineVariant: Color(0xFF41474D),
    scrim: Color(0xFF000000),
  );
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
