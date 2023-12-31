import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../data/model/exports.dart' as model;
import '../../providers/exports.dart';
import '../common/page_builder.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(nowPlayingProvider);

    return PageBuilder<List<model.Movie>>(
      title: 'Now Playing',
      asyncValue: moviesAsyncValue,
      onNextPageRequested: () {
        final nowPlaying = ref.read(nowPlayingProvider.notifier);
        nowPlaying.fetchNextPage();
      },
    );
  }
}
