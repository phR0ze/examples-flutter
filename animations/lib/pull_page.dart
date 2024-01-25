import 'package:flutter/material.dart';

class PullPage extends StatelessWidget {
  const PullPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Consume full space with first layer so that the close button
        // can be positioned in top right.
        SizedBox.expand(
          child: Container(
            color: Colors.blue,
            child: const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Pull down",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ),

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
    );
  }
}
