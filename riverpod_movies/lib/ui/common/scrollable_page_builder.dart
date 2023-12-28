import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../const.dart';
import '../../providers/exports.dart';
import '../common/async_value.dart';
import '../media/media_tile.dart';

/// Build out media pages to reduce code duplication.
///
/// ### Supports
/// * zooming in and out on the tile size
/// * async content handling with loading and error states
/// * retrieving additional pages of content upon request
class ScrollablePageBuilder<T extends List> extends ConsumerStatefulWidget {
  const ScrollablePageBuilder(
      {super.key,
      required this.title,
      required this.asyncValue,
      required this.onNextPageRequested});
  final String title;
  final AsyncValue<T> asyncValue;
  final VoidCallback? onNextPageRequested;

  @override
  ConsumerState<ScrollablePageBuilder<T>> createState() => _PageBuilderState<T>();
}

class _PageBuilderState<T extends List> extends ConsumerState<ScrollablePageBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    final configs = ref.watch(configProvider);

    return Scaffold(
      appBar: AppBar(
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
      body: AsyncValueWidget<T>(
        asyncValue: widget.asyncValue,
        builder: (T media) {
          return Padding(
            padding: const EdgeInsets.all(Const.spacingDefault),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        configs.value != null ? configs.value!.tileSize : Const.tileSizeDefault,
                    mainAxisSpacing: Const.spacingDefault,
                    crossAxisSpacing: Const.spacingDefault,
                    // Make the standard poster image aspect ratio 3:4
                    childAspectRatio: Const.imageAspectRatioDefault),
                itemCount: media.length,
                itemBuilder: (context, index) {
                  return MediaTile(movie: media[index]);
                }),
          );
        },
      ),
    );
  }
}
