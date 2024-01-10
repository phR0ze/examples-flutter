import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import '../providers/app_state.dart';
import '../providers/images.dart';
import 'common/async_builder.dart';
import 'tile.dart';
import 'common/zoom_actions.dart';
import 'navigation.dart' as nav;

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(appStateProvider);
    var asyncValue = ref.watch(imagesProvider);

    return LayoutBuilder(builder: (context, size) {
      return Scaffold(
        // Only use the app drawer for narrow layouts
        drawer: isNarrow(size) ? nav.drawer(context, ref, state) : null,

        // For wide layouts persist a navigation rail on the left instead
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Image Viewer'),

              // For narrow layouts scroll AppBar off but snap back if scrolling back
              snap: isNarrow(size) ? true : false,
              floating: isNarrow(size) ? true : false,

              // For wide layout keep the AppBar pinned to the top
              pinned: isNarrow(size) ? false : true,
              actions: getZoomActions(ref),
            ),
            SliverPadding(
                padding: const EdgeInsets.all(Const.pageOutsidePadding),
                sliver: SliverAsyncBuilder<List<String>>(
                    data: asyncValue,
                    builder: (images) {
                      return SliverGrid(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: state.tileSize,
                            mainAxisSpacing: Const.pageGridVertPadding,
                            crossAxisSpacing: Const.pageGridHorzPadding,
                            childAspectRatio: Const.tileAspectRatio,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Tile('1.$index', index, images[index], images);
                            },
                            childCount: images.length,
                          ));
                    })),
          ],
        ),
      );
    });
  }
}
