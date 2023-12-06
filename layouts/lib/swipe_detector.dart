import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  /// Child widget to wrap
  final Widget child;

  /// Callback for swipe up
  final Function()? onSwipeUp;

  /// Callback for swipe down
  final Function()? onSwipeDown;

  /// Callback for swipe left
  final Function()? onSwipeLeft;

  /// Callback for swipe right
  final Function()? onSwipeRight;

  /// Vertical delta needs to be more than this value to detect a vertical swipe
  final double verticalMinDrag;

  /// Horizontal delta needs to be less than this value to detect a vertical swipe
  final double horizontalMaxJitter;

  /// Vertical velocity needs to be monre than this value to detect a vertical swipe
  final double verticalMinVelocity;

  /// Horizontal delta needs to be more than this value to detect a horizontal swipe
  final double horizontalMinDrag;

  /// Vertical delta needs to be less than this value to detect a horizontal swipe
  final double verticalMaxJitter;

  /// Horizontal velocity needs to be monre than this value to detect a horizontal swipe
  final double horizontalMinVelocity;

  const SwipeDetector(
      {super.key,
      this.onSwipeUp,
      this.onSwipeDown,
      this.onSwipeLeft,
      this.onSwipeRight,
      this.verticalMinDrag = 100.0,
      this.horizontalMaxJitter = 50.0,
      this.verticalMinVelocity = 300.0,
      this.horizontalMinDrag = 100.0,
      this.verticalMaxJitter = 50.0,
      this.horizontalMinVelocity = 300.0,
      required this.child});

  @override
  Widget build(BuildContext context) {
    // Vertical drag details
    DragStartDetails? startVerticalDragDetails;
    DragUpdateDetails? updateVerticalDragDetails;

    // Horizontal drag details
    DragStartDetails? startHorizontalDragDetails;
    DragUpdateDetails? updateHorizontalDragDetails;

    return GestureDetector(
      // Track initial vertical drag and update drag details
      onVerticalDragStart: (startDetails) {
        startVerticalDragDetails = startDetails;
      },
      onVerticalDragUpdate: (updateDetails) {
        updateVerticalDragDetails = updateDetails;
      },

      // Once drag is complete, check if it was a swipe
      onVerticalDragEnd: (endDetails) {
        // Abort if not fully initialized yet. I doubt this will ever happen
        if (startVerticalDragDetails == null && updateVerticalDragDetails == null) {
          return;
        }

        // Calculate horizontal delta from start to the last update.
        // Abort if delta was above the threshold
        double dx = updateVerticalDragDetails!.globalPosition.dx -
            startVerticalDragDetails!.globalPosition.dx;
        if (dx.abs() > horizontalMaxJitter) return;

        // Calculate vertical delta from start to the last update.
        // Abort if delta was below the threshold
        double dy = updateVerticalDragDetails!.globalPosition.dy -
            startVerticalDragDetails!.globalPosition.dy;
        if (dy.abs() < verticalMinDrag) return;

        // Get the velocity from the end drag details
        // Abort if velocity was below the threshold
        double velocity = endDetails.primaryVelocity!;
        if (velocity.abs() < verticalMinVelocity) return;

        // Finally determine if the swipe it was up or down
        if (velocity < 0) {
          if (onSwipeUp != null) onSwipeUp!();
        } else {
          if (onSwipeDown != null) onSwipeDown!();
        }
      },

      // Track initial horizontal drag and update drag details
      onHorizontalDragStart: (startDetails) {
        startHorizontalDragDetails = startDetails;
      },
      onHorizontalDragUpdate: (updateDetails) {
        updateHorizontalDragDetails = updateDetails;
      },

      // Once horizontal drag is complete, check if it was a swipe
      onHorizontalDragEnd: (endDetails) {
        // Abort if not fully initialized yet. I doubt this will ever happen
        if (startHorizontalDragDetails == null && updateHorizontalDragDetails == null) {
          return;
        }

        // Calculate vertical delta from start to the last update.
        // Abort if delta was above the threshold
        double dy = updateHorizontalDragDetails!.globalPosition.dy -
            startHorizontalDragDetails!.globalPosition.dy;
        if (dy.abs() > verticalMaxJitter) return;

        // Calculate horizontal delta from start to the last update.
        // Abort if delta was below the threshold
        double dx = updateHorizontalDragDetails!.globalPosition.dx -
            startHorizontalDragDetails!.globalPosition.dx;
        if (dx.abs() < horizontalMinDrag) return;

        // Get the velocity from the end drag details
        // Abort if velocity was below the threshold
        double velocity = endDetails.primaryVelocity!;
        if (velocity.abs() < horizontalMinVelocity) return;

        // Finally determine if the swipe it was up or down
        if (velocity < 0) {
          if (onSwipeLeft != null) onSwipeLeft!();
        } else {
          if (onSwipeRight != null) onSwipeRight!();
        }
      },
      child: child,
    );
  }
}
