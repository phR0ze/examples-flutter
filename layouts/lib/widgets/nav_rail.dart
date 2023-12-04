import 'package:flutter/material.dart';

class NavRail extends StatelessWidget {
  const NavRail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      color: Colors.amber,
      child: const Center(
        child: Text('Navigation Rail'),
      ),
    );
  }
}
