import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:mirage/mirage.dart' as mirage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../model/exports.dart' as model;
import '../providers/app_state.dart';
import 'content_page.dart';
import 'folder_page.dart';

class EntryTile extends StatelessWidget {
  final model.FolderEntry folder;
  final int? index;

  const EntryTile(
    this.folder, {
    this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // If index is specified then this is entry in a folder else it is the folder
    final entry = index != null ? folder[index!] : folder;

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: entry.isSupported
            ? () {
                if (entry is model.FolderEntry) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FolderPage(entry),
                    ),
                  );
                } else {
                  mirage.showImageViewPager(context, ContentProvider(folder, index!));
                }
              }
            : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BackgroundImage(entry),

            // Gradient to fade out background image so overlay badges are more visible
            if (entry is! model.ImageEntry && entry is! model.TextEntry) const Gradient(top: true),

            // Show the index of the tile for debugging purposes
            if (entry is model.FolderEntry)
              Positioned(
                top: 5,
                right: 5,
                child: Text(
                  '(${entry.count})',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                ),
              ),

            // Show the index of the tile for debugging purposes
            if (kDebugMode && index != null)
              Positioned(
                left: 5,
                top: 5,
                child: Text(
                  '$index',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                ),
              ),

            if (entry is model.FolderEntry ||
                entry is model.TextEntry ||
                entry is model.UnsupportedEntry)
              const Gradient(),
            if (entry is model.FolderEntry ||
                entry is model.TextEntry ||
                entry is model.UnsupportedEntry)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2, bottom: 1),
                  child: Text(entry.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white)),
                ),
              ),
          ],
        ));
  }
}

/// Show a background image or color for the entry based on its type
class BackgroundImage extends ConsumerWidget {
  final model.Entry entry;
  const BackgroundImage(this.entry, {super.key});

  Widget _placeholderImage(double width) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(Const.assetImagePlaceholder, cacheWidth: width.toInt()).image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStateProvider);

    switch (entry) {
      case final model.ImageEntry _:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              // by specifying width only we can retain the aspect ratio and still sample down
              image: Image.file(File(entry.path), cacheWidth: state.subTileSize.toInt()).image,
              fit: BoxFit.cover,
            ),
          ),
        );
      case final model.TextEntry _:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(const AssetImage(Const.assetDocumentIcon),
                  width: state.subTileSize.toInt()),
              fit: BoxFit.cover,
            ),
          ),
        );
      case final model.UnsupportedEntry _:
        return FittedBox(
          fit: BoxFit.fill,
          child: Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(entry.ext.isEmpty ? entry.name : entry.ext,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white)),
              )),
        );
      case final model.FolderEntry x:
        final image = x.firstImage;
        if (image != null) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.file(File(image.path), cacheWidth: state.subTileSize.toInt()).image,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return _placeholderImage(state.subTileSize);
        }
      default:
        return _placeholderImage(state.subTileSize);
    }
  }
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
            // Colors.white60,
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
