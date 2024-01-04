import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final String msg;
  const LoadingIndicator({super.key, this.size = 80, this.msg = 'loading'});

  // Had to use two separate aligns to get the text to align properly in the center
  // of the CircularProgressIndicator. Padding is used to move the entire stack up to
  // compensat for the top tab navigation.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    strokeWidth: size * 0.05,
                  ))),
          Padding(
            padding: EdgeInsets.only(top: size * 0.3),
            child: Align(
                alignment: Alignment.center,
                child:
                    Text(msg, style: TextStyle(fontSize: size * 0.2, fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}
