import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import '../providers/app_state.dart';
import '../providers/images.dart';
import 'common/async_builder.dart';
import 'tile.dart';
import 'common/zoom_actions.dart';
import 'navigation.dart' as nav;
import 'tile_scroller.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(appStateProvider);

    return LayoutBuilder(builder: (context, size) {
      return Scaffold(
        // Only use the app drawer for narrow layouts
        drawer: isNarrow(size) ? nav.drawer(context, ref, state) : null,

        // For wide layouts persist a navigation rail on the left instead
        body: TileScroller(title: isNarrow(size) ? 'Image Viewer' : null),
      );
    });
  }
}
