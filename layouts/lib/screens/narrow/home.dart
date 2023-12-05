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
      body: Column(
        children: [
          Expanded(
            child: Container(color: Colors.green, child: const HomeScreenScroller()),
          ),
          NavRail(constraints),
        ],
      ),
    );
  }
}

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
                            return ImageTile(snapshot.data![index]);
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
