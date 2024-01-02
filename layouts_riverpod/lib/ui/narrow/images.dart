import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/images.dart';
import '../common/sliver_async_builder.dart';
import '../image_tile.dart';
import '../common/navigation.dart';

class ImagesPage extends StatelessWidget {
  final BoxConstraints constraints;
  const ImagesPage(this.constraints, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: ImagesScroller(),
          ),
          Navigation(constraints),
        ],
      ),
    );
  }
}

// Need to keep this separate from HomeScreen to avoid performance issues for some reason.
class ImagesScroller extends ConsumerWidget {
  const ImagesScroller({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncValue = ref.watch(imagesProvider);

    return Scaffold(
        body: Container(
      color: Colors.green,
      child: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text('Narrow layout example'),
          backgroundColor: Colors.blue,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/placeholder.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
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
      ]),
    ));
  }
}
