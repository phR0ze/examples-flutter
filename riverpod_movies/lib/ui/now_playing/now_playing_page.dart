import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../movie_scroller.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: MovieScroller(
          title: 'Now Playing',
          onNextPageRequested: () {
            // final moviesModel = ref.read(moviesModelProvider.notifier);
            // moviesModel.fetchNextPage();
          },
          builder: (_, controller) {
            //final state = ref.watch(moviesModelProvider);
            // return state.when(
            //   data: (movies, _) => FavouritesMovieGrid(
            //     key: moviesGridKey,
            //     movies: movies,
            //     controller: controller,
            //   ),
            //   dataLoading: (movies) {
            //     return movies.isEmpty
            //         ? const Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : FavouritesMovieGrid(
            //             key: moviesGridKey,
            //             movies: movies,
            //             controller: controller,
            //           );
            //   },
            //   error: (error) => Center(child: Text(error)),
            // );
          }),
    );
  }
}
