import 'package:flutter/material.dart';
import '../../data/models/movie.dart' as models;
import 'media_tile.dart';

class MediaGrid extends StatelessWidget {
  const MediaGrid({super.key, required this.movies, required this.controller});
  final List<models.Movie> movies;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: screenSize.width / 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 185.0 / 278.0,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MediaTile(
          movie: movie,
          //debugIndex: index,
          // favouriteBuilder:
          //     favouriteBuilder != null ? (context) => favouriteBuilder!.call(context, movie) : null,
        );
      },
      controller: controller,
    );
  }
}
