import 'package:flutter/material.dart';
import 'image_tile.dart';

class ImageScrollView extends StatelessWidget {
  final List<String> images;

  const ImageScrollView(
    List<String>? images, {
    super.key,
  }) : images = images ?? const [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: CustomScrollView(slivers: [
        images.isEmpty
            ? const SliverFillRemaining(
                child: Center(
                  child: Text('No images found'),
                ),
              )
            : SliverPadding(
                padding: const EdgeInsets.all(2.0),
                sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100.0,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ImageTile(images[index]);
                      },
                      childCount: images.length,
                    )),
              ),
      ]),
    );
  }
}
