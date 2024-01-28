import 'package:flutter/material.dart';

const double _kMinFlingVelocity = 700.0;
const double _kMinFlingVelocityDelta = 400.0;

enum Fling {
  none,
  up,
  down,
  left,
  right,
}

class MultiGesture extends StatefulWidget {
  // Devloper notes
  // * Calculate flings in the end functions
  final Function(Fling)? onFling;
  const MultiGesture({required this.child, this.onFling, super.key});

  final Widget child;

  @override
  State<MultiGesture> createState() => _MultiGestureState();
}

class _MultiGestureState extends State<MultiGesture> {
  void _handleVerticalDragStart(DragStartDetails details) {}

  void _handleVerticalDragUpdate(DragUpdateDetails details) {}

  void _handleVerticalDragEnd(DragEndDetails details) {
    final fling = _checkFling(details.velocity);
    if (widget.onFling != null) {
      widget.onFling!(fling);
    }
  }

  void _handleHorizontalDragEnd(DragEndDetails details) {
    final fling = _checkFling(details.velocity);
    if (widget.onFling != null) {
      widget.onFling!(fling);
    }
  }

  // Determine if the drage was a fling
  Fling _checkFling(Velocity velocity) {
    final double vx = velocity.pixelsPerSecond.dx;
    final double vy = velocity.pixelsPerSecond.dy;
    print('vx: $vx, vy: $vy');

    // First check if the velocity is in the right direction then if it was fast enough.
    if (vy.abs() - vx.abs() > _kMinFlingVelocityDelta && vy.abs() > _kMinFlingVelocity) {
      if (vy > 0) {
        return Fling.down;
      } else {
        return Fling.up;
      }
    } else if (vx.abs() - vy.abs() > _kMinFlingVelocityDelta && vx.abs() > _kMinFlingVelocity) {
      if (vx > 0) {
        return Fling.left;
      } else {
        return Fling.right;
      }
    }

    return Fling.none;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _handleHorizontalDragEnd,
      onVerticalDragStart: _handleVerticalDragStart,
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onVerticalDragEnd: _handleVerticalDragEnd,
      behavior: HitTestBehavior.opaque,

      // Child widget to provide slide animation for.
      child: widget.child,
    );
  }
}
