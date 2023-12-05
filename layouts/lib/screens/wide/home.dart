import 'package:flutter/material.dart';
import '../../widgets/image_tile.dart';
import '../../widgets/nav_rail.dart';

// Data loader function
Future<List<String>> loadImages() async {
  return List.generate(2000, (index) => 'assets/images/placeholder.png');
}

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
            NavRail(constraints),
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
    return FutureBuilder<List<String>>(
      future: loadImages(),
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
                            return ImageTile('1.$index', snapshot.data![index]);
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
