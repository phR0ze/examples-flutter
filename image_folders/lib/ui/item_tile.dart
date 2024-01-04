import 'package:flutter/material.dart';
import '../../const.dart';

class ItemTile extends StatelessWidget {
  final String? title;
  final int? debugIndex;
  final double tileWidth;
  final String? bgImagePath;

  const ItemTile({
    super.key,
    this.title,
    this.debugIndex,
    this.bgImagePath,
    this.tileWidth = Const.tileWidthDefault,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: Colors.blue),
                BackgroundImage(bgImagePath, imageWidth: tileWidth),

                // Gradient to fade out background image so overlay badges are more visible
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
              ],
            ),
          ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(title!,
                  overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleSmall),
            ),
        ],
      ),
    );
  }
}

/// Top gradient allows for a subtle fade out of the background image so that
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

class BackgroundImage extends StatelessWidget {
  final String? imagePath;
  final double imageWidth;
  const BackgroundImage(this.imagePath, {this.imageWidth = Const.tileWidthDefault, super.key});

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        placeholder: Const.assetImagePlaceholder,
        image: imagePath!,
      );
    }
    return Image.asset(Const.assetImagePlaceholder);
  }
}
