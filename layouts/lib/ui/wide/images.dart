import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:layouts/providers/images.dart';
import 'package:layouts/ui/common/sliver_async_builder.dart';
import '../image_tile.dart';
import '../common/navigation.dart';

class ImagesPage extends StatelessWidget {
  final BoxConstraints constraints;
  const ImagesPage(this.constraints, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wide layout example'),
          backgroundColor: Colors.blue,
        ),
        body: Row(
          children: [
            Navigation(constraints),
            Expanded(child: Container(color: Colors.pink, child: const HomeScreenScroller())),
          ],
        ));
  }
}

// Need to keep this separate from HomeScreen to avoid performance issues for some reason.
class HomeScreenScroller extends ConsumerWidget {
  const HomeScreenScroller({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncValue = ref.watch(imagesProvider);

    return CustomScrollView(slivers: [
      SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver: SliverAsyncBuilder<List<String>>(
              data: asyncValue,
              builder: (images) {
                return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100.0,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ImageTile('1.$index', index, images[index], images);
                      },
                      childCount: images.length,
                    ));
              }))
    ]);
  }
}
