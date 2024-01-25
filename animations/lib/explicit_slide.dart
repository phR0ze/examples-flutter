import 'package:flutter/material.dart';

class ExplicitSlide extends StatefulWidget {
  // final Widget child;
  const ExplicitSlide({
    // required this.child,
    super.key,
  });

  @override
  State<ExplicitSlide> createState() => _ExplicitSlideState();
}

// Implementation details
//
// ### SlideTransition
// Using GestureDetector to detect a user's movement to then trigger the slide animation
// in the correct direction. This requires updating the animation each time the user moves
// the pointer to account for direction changes and the distance the pointer has moved.
//
// If the user stops the movement then we need to determine if the animation should complete
// and thus trigger the close action or if the animation should return to the default position
// and the close action is not triggered.
//
// ### KeepAlive
// Using AutomaticKeepAliveClientMixin to keep the state of this widget alive even
// if we slide the animation off the screen. Otherwise the state would be lost and the
// animation would reset causing odd behaviors.
class _ExplicitSlideState extends State<ExplicitSlide> with TickerProviderStateMixin {
  //with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool _dragging = true;
  double _dragDelta = 0.0;
  final GlobalKey _childKey = GlobalKey();

  // Slide animation
  late Animation<Offset> _slideAnimation;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController =
        AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    // ..addStatusListener(_handleStatusChanged);
    _resetSlideAnimation();
  }

  void _resetSlideAnimation() {
    // Offset is used here to represent a 2D location on the screen. The slide tween
    // animation will be generating location values to move the child widget.
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      // end: Offset(0.0, _dragDelta.sign),
      end: const Offset(0.0, 1.0),
    ).animate(_slideController);
  }

  // Future<void> _handleStatusChanged(AnimationStatus status) async {
  //   if (status == AnimationStatus.completed && !_dragUnderway) {
  //     await _handleMoveCompleted();
  //   }
  //   if (mounted) {
  //     updateKeepAlive();
  //   }
  // }

  // A pointer has contacted the screen and has begun to move vertically.
  // Reset the move animation and controller and start tracking the pointer.
  void _handleVerticalDragStart(DragStartDetails details) {
    _dragging = true;
    _dragDelta = 0.0;
    _slideController.value = 0.0; // stops the animation and sets the value
    setState(() => _resetSlideAnimation());
  }

  // A pointer is currently moving vertically.
  // User is attempting to drag the current child widget.
  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    // Bail early if not dragging
    if (!_dragging) return;

    // Accumulate the primary axis drag delta
    _dragDelta += details.primaryDelta!;

    print(details.primaryDelta!);
    // final prevDelta = _dragDelta;
    // if (_dragDelta + details.primaryDelta! > 0) {
    //   _dragDelta += details.primaryDelta!;
    // }

    _slideController.value = _dragDelta.abs() / context.size!.height;
    // }
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    _dragging = false;
    if (_slideController.isCompleted) {
      //_handleMoveCompleted();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return GestureDetector(
      onVerticalDragStart: _handleVerticalDragStart,
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
            width: 100,
            height: 100,
            color: Colors.blue,
            child: const Center(
              child: Text("Drag"),
            ),
          ),
        ),
      ),
    );
  }

  // Controllers need to be disposed of to prevent memory leaks
  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }
}
