import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../const.dart';
import '../model/exports.dart' as model;
import '../providers/entries.dart';
import '../providers/top_folders.dart';
import 'async_builder.dart';
import 'entry_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(entriesProvider);

    return Scaffold(
      appBar: AppBar(
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
        ],
      ),
      body: AsyncBuilder<List<model.Entry>>(res, (res, entries) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: Const.tileWidthDefault,
              mainAxisSpacing: Const.pageGridPadding,
              crossAxisSpacing: Const.pageGridPadding),
          itemCount: entries.length + (res.isLoading || res.hasError ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == entries.length) {
              if (res.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (res.hasError) {
                return const Center(child: Text('Error loading folders'));
              }
            }
            return EntryTile(entries[index]);
          },
        );
      }),
    );
  }
}
