import 'package:flutter/material.dart';

class ErrorRetry extends StatelessWidget {
  final double size;
  final String msg;
  final VoidCallback onRetry;
  const ErrorRetry(
      {super.key,
      this.size = 80,
      this.msg = 'an error occurred while loading data',
      required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(msg, style: TextStyle(fontSize: size * 0.2, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ),
        ],
      ),
    );
  }
}
