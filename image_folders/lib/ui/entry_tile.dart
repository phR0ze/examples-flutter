import 'package:flutter/material.dart';
import '../../const.dart';
import '../model/exports.dart' as model;

class EntryTile extends StatelessWidget {
  final model.Entry entry;
  final int? index;

  const EntryTile(
    this.entry, {
    super.key,
    this.index,
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
                Container(
                    decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Const.assetImagePlaceholder),
                    fit: BoxFit.cover,
                  ),
                )),

                // Gradient to fade out background image so overlay badges are more visible
                const TopGradient(),

                // Show the index of the tile for debugging purposes
                if (entry is model.Folder)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Text(
                      '(${entry.count})',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),

                // Show the index of the tile for debugging purposes
                if (index != null)
                  Positioned(
                    left: 5,
                    top: 5,
                    child: Text(
                      '$index',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),

          // Column allows for placing title below the image
          Text(entry.name,
              overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleSmall),
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
