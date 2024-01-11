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
        DrawerHeader(
          // decoration: const BoxDecoration(
          //   color: Colors.blue,
          // ),
          child: Text(Const.appName, style: Theme.of(context).textTheme.headlineMedium),
        ),
        ListTile(
          title: const Text('Folders'),
          leading: const Icon(Icons.perm_media),
          selected: state.currentRoute == 0,
          onTap: () {
            ref.read(appStateProvider.notifier).setCurrentRoute(0);
            dismissSnackBar();
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Gallery'),
          leading: const Icon(Icons.photo_library),
          selected: state.currentRoute == 1,
          onTap: () {
            ref.read(appStateProvider.notifier).setCurrentRoute(1);
            showSnackBar('Gallery is not yet implmented');
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Settings'),
          leading: const Icon(Icons.settings),
          selected: state.currentRoute == 2,
          onTap: () {
            ref.read(appStateProvider.notifier).setCurrentRoute(2);
            showSnackBar('Settings is not yet implemented');
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
