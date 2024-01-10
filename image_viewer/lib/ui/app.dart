import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import '../providers/app_state.dart';
import '../providers/images.dart';
import 'common/async_builder.dart';
import 'tile.dart';
import 'navigation.dart';
import 'common/comms.dart';
import 'common/zoom_actions.dart';
import 'navigation.dart' as nav;

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(appStateProvider);

    return LayoutBuilder(builder: (context, size) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Image Viewer'),
        ),

        // Only use the app drawer for narrow layouts
        drawer: isNarrow(size) ? nav.drawer(context, ref, state) : null,

        // For wide layouts persist a navigation rail on the left instead
        body: Center(
          child: Text(state.currentRoute.toString(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      );
    });
  }
}

// // Need to keep this separate from HomeScreen to avoid performance issues for some reason.
// class ImageScroller extends ConsumerWidget {
//   final BoxConstraints size;
//   const ImageScroller(this.size, {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final title = isNarrow(size) ? 'Narrow layout example' : 'Wide layout example';
//     var state = ref.watch(appStateProvider);
//     var asyncValue = ref.watch(imagesProvider);

//     return Scaffold(
//         body: CustomScrollView(slivers: [
//       SliverAppBar(
//         title: Text(title),
//         pinned: isNarrow(size) ? false : true,
//         actions: getZoomActions(ref),
//       ),
//       SliverPadding(
//           padding: const EdgeInsets.all(Const.pageOutsidePadding),
//           sliver: SliverAsyncBuilder<List<String>>(
//               data: asyncValue,
//               builder: (images) {
//                 return SliverGrid(
//                     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                       maxCrossAxisExtent: state.tileSize,
//                       mainAxisSpacing: Const.pageGridVertPadding,
//                       crossAxisSpacing: Const.pageGridHorzPadding,
//                       childAspectRatio: Const.tileAspectRatio,
//                     ),
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         return Tile('1.$index', index, images[index], images);
//                       },
//                       childCount: images.length,
//                     ));
//               }))
//     ]));
//   }
// }
