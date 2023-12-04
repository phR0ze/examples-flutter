import 'package:flutter/material.dart';

class NavRail extends StatefulWidget {
  final BoxConstraints _constraints;

  const NavRail(
    BoxConstraints constraints, {
    super.key,
  }) : _constraints = constraints;

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: widget._constraints.maxWidth > 800,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.favorite),
          label: Text('Favorites'),
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
    );
  }
}
