import 'package:flutter/material.dart';

/// Convenience methods for checking constrains for adaptive UI.
/// e.g. `if (constraints.isDesktop)`
extension BoxConstraintsExt on BoxConstraints {
  bool get isTablet => maxWidth > 730;
  bool get isDesktop => maxWidth > 1200;
  bool get isMobile => !isTablet && !isDesktop;
}
