import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_folders/ui/zoom_actions.dart';
import '../providers/exports.dart';
import 'entry_tile.dart';
import '../../const.dart';
import '../model/exports.dart' as model;

class FolderPage extends ConsumerStatefulWidget {
  final model.FolderEntry folder;
  const FolderPage(this.folder, {super.key});

  @override
  ConsumerState<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends ConsumerState<FolderPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appStateProvider);

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: CustomScrollView(controller: scrollController, slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('${widget.folder.name} (${widget.folder.count})',
                style: Theme.of(context).textTheme.titleLarge),
            actions: getZoomActions(ref),
          ),
          SliverPadding(
            // Page content external padding
            padding: const EdgeInsets.all(Const.pageOutsidePadding),
            sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: state.subTileSize,
                    mainAxisSpacing: Const.pageGridPadding,
                    crossAxisSpacing: Const.pageGridPadding),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return EntryTile(widget.folder.entries[index]);
                  },
                  childCount: widget.folder.length,
                )),
          ),
        ]),
      ),
    );
  }
}
