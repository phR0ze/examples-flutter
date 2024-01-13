import 'package:flutter/material.dart';

/// A reusable loading indicator with a message.
class LoadingIndicator extends StatelessWidget {
  final double size;
  final double bottom;
  final String msg;
  const LoadingIndicator({super.key, this.size = 80, this.bottom = 0, this.msg = 'loading'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Stack(
        children: [
          // Constrain the progress indicator parent to be the given size.
          // Progress indicator fill the parent box by default.
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: size * 0.05,
            ),
          ),

          // Constrain the text parent to be the same size as the progress indicator.
          // Then add center alignment for the text in that box.
          SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Text(msg, style: TextStyle(fontSize: size * 0.2)),
            ),
          ),
        ],
      ),
    );
  }
}
