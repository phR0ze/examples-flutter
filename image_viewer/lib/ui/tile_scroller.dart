import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import '../providers/app_state.dart';
import '../providers/images.dart';
import 'common/async_builder.dart';
import 'tile.dart';
import 'common/zoom_actions.dart';

/// TileScroller provides a scrolling grid of tiles for the image viewer.
/// Optionally you can set the ***title*** which will create the SliverAppBar and set its title.
class TileScroller extends ConsumerWidget {
  final String? title;
  const TileScroller({this.title, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(appStateProvider);
    var asyncValue = ref.watch(imagesProvider);

    var slivers = <Widget>[];

    // Add the SliverAppBar to the slivers list if we have a title
    if (title != null) {
      slivers.add(SliverAppBar(
        title: Text(title!),
        snap: true,
        floating: true,
        actions: getZoomActions(ref),
      ));
    }

    slivers.add(SliverPadding(
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
            })));
    return CustomScrollView(slivers: slivers);
  }
}
