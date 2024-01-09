import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          ),
          SliverPadding(
            // Page content external padding
            padding: const EdgeInsets.all(Const.pageOutsidePadding),
            sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Const.tileWidthDefault,
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
