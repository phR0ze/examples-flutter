import 'package:flutter/material.dart';

class PullDownPage extends StatelessWidget {
  const PullDownPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
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
                      "Drag down up to 3/4",
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
      ),
    );
  }
}
