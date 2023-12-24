import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../../data/models/exports.dart' as models;
import '../../providers/exports.dart';
import '../common/async_value.dart';
import 'media_scroller.dart';
import 'media_tile.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(configProvider);
    final moviesAsyncValue = ref.watch(nowPlayingProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Now Playing',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          // Zoom in the thumbnail images
          IconButton(
            onPressed: () {
              ref.read(configProvider.notifier).zoomInMediaImage();
            },
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
            onPressed: () {
              ref.read(configProvider.notifier).zoomOutMediaImage();
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
      body: AsyncValueWidget<List<models.Movie>>(
        asyncValue: moviesAsyncValue,
        builder: (movies) {
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
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MediaTile(
                  movie: movies[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
