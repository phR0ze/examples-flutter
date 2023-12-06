import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state.dart';
import '../../widgets/image_tile.dart';
import '../../widgets/navigation.dart';

class HomeScreen extends StatelessWidget {
  final BoxConstraints constraints;
  const HomeScreen(this.constraints, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Layout Examples'),
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
class HomeScreenScroller extends StatelessWidget {
  const HomeScreenScroller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return FutureBuilder<List<String>>(
      future: state.loadImages(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return CustomScrollView(slivers: [
            snapshot.data == null || snapshot.data!.isEmpty
                ? const SliverFillRemaining(
                    child: Center(
                      child: Text('No images found'),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(2.0),
                    sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100.0,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 2.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ImageTile(
                                '1.$index', index, snapshot.data![index], snapshot.data!);
                          },
                          childCount: snapshot.data!.length,
                        )),
                  ),
          ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
