import 'dart:io';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../model/exports.dart' as model;
import 'content_page.dart';
import 'folder_page.dart';

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
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: entry.isSupported
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      switch (entry) {
                        case final model.FolderEntry folder:
                          return FolderPage(folder);
                        default:
                          return ContentPage(entry as model.FileEntry);
                      }
                    },
                  ),
                );
              }
            : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BackgroundImage(entry),

            // Gradient to fade out background image so overlay badges are more visible
            const Gradient(top: true),

            // Show the index of the tile for debugging purposes
            if (entry is model.FolderEntry)
              Positioned(
                top: 5,
                right: 5,
                child: Text(
                  '(${entry.count})',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),

            // Show the index of the tile for debugging purposes
            if (index != null)
              Positioned(
                left: 5,
                top: 5,
                child: Text(
                  '$index',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),

            if (entry is! model.ImageEntry) const Gradient(),
            if (entry is! model.ImageEntry)
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(entry.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!),
              ),
          ],
        ));
  }
}

/// Show a background image or color for the entry based on its type
class BackgroundImage extends StatelessWidget {
  final model.Entry entry;
  const BackgroundImage(this.entry, {super.key});

  Widget _placeholderImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Const.assetImagePlaceholder),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (entry) {
      case final model.ImageEntry _:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(entry.path)),
              fit: BoxFit.cover,
            ),
          ),
        );
      case final model.TextEntry _:
        return const FittedBox(
          fit: BoxFit.fill,
          child: Icon(Icons.article),
        );
      case final model.UnsupportedEntry _:
        return FittedBox(
          fit: BoxFit.fill,
          child: Container(
              //color: const Color.fromRGBO(28, 40, 55, 1),
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(entry.ext.isEmpty ? entry.name : entry.ext,
                        style: Theme.of(context).textTheme.labelSmall!),
                  ],
                ),
              )),
        );
      case final model.FolderEntry x:
        final image = x.firstImage;
        if (image != null) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(image.path)),
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return _placeholderImage();
        }
      default:
        return _placeholderImage();
    }
  }
  // }
}

/// Gradient allows for a subtle fade out of the background image so that
/// overlay badges are more visible.
class Gradient extends StatelessWidget {
  final bool top;
  const Gradient({this.top = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [
            Colors.black87,
            Colors.transparent,
          ],
          // Start gradient fading immediately and reach full fade at 30% of tile direction
          stops: const [0.0, 0.3],
          // Fade starts at top center
          begin: top ? Alignment.topCenter : Alignment.bottomCenter,
          // Fade ends at bottom center
          end: top ? Alignment.bottomCenter : Alignment.topCenter,
        ),
      ),
    );
  }
}
