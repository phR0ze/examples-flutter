import 'package:flutter/material.dart';
import 'image_tile.dart';

class ImageScrollView extends StatelessWidget {
  const ImageScrollView({
    super.key,
  });

  Future<List<String>> loadImages() async {
    return List.generate(2000, (index) => 'assets/images/placeholder.png');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: FutureBuilder<List<String>>(
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
      ),
    );
  }
}
