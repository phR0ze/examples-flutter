import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../../data/models/exports.dart' as models;
import '../../providers/now_playing.dart';
import '../common/async_value.dart';
import 'media_scroller.dart';
import 'media_tile.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(nowPlayingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Now Playing',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      body: AsyncValueWidget<List<models.Movie>>(
        asyncValue: moviesAsyncValue,
        builder: (movies) {
          return Padding(
            padding: const EdgeInsets.all(Const.spacingDefault),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  // TODO: Make image size configurable with +/- buttons
                  // Move this to the configs
                  maxCrossAxisExtent: Const.imageSizeDefault,
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
