import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import '../providers/app_state.dart';
import '../providers/images.dart';
import 'common/async_builder.dart';
import 'navigation.dart' as nav;
import 'tile.dart';
import 'common/zoom_actions.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStateProvider);
    final asyncValue = ref.watch(imagesProvider);

    return Scaffold(
      drawer: nav.drawer(context, ref, state),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text('Image Viewer'),
          snap: true,
          floating: true,
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
      ]),
    );
  }
}
