import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  final bool dialog;
  final String title;
  final Widget child;
  const PageButton({required this.title, required this.child, this.dialog = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: () {
          if (dialog) {
            showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.transparent,
              builder: (context) => child,
            );
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
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
