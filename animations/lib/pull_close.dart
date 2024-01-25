import 'package:flutter/material.dart';

// Used as a fling indicator
enum _Fling { none, down, up }

/// Implements the ability for a user to pull down a widget to close it.
///
/// ### Features
/// - Pull or fling down to close
/// - Pull or fling up to reset
/// - Fade and scale down while pulled down
/// - Callback when widget is closed
///
/// ### Parameters
/// - [child] - The widget to provide the pull close animation for.
/// - [onClosed] - Called when the widget has been closed.
/// - [threshold] - The percentage of the widget's height user must pull down to trigger close
class PullClose extends StatefulWidget {
  const PullClose({
    required this.child,
    this.onClosed,
    this.threshold = 0.30,
    super.key,
  });

  /// The widget below this widget in the tree
  final Widget child;

  /// Called when the widget has been closed. This must be handled to remove the closed widget from
  /// the widget tree e.g. [Navigator.of(context).pop()].
  final VoidCallback? onClosed;

  /// The percentage of the widget's height that the user must pull down to trigger a close.
  final double threshold;

  @override
  State<PullClose> createState() => _PullCloseState();
}

// AnimationControllers linearly produce values from 0.0 to 1.0 over the given duration by default.
// We are subverting this typical behavavior though by never animating it, i.e. never allowing it to
// generate any numbers. Instead we are manually setting the value of the animation controller to
// our own calculated percentages of the user's drag delta down the screen. That is to say as the
// user drags the pointer down the screen we calculate the drag distance in reference to the top of
// the widget's original location which becomes a percentage that Tween<Offset> will then translate
// into a offset that the SlideTransition will use to move the child widget.
//
// As a result we get manually controlled animations without every running any animation effects
// from the controller.
class _PullCloseState extends State<PullClose> with TickerProviderStateMixin {
  bool _isClosed = false;
  double _dragDelta = 0.0;
  final GlobalKey _childKey = GlobalKey();

  // Animations
  late Animation<Offset> _slideAnimation;
  late Animation<double> _percentAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // No duration is provided because we will never be animating the controller.
    _controller = AnimationController(vsync: this);

    // SlideTransition understands the [Offset] as scaled to the child's size. For example, an
    // [Offset] with a `dy` of 0.25 will result in a vertical translation of one quarter the height of
    // the child. Thus starting at 0.0 and ending at 1.0 means offset by 0 up to offset by 100%.
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(_controller);

    // Reusing this [double] animation for both the Scale and Fade transitions as they both use a
    // percentage type value to scale down and reduce opacity respectively. For example a value of
    // 0.25 would mean scaling down to 25% of the original size or reducing opacity to 25%.
    // By setting this to start at 1.0 and scale down to 0.0 we get a faster change in scale and
    // opacity relative to the slide down but will never be allowed to get too small as the slide
    // effect will trigger a close before that happens.
    _percentAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  // Reset the slide animation in the direction of the drag.
  // Offset is used here to represent a 2D location on the screen. The slide tween
  // animation will be generating location values to move the child widget.
  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    // Each widget has its own BuildContext i.e. context, which becomes the parent of the widget
    // returned by the build function. This means that inside the build function the context is not
    // the same as the context outside the build function. context provides information about the
    // widget's render information and location in the widget tree.
    //
    // The context.size property provides the size of the widget's render box i.e. how much space is
    // the widget taking up on the screen as a box. This value is only to be used outside the build
    // function in callbacks like from GestureDetectors as the widget has already been rendered. The
    // property gives use the size of the widget's render box.
    //
    // We can use the context.size to understand the available space that the widget can be
    // moved and thus using the current drag delta we can calculate the percentage of the
    // available space that the user has dragged the widget down. In this way we can manually
    // tie the users movements to the slide animation and give the effect that the user is
    // performing the slide movement directly rather than indirectly via a slide animation.
    //
    // This is the same technique that SlideTransition uses to understand where to animate the
    // movement of the child widget to i.e. 0.25 means move down 25% of the widget's height.
    final height = context.size!.height;

    // Accumulate the primary axis drag delta
    _dragDelta += details.primaryDelta!;

    // Don't allow to drag past the top of the widget' original location
    if (_dragDelta < 0.0) _dragDelta = 0.0;

    // Trigger close action if user has pulled more than the threshold
    if (_dragDelta >= height * widget.threshold) {
      _handleOnClosed();
    }

    // Calculate the percentage the user pulled down the widget
    final percentage = _dragDelta / height;
    _controller.value = percentage;
  }

  // End of a drag is only useful in that a user may have flung the widget down or up.
  // In which case we can ensure the widget is either fully down or fully up.
  void _handleVerticalDragEnd(DragEndDetails details) {
    const double minFlingVelocity = 700.0;
    const double minFlingVelocityDelta = 400.0;
    final double vx = details.velocity.pixelsPerSecond.dx;
    final double vy = details.velocity.pixelsPerSecond.dy;

    // Determine if this was a fling that ended the drag
    var fling = _Fling.down;
    if (vy == 0 || vy.abs() - vx.abs() < minFlingVelocityDelta || vy.abs() < minFlingVelocity) {
      // Flings that are not true enough in one direction or are too slow don't count
      fling = _Fling.none;
    } else if (vy < 0) {
      fling = _Fling.up;
    }

    // Adjust the controller for a fling
    switch (fling) {
      case _Fling.up:
        // Reset animations
        _controller.value = 0.0;
        _dragDelta = 0.0;
      case _Fling.down:
        _handleOnClosed();
      default:
        // Do nothing
        break;
    }
  }

  // Call the onClosed callback if provided.
  // Only allow it to be called once or it will close more than it should.
  void _handleOnClosed() {
    if (!_isClosed && widget.onClosed != null) {
      _isClosed = true;
      widget.onClosed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onVerticalDragEnd: _handleVerticalDragEnd,
      //behavior: widget.behavior,

      // Child widget to provide slide animation for.
      child: FadeTransition(
        opacity: _percentAnimation,
        child: ScaleTransition(
          scale: _percentAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            // Wrapping the child in a known key allows us to refer to it later
            child: KeyedSubtree(
              key: _childKey,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  // Controllers need to be disposed of to prevent memory leaks
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
