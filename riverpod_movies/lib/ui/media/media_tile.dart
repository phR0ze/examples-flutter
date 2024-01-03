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
    return SizedBox.expand(
      child: Container(
        color: Colors.green,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MediaBackgroundImage(movie.posterPath, imageWidth: tileWidth),

                  // Gradient to fade out background image so overlay badges are more visible
                  const MediaTopGradient(),

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
              ),
            ),
            SizedBox(
                height: 20,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(movie.title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall)),
                )),
          ],
        ),
      ),
    );
  }
}

/// Media top gradient allows for a subtle fade out of the poster image so that
/// overlay badges are more visible.
class MediaTopGradient extends StatelessWidget {
  const MediaTopGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
          // Start gradient fading immediately and reach full fade at 30% of tile direction
          stops: [0.0, 0.3],
          // Fade starts at top center
          begin: Alignment.topCenter,
          // Fade ends at bottom center
          end: Alignment.bottomCenter,
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
        alignment: Alignment.topCenter,
        placeholder: kTransparentImage,
        image: TMDB.imageUrl(imagePath!, selectPosterSize(imageWidth)),
      );
    }
    return Image.memory(kTransparentImage);
  }
}

class TitleBar extends StatelessWidget {
  final String title;
  const TitleBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    );
  }
}
