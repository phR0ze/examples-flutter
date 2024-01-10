import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../../providers/app_state.dart';
import '../../providers/images.dart';
import 'async_builder.dart';
import '../tile.dart';
import '../common/navigation.dart';
import 'comms.dart';
import 'zoom_actions.dart';

class AppLayout extends ConsumerWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(appStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Image Viewer')),
      body: Center(
        child: Text(state.currentRoute.toString(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: state.currentRoute == 0,
              onTap: () {
                ref.read(appStateProvider.notifier).setCurrentRoute(0);
                showSnackBar('You chose navigation option: #0');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: state.currentRoute == 1,
              onTap: () {
                ref.read(appStateProvider.notifier).setCurrentRoute(1);
                showSnackBar('You chose navigation option: #1');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: state.currentRoute == 2,
              onTap: () {
                ref.read(appStateProvider.notifier).setCurrentRoute(2);
                showSnackBar('You chose navigation option: #2');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class PageBuilder extends StatelessWidget {
//   const PageBuilder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               const DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Text('Drawer Header'),
//               ),
//               ListTile(
//                 title: const Text('Item 1'),
//                 onTap: () {
//                   showSnackBar('You chose drawer option: #1');
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text('Item 2'),
//                 onTap: () {
//                   showSnackBar('You chose drawer option: #2');
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         ),
//         // Image scroller
//         body: LayoutBuilder(builder: (context, size) {
//           if (isNarrow(size)) {
//             return Column(
//               children: [
//                 Expanded(
//                   child: ImageScroller(size),
//                 ),
//               ],
//             );
//           }
//           return Row(
//             children: [
//               Navigation(size),
//               Expanded(child: ImageScroller(size)),
//             ],
//           );
//         }));
//   }
// }

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
//         backgroundColor: Colors.blue,
//         pinned: isNarrow(size) ? false : true,
//         // leading: IconButton(
//         //   icon: const Icon(Icons.menu),
//         //   onPressed: () => showSnackBar('Show menu!'),
//         // ),
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
