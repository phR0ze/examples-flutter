import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_state.dart';
import '../model/exports.dart' as model;
import 'common/comms.dart';

Widget? drawer(BuildContext context, WidgetRef ref, model.AppState state) {
  return Drawer(
    // ListView provides scrolling if needed
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Home'),
          selected: state.currentRoute == 0,
          onTap: () {
            ref.read(appStateProvider.notifier).setCurrentRoute(0);
            showSnackBar('You chose navigation option: #0');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Business'),
          selected: state.currentRoute == 1,
          onTap: () {
            ref.read(appStateProvider.notifier).setCurrentRoute(1);
            showSnackBar('You chose navigation option: #1');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('School'),
          selected: state.currentRoute == 2,
          onTap: () {
            ref.read(appStateProvider.notifier).setCurrentRoute(2);
            showSnackBar('You chose navigation option: #2');
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

Widget? rail(BuildContext context, WidgetRef ref, model.AppState state) {
  return NavigationRail(
    extended: true,
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
    labelType: NavigationRailLabelType.all,
    selectedIndex: state.currentRoute,
    selectedIconTheme: const IconThemeData(color: Colors.blue),
    onDestinationSelected: (value) {
      showSnackBar('You chose navigation option: #$value');

      // Check if the route has changed so we don't trigger a rebuild when not needed
      if (state.currentRoute != value) {
        ref.read(appStateProvider.notifier).setCurrentRoute(value);
      }
    },
  );
}
