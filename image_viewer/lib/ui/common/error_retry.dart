import 'package:flutter/material.dart';

class ErrorRetry extends StatelessWidget {
  final double size;
  final double bottom;
  final String msg;
  final VoidCallback? onRetry;
  const ErrorRetry(
      {super.key, this.size = 80, this.bottom = 0, this.msg = 'an error occurred', this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(msg, style: TextStyle(fontSize: size * 0.2)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onRetry,
              child: Text('Retry',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
