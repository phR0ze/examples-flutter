import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:layouts/const.dart';
import 'package:layouts/providers/app_state.dart';
import '../../providers/images.dart';
import 'async_builder.dart';
import '../tile.dart';
import '../common/navigation.dart';
import 'zoom_actions.dart';

class PageBuilder extends StatelessWidget {
  const PageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, size) {
      if (isNarrow(size)) {
        return Column(
          children: [
            Expanded(
              child: ImagesScroller(size),
            ),
            Navigation(size),
          ],
        );
      }
      return Row(
        children: [
          Navigation(size),
          Expanded(child: ImagesScroller(size)),
        ],
      );
    }));
  }
}

// Need to keep this separate from HomeScreen to avoid performance issues for some reason.
class ImagesScroller extends ConsumerWidget {
  final BoxConstraints size;
  const ImagesScroller(this.size, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = isNarrow(size) ? 'Narrow layout example' : 'Wide layout example';
    var state = ref.watch(appStateProvider);
    var asyncValue = ref.watch(imagesProvider);

    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        pinned: isNarrow(size) ? false : true,
        expandedHeight: isNarrow(size) ? Const.appBarHeight : null,
        flexibleSpace: isNarrow(size)
            ? FlexibleSpaceBar(
                background: Image.asset(
                  Const.imagePlaceholder,
                  fit: BoxFit.cover,
                ),
              )
            : null,
        actions: getZoomActions(ref),
      ),
      SliverPadding(
          padding: const EdgeInsets.all(Const.pageOutsidePadding),
          sliver: SliverAsyncBuilder<List<String>>(
              data: asyncValue,
              builder: (images) {
                return SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: state.tileSize,
                      mainAxisSpacing: Const.pageGridVertPadding,
                      crossAxisSpacing: Const.pageGridHorzPadding,
                      childAspectRatio: Const.tileAspectRatio,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Tile('1.$index', index, images[index], images);
                      },
                      childCount: images.length,
                    ));
              }))
    ]));
  }
}
