import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  /// Child widget to wrap
  final Widget child;

  /// Callback for swipe up
  final Function()? onSwipeUp;

  /// Callback for swipe down
  final Function()? onSwipeDown;

  /// Vertical delta needs to be more than this value to detect a vertical swipe
  final double verticalDragThreshold;

  /// Horizontal delta needs to be less than this value to detect a vertical swipe
  final double horizontalJitterThreshold;

  /// Vertical velocity threshold
  final double verticalVelocityThreshold;

  const SwipeDetector(
      {super.key,
      this.onSwipeUp,
      this.onSwipeDown,
      this.verticalDragThreshold = 100.0,
      this.horizontalJitterThreshold = 50.0,
      this.verticalVelocityThreshold = 300.0,
      required this.child});

  @override
  Widget build(BuildContext context) {
    DragStartDetails? startVerticalDragDetails;
    DragUpdateDetails? updateVerticalDragDetails;

    // Horizontal drag details
    // DragStartDetails startHorizontalDragDetails;
    // DragUpdateDetails updateHorizontalDragDetails;

    return GestureDetector(
      // Track initial drag and update drag details
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
        if (dx.abs() > horizontalJitterThreshold) return;

        // Calculate vertical delta from start to the last update.
        // Abort if delta was below the threshold
        double dy = updateVerticalDragDetails!.globalPosition.dy -
            startVerticalDragDetails!.globalPosition.dy;
        if (dy.abs() < verticalDragThreshold) return;

        // Get the velocity from the end drag details
        // Abort if velocity was below the threshold
        double velocity = endDetails.primaryVelocity!;
        if (velocity.abs() < verticalVelocityThreshold) return;

        // Finally determine if the swipe it was up or down
        if (velocity < 0) {
          if (onSwipeUp != null) onSwipeUp!();
        } else {
          if (onSwipeDown != null) onSwipeDown!();
        }
      },
      child: child,
    );
  }
}
