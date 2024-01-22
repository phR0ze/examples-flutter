import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  final String title;
  final Widget child;
  const PageButton({required this.title, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Container(
              color: Colors.black,
              child: Stack(
                children: <Widget>[
                  SizedBox.expand(child: child),

                  // Draw the close button as back up
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ))
                ],
              ),
            ),
          ),
        );
      },
      child: const Text('Flutter logo growing from 0 -> 400'),
    );
  }
}
