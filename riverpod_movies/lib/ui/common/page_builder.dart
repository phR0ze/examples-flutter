import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../const.dart';
import '../../providers/exports.dart';
import '../common/async_value.dart';
import '../media/media_tile.dart';

/// Build out media pages to reduce code duplication
class PageBuilder<T extends List> extends ConsumerWidget {
  const PageBuilder(
      {super.key, required this.title, required this.asyncValue, this.onZoomIn, this.onZoomOut});
  final String title;
  final AsyncValue<T> asyncValue;
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(configProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: onZoomIn != null
            ? [
                // Zoom in the thumbnail images
                IconButton(
                  onPressed: onZoomIn,
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
                    child: Transform.scale(
                      scale: 1.3,
                      child: const Icon(Icons.zoom_in, color: Colors.white70),
                    ),
                  ),
                ),

                // Zoom out the thumbnail images
                IconButton(
                  onPressed: onZoomOut,
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
              ]
            : [],
      ),
      body: AsyncValueWidget<T>(
        asyncValue: asyncValue,
        builder: (T media) {
          return Padding(
            padding: const EdgeInsets.all(Const.spacingDefault),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: configs.value != null
                        ? configs.value!.mediaImageSize
                        : Const.imageSizeDefault,
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
