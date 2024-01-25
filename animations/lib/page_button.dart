import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  final String title;
  final Widget child;
  const PageButton({required this.title, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: <Widget>[
                    // Consume full space with first layer so that the close button
                    // can be positioned in top right.
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
        child: Text(title),
      ),
    );
  }
}
