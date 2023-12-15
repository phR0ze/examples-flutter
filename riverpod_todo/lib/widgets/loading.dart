import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

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
