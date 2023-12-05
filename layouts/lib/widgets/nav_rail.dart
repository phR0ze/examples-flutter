import 'package:flutter/material.dart';

import '../const.dart';

class NavRail extends StatefulWidget {
  final BoxConstraints constraints;

  const NavRail(
    this.constraints, {
    super.key,
  });

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  // Keep state to track the selected index
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return widget.constraints.maxWidth > Const.narrowThreshold
        ? NavigationRail(
            extended: widget.constraints.maxWidth > Const.wideThreshold,
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
          )
        : BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          );
  }
}
