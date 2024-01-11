import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/exports.dart';

List<IconButton> themeModeAction(WidgetRef ref) {
  final state = ref.watch(appStateProvider);

  return [
    IconButton(
      onPressed: () {
        ref.read(appStateProvider.notifier).toggleDarkMode();
      },
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
        child: Transform.scale(
          scale: 1.3,
          child: Icon(state.darkMode ? Icons.light_mode : Icons.dark_mode),
        ),
      ),
    ),
  ];
}
