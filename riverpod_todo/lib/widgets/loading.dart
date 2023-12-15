import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  // Had to use two separate aligns to get the text to align properly in the center
  // of the CircularProgressIndicator. Padding is used to move the entire stack up to
  // compensat for the top tab navigation.
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 150),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ))),
          Align(
              alignment: Alignment.center,
              child: Text('Loading', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
