import 'package:flutter/material.dart';

class FlingDetails {
  FlingDetails({required this.fling, required this.velocity});
  final Fling fling;
  final Velocity velocity;
}

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
  const MultiGesture(
      {required this.child,
      this.onFling,
      this.velocity = 700.0,
      this.velocityDelta = 400.0,
      super.key});

  final Widget child;

  final Function(FlingDetails)? onFling;

  final double velocity;

  final double velocityDelta;

  @override
  State<MultiGesture> createState() => _MultiGestureState();
}

class _MultiGestureState extends State<MultiGesture> {
  void _handleVerticalDragStart(DragStartDetails details) {}

  void _handleVerticalDragUpdate(DragUpdateDetails details) {}

  void _handleVerticalDragEnd(DragEndDetails details) {
    final fling = _checkFling(details.velocity);
    if (widget.onFling != null) {
      widget.onFling!(FlingDetails(fling: fling, velocity: details.velocity));
    }
  }

  void _handleHorizontalDragEnd(DragEndDetails details) {
    final fling = _checkFling(details.velocity);
    if (widget.onFling != null) {
      widget.onFling!(FlingDetails(fling: fling, velocity: details.velocity));
    }
  }

  // Determine if the drage was a fling
  Fling _checkFling(Velocity velocity) {
    final double vx = velocity.pixelsPerSecond.dx;
    final double vy = velocity.pixelsPerSecond.dy;

    // First check if the velocity is in the right direction then if it was fast enough.
    if (vy.abs() - vx.abs() > widget.velocityDelta && vy.abs() > widget.velocity) {
      if (vy > 0) {
        return Fling.down;
      } else {
        return Fling.up;
      }
    } else if (vx.abs() - vy.abs() > widget.velocityDelta && vx.abs() > widget.velocity) {
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
