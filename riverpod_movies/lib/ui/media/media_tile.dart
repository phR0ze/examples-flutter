import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../data/models/movie.dart';
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
    return Stack(
      fit: StackFit.expand,
      children: [
        _Poster(imagePath: imagePath),
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
