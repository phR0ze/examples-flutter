import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state.dart';

List<Widget>? getZoomActions(WidgetRef ref) {
  // Zoom in on the tile
  return [
    IconButton(
      onPressed: () {
        ref.read(appStateProvider.notifier).zoomInTile();
      },
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
        child: Transform.scale(
          scale: 1.3,
          child: const Icon(Icons.zoom_in, color: Colors.white70),
        ),
      ),
    ),

    // Zoom out on the tile
    IconButton(
      onPressed: () {
        ref.read(appStateProvider.notifier).zoomOutTile();
      },
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2.0, 5, 0),
        child: Transform.scale(
          scale: 1.3,
          child: const Icon(
            Icons.zoom_out,
            color: Colors.white70,
          ),
        ),
      ),
    ),
  ];
}
