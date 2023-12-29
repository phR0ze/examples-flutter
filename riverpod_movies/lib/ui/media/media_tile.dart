import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../data/model/movie.dart';
import '../../data/repos/tmdb_api.dart';

class MediaTile extends StatelessWidget {
  const MediaTile({
    super.key,
    required this.movie,
    this.imagePath,
    this.debugIndex, // debugging hint to show the tile index
    this.favouriteBuilder,
  });

  final Movie movie;
  final String? imagePath;
  final int? debugIndex;
  final WidgetBuilder? favouriteBuilder;

  @override
  Widget build(BuildContext context) {
    // Stack the poster image => top gradient => favourite badge.
    return Stack(
      fit: StackFit.expand,
      children: [
        _Poster(imagePath: movie.posterPath),
        const TopGradient(),
        if (debugIndex != null)
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              '$debugIndex',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        if (favouriteBuilder != null)
          Positioned(
            right: 0,
            top: 0,
            child: favouriteBuilder!(context),
          ),
      ],
    );
  }
}

/// Media top gradient allows for a subtle fade out of the poster image so that
/// overlay badges are more visible.
class TopGradient extends StatelessWidget {
  const TopGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
          stops: [0.0, 0.3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({this.imagePath});
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: TMDB.imageUrl(imagePath!, PosterSize.w154),
        fit: BoxFit.fitWidth,
      );
    }
    return Image.memory(kTransparentImage);
  }
}