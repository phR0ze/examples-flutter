import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'file_page.dart';
import 'folder_page.dart';
import 'zoom_actions.dart';
import 'entry_tile.dart';
import '../../const.dart';
import '../model/exports.dart' as model;
import '../providers/exports.dart';
import 'sliver_async_builder.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStateProvider);
    final entries = ref.watch(entriesProvider);

    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(slivers: [
          SliverAppBar(
              snap: true,
              floating: true,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text('Image folder example', style: Theme.of(context).textTheme.titleLarge),
              actions: [
                    IconButton(
                      onPressed: () => ref.read(topFoldersProvider.notifier).addFolder(),
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
                        child: Transform.scale(
                          scale: 1.3,
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                    ),
                  ] +
                  getZoomActions(ref, topLevel: true)),
          SliverPadding(
              // Page content external padding
              padding: const EdgeInsets.all(Const.pageOutsidePadding),
              sliver: SliverAsyncBuilder<List<model.Entry>>(
                  data: entries,
                  builder: (entries) {
                    return SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: state.topTileSize,
                            mainAxisSpacing: Const.pageGridPadding,
                            crossAxisSpacing: Const.pageGridPadding,
                            childAspectRatio: Const.tileAspectRatio),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: EntryTile(entries[index]),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    if (entries[index].isFolder) {
                                      return FolderPage(entries[index] as model.Folder);
                                    }
                                    return FilePage(entries[index] as model.File);
                                  },
                                ),
                              ),
                            );
                          },
                          childCount: entries.length,
                        ));
                  })),
        ]),
      ),
    );
  }
}
