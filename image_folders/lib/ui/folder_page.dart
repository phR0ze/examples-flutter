import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import '../../const.dart';
import '../providers/entries.dart';

class FolderPage extends ConsumerStatefulWidget {
  final String path;
  const FolderPage({required this.path, super.key});

  @override
  ConsumerState<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends ConsumerState<FolderPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(entriesProvider);

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: CustomScrollView(controller: scrollController, slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(path.basename(widget.path), style: Theme.of(context).textTheme.titleLarge),
          ),
          const SliverPadding(
            // Page content external padding
            padding: EdgeInsets.all(Const.pageOutsidePadding),
            sliver: SliverToBoxAdapter(child: Text('foobar')),
            // SliverAsyncBuilder(
            //     data: widget.asyncValue,
            //     builder: (T media) {
            //       final tileWidth =
            //           configs.value != null ? configs.value!.tileSize : Const.tileWidthDefault;
            //       return SliverGrid(
            //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //               maxCrossAxisExtent: tileWidth,
            //               mainAxisSpacing: Const.pageGridPadding,
            //               crossAxisSpacing: Const.pageGridPadding,
            //               // Make the standard poster image aspect ratio 3:4
            //               childAspectRatio: Const.tileAspectRatio),
            //           delegate: SliverChildBuilderDelegate(
            //             (context, index) {
            //               if (index == media.length - 5) {
            //                 //widget.onNextPageRequested?.call();
            //               }
            //               return ItemTile(
            //                   title: 'title', tileWidth: tileWidth, debugIndex: index);
            //             },
            //             childCount: media.length,
            //           ));
            //     })
          ),
        ]),
      ),
    );
  }
}
