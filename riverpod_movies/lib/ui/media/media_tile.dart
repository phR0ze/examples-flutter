import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../const.dart';
import '../../data/model/movie.dart';
import '../../data/repos/tmdb_api.dart';

class MediaTile extends StatelessWidget {
  final Movie movie;
  final String? imagePath;
  final double tileWidth;
  final int? debugIndex;
  final WidgetBuilder? favouriteBuilder;

  const MediaTile({
    super.key,
    required this.movie,
    this.imagePath,
    this.tileWidth = Const.tileWidthDefault,
    this.debugIndex, // debugging hint to show the tile index
    this.favouriteBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // Stack the poster image => top gradient => favourite badge.
    return Stack(
      fit: StackFit.expand,
      children: [
        // Show the poster image full tile size
        //Positioned(left: 0, top: 0, child: MediaBackgroundImage(movie.posterPath)),
        MediaBackgroundImage(movie.posterPath, imageWidth: tileWidth),

        // Gradient to fade out the top of the poster image so overlay badges are more visible
        const TopGradient(),

        // Show the index of the tile for debugging purposes
        if (debugIndex != null)
          Positioned(
            left: 5,
            top: 5,
            child: Text(
              '$debugIndex',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),

        // Show the favourite badge if provided
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

class MediaBackgroundImage extends StatelessWidget {
  final String? imagePath;
  final double imageWidth;
  const MediaBackgroundImage(this.imagePath, {this.imageWidth = 154, super.key});

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: TMDB.imageUrl(imagePath!, selectPosterSize(imageWidth)),
        fit: BoxFit.fitWidth,
      );
    }
    return Image.memory(kTransparentImage);
  }
}
