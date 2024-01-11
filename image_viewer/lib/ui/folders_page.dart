import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/ui/common/add_folder_action.dart';
import 'package:image_viewer/ui/common/theme_action.dart';
import '../const.dart';
import '../providers/exports.dart';
import 'common/async_builder.dart';
import 'entry_tile.dart';
import 'navigation.dart' as nav;
import '../model/exports.dart' as model;
import 'common/zoom_actions.dart';

class FoldersPage extends ConsumerWidget {
  const FoldersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStateProvider);
    final res = ref.watch(entriesProvider);

    return Scaffold(
      drawer: nav.drawer(context, ref, state),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text(Const.appName),
          snap: true,
          floating: true,
          actions: addFolderAction(ref) + zoomActions(ref) + themeModeAction(ref),
        ),
        SliverPadding(
            padding: const EdgeInsets.all(Const.pageOutsidePadding),
            sliver: SliverAsyncBuilder<List<model.Entry>>(res, (res, entries) {
              return SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: state.topTileSize,
                    mainAxisSpacing: Const.pageGridPadding,
                    crossAxisSpacing: Const.pageGridPadding,
                    childAspectRatio: Const.tileAspectRatio,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == entries.length) {
                        if (res.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (res.hasError) {
                          return const Center(child: Text('Error loading folders'));
                        }
                      }
                      return EntryTile(entries[index]);
                    },
                    childCount: entries.length + (res.isLoading || res.hasError ? 1 : 0),
                  ));
            })),
      ]),
    );
  }
}
