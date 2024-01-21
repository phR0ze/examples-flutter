import 'package:flutter/material.dart';

/// Custom dismissible implementation to understand this better
class DismissGestureDetector extends StatelessWidget {
  const DismissGestureDetector({
    required Key key,
    required this.child,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('index 1'),
      direction: DismissDirection.down,
      resizeDuration: null,
      onDismissed: (_) {
        Navigator.of(context).pop();
      },
      child: child,
    );
  }
}
