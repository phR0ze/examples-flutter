import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../comms.dart';
import '../const.dart';
import '../state.dart';

class Navigation extends StatelessWidget {
  final BoxConstraints constraints;

  const Navigation(
    this.constraints, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return constraints.maxWidth > Const.narrowThreshold
        ? NavigationRail(
            extended: constraints.maxWidth > Const.wideThreshold,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.feed),
                label: Text('Feed'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favorites'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            labelType: constraints.maxWidth > Const.wideThreshold
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            selectedIndex: state.currentRoute,
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            onDestinationSelected: (value) {
              showSnackBar(context, 'You chose navigation option: #$value');

              // Check if the route has changed so we don't trigger a rebuild when not needed
              if (state.currentRoute != value) {
                state.currentRoute = value;
              }
            },
          )
        : BottomNavigationBar(
            items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.feed),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            currentIndex: state.currentRoute,
            onTap: (value) {
              showSnackBar(context, 'You chose navigation option: #$value');

              // Check if the route has changed so we don't trigger a rebuild when not needed
              if (state.currentRoute != value) {
                state.currentRoute = value;
              }
            });
  }
}
