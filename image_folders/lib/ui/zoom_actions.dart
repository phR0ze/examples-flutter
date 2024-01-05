import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';

List<IconButton> getZoomActions(WidgetRef ref, {bool topLevel = false}) {
  // Zoom in on the tile
  return [
    IconButton(
      onPressed: () {
        if (topLevel) {
          ref.read(appStateProvider.notifier).zoomInTopLevelTile();
        } else {
          ref.read(appStateProvider.notifier).zoomInTile();
        }
      },
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
        child: Transform.scale(
          scale: 1.3,
          child: const Icon(Icons.zoom_in, color: Colors.black),
        ),
      ),
    ),

    // Zoom out on the tile
    IconButton(
      onPressed: () {
        if (topLevel) {
          ref.read(appStateProvider.notifier).zoomOutTopLevelTile();
        } else {
          ref.read(appStateProvider.notifier).zoomOutTile();
        }
      },
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2.0, 5, 0),
        child: Transform.scale(
          scale: 1.3,
          child: const Icon(
            Icons.zoom_out,
            color: Colors.black,
          ),
        ),
      ),
    ),
  ];
}
