import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../const.dart';
import '../../providers/exports.dart';
import 'sliver_async_builder.dart';
import '../media/media_tile.dart';

/// Build out media pages to reduce code duplication.
///
/// ### Supports
/// * zooming in and out on the tile size
/// * async content handling with loading and error states
/// * retrieving additional pages of content upon request
class PageBuilder<T extends List> extends ConsumerStatefulWidget {
  const PageBuilder(
      {super.key,
      required this.title,
      required this.asyncValue,
      required this.onNextPageRequested});
  final String title;
  final AsyncValue<T> asyncValue;
  final VoidCallback? onNextPageRequested;

  @override
  ConsumerState<PageBuilder<T>> createState() => _PageBuilderState<T>();
}

class _PageBuilderState<T extends List> extends ConsumerState<PageBuilder<T>> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final configs = ref.watch(configProvider);

    return Scaffold(
      // Scrollbar's default color is so light it's hard to see
      body: Scrollbar(
        controller: _scrollController,
        child: CustomScrollView(controller: _scrollController, slivers: [
          SliverAppBar(
            // Float the app bar and snap it back into view on any scrollback
            snap: true,
            floating: true,
            backgroundColor: Colors.black87,
            title: Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            actions: [
              // Zoom in on the tile
              IconButton(
                onPressed: () {
                  ref.read(configProvider.notifier).zoomInTile();
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
                  ref.read(configProvider.notifier).zoomOutTile();
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
            ],
          ),
          SliverPadding(
              // Page content external padding
              padding: const EdgeInsets.all(Const.pageOutsidePadding),
              sliver: SliverAsyncBuilder<T>(
                  data: widget.asyncValue,
                  builder: (T media) {
                    final tileWidth =
                        configs.value != null ? configs.value!.tileSize : Const.tileWidthDefault;
                    return SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: tileWidth,
                            mainAxisSpacing: Const.pageGridPadding,
                            crossAxisSpacing: Const.pageGridPadding,
                            // Make the standard poster image aspect ratio 3:4
                            childAspectRatio: Const.tileAspectRatio),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == media.length - 5) {
                              widget.onNextPageRequested?.call();
                            }
                            return MediaTile(
                                movie: media[index], tileWidth: tileWidth, debugIndex: index);
                          },
                          childCount: media.length,
                        ));
                  })),
        ]),
      ),
    );
  }
}
