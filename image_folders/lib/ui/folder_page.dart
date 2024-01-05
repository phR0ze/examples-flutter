import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_folders/ui/zoom_actions.dart';
import '../providers/exports.dart';
import 'entry_tile.dart';
import '../../const.dart';
import '../model/exports.dart' as model;
import 'sliver_async_builder.dart';

class FolderPage extends ConsumerWidget {
  final model.Entry entry;
  const FolderPage(this.entry, {super.key});

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
            title: Text(entry.name, style: Theme.of(context).textTheme.titleLarge),
            actions: getZoomActions(ref),
          ),
          SliverPadding(
              // Page content external padding
              padding: const EdgeInsets.all(Const.pageOutsidePadding),
              sliver: SliverAsyncBuilder<List<model.Entry>>(
                  data: entries,
                  builder: (entries) {
                    return SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: state.tileSize,
                            mainAxisSpacing: Const.pageGridPadding,
                            crossAxisSpacing: Const.pageGridPadding,
                            childAspectRatio: Const.tileAspectRatio),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return EntryTile(entries[index], index: index);
                          },
                          childCount: entries.length,
                        ));
                  })),
        ]),
      ),
    );
  }
}
