import 'package:flutter/material.dart';

/// Implements the ability to pull down a widget and have it just stay that way until
/// the page is refreshed.
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _handleVerticalDragUpdate,
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
