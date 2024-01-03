// Build image widget
import 'package:flutter/material.dart';
import 'image_page.dart';

// Image tile widget
class Tile extends StatelessWidget {
  final String id;
  final int index;
  final String image;
  final List<String> images;

  const Tile(
    this.id,
    this.index,
    this.image,
    this.images, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ImagePage(id, index, image, images)));
      },
      child: Stack(fit: StackFit.expand, clipBehavior: Clip.hardEdge, children: [
        // Fills the entire tile space with blue
        Container(color: Colors.blue),

        // Draw gradient at the top reaching a third of the way down
        const TopGradient(),

        // Now draw various badges over the grandient portion
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(id, style: const TextStyle(color: Colors.white)),
        ),

        // Draw a favorite icon in the top right corner
        Positioned(
          top: 1,
          right: 0,
          child: Transform.scale(scale: 0.8, child: const Icon(Icons.star, color: Colors.white)),
        ),
      ]),
    );
  }
}

/// Top gradient allows for a subtle fade out so that overlay badges are more visible.
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
