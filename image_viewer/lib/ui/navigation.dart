import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../const.dart';
import '../providers/app_state.dart';
import '../model/exports.dart' as model;
import 'common/comms.dart';

Widget drawer(BuildContext context, WidgetRef ref, model.AppState state) {
  return Drawer(
    // ListView provides scrolling if needed
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(Const.appName),
        ),
        ListTile(
          title: const Text('Folders'),
          leading: const Icon(Icons.folder),
          selected: state.currentRoute == 0,
          onTap: () {
            ref.read(appStateProvider.notifier).setCurrentRoute(0);
            showSnackBar('You chose navigation option: #0');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Gallery'),
          leading: const Icon(Icons.photo_library),
          selected: state.currentRoute == 1,
          onTap: () {
            ref.read(appStateProvider.notifier).setCurrentRoute(1);
            showSnackBar('You chose navigation option: #1');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Settings'),
          leading: const Icon(Icons.settings),
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
