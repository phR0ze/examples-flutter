import 'package:flutter/material.dart';

// Used as a fling indicator
enum _Fling { none, down, up }

/// Implements the ability for a user to pull down a widget and have it just stay that way until
/// the user decideds to pull it back up or the page is refreshed.
///
/// This is an interesting problem to solve as we need to detect the user's pointer movement and
/// then translate that into an animation. This is not how animations normally work and makes for
/// and interesting manual manipulation of the animation mechanisms.
class ExplicitPullDown extends StatefulWidget {
  const ExplicitPullDown({
    super.key,
  });

  @override
  State<ExplicitPullDown> createState() => _ExplicitPullDownState();
}

// AnimationControllers linearly produce values from 0.0 to 1.0 over the given duration by default.
// We are subverting this typical behavavior though by never animating it, i.e. never allowing it to
// generate any numbers. Instead we are manually setting the value of the animation controller to
// our own calculated percentages of the user's drag delta down the screen. That is to say as the
// user drags the pointer down the screen we calculate the drag distance in reference to the top of
// the widget's original location which becomes a percentage that Tween<Offset> will then translate
// into a offset that the SlideTransition will use to move the child widget.
class _ExplicitPullDownState extends State<ExplicitPullDown> with TickerProviderStateMixin {
  bool _draggedToEnd = false;
  double _dragDelta = 0.0;
  final GlobalKey _childKey = GlobalKey();

  // Slide animation
  late Animation<Offset> _slideAnimation;
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

    // Don't allow to drag past 3/4 of the widget's original height
    if (_dragDelta >= height * 0.75) {
      _dragDelta = height * 0.75;
      setState(() => _draggedToEnd = true);
    } else {
      setState(() => _draggedToEnd = false);
    }

    // Calculate the percentage the user intended to pull down the widget
    _controller.value = _dragDelta / height;
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
        // Set close to 0%
        _controller.value = 0.0;
        _dragDelta = 0.0;
      case _Fling.down:
        // Set close to 75%
        _controller.value = 0.75;
        _dragDelta = context.size!.height * 0.75;
      default:
        // Do nothing
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onVerticalDragEnd: _handleVerticalDragEnd,
      //behavior: widget.behavior,

      // Child widget to provide slide animation for.
      child: SlideTransition(
        position: _slideAnimation,
        // Wrapping the child in a known key allows us to refer to it later
        child: KeyedSubtree(
          key: _childKey,
          child: Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: !_draggedToEnd
                    ? const Text(
                        "Drag down up to 3/4",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        "You can drag it back up if you want",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
              ),
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
