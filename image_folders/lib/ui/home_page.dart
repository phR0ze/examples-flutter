import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'zoom_actions.dart';
import 'entry_tile.dart';
import '../../const.dart';
import '../providers/exports.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appStateProvider);
    final entries = ref.watch(entriesProvider);

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: CustomScrollView(controller: scrollController, slivers: [
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
              sliver: entries.when(
                skipError: true,
                loading: () =>
                    const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
                data: (entries) {
                  return SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: state.topTileSize,
                          mainAxisSpacing: Const.pageGridPadding,
                          crossAxisSpacing: Const.pageGridPadding,
                          childAspectRatio: Const.tileAspectRatio),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return EntryTile(entries[index]);
                        },
                        childCount: entries.length,
                      ));
                },
                error: (error, trace) => Text(''),
              )),
        ]),
      ),
    );
  }
}
