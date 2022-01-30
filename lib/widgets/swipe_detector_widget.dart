import 'package:flutter/material.dart';

class SwipeDetector extends StatelessWidget {
  final Widget child;
  final Function? onSwipeLeft;
  final Function? onSwipeRight;
  final Function? onSwipeUp;
  final Function? onSwipeDown;

  const SwipeDetector(
      {Key? key,
      required this.child,
      this.onSwipeLeft,
      this.onSwipeRight,
      this.onSwipeUp,
      this.onSwipeDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        int sensitivity = 0;
        if (details.delta.dx > sensitivity) {
          if (onSwipeLeft != null) onSwipeLeft!();
        } else if (details.delta.dx < -sensitivity) {
          if (onSwipeRight != null) onSwipeRight!();
        }
      },
      onVerticalDragUpdate: (details) {
        int sensitivity = 0;

        if (details.delta.dy > sensitivity) {
          if (onSwipeDown != null) onSwipeDown!();
        } else if (details.delta.dy < -sensitivity) {
          if (onSwipeUp != null) onSwipeUp!();
        }
      },
      child: child,
    );
  }
}
