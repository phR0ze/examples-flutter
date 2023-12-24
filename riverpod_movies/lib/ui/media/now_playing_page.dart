import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../data/models/exports.dart' as models;
import '../../providers/now_playing.dart';
import '../common/async_value.dart';
import 'media_scroller.dart';
import 'media_tile.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final moviesAsyncValue = ref.watch(nowPlayingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: AsyncValueWidget<List<models.Movie>>(
        asyncValue: moviesAsyncValue,
        builder: (movies) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: (screenSize.width - 32.0) / 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return MediaTile(
                  movie: movie,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
