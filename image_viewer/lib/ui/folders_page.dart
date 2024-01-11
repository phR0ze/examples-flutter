import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/ui/common/top_folder_action.dart';
import '../const.dart';
import '../providers/app_state.dart';
import '../providers/images.dart';
import 'common/async_builder.dart';
import 'navigation.dart' as nav;
import 'tile.dart';
import 'common/zoom_actions.dart';

class FoldersPage extends ConsumerWidget {
  const FoldersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStateProvider);
    final asyncValue = ref.watch(imagesProvider);

    return Scaffold(
      drawer: nav.drawer(context, ref, state),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text(Const.appName),
          snap: true,
          floating: true,
          actions: getTopFolderAction(ref) + getZoomActions(ref),
        ),
        SliverPadding(
            padding: const EdgeInsets.all(Const.pageOutsidePadding),
            sliver: SliverAsyncBuilder<List<String>>(
                data: asyncValue,
                builder: (images) {
                  return SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: state.topTileSize,
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
