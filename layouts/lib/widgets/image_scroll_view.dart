import 'package:flutter/material.dart';
import 'image_tile.dart';

class ImageScrollView extends StatefulWidget {
  const ImageScrollView({
    super.key,
  });

  @override
  State<ImageScrollView> createState() => _ImageScrollViewState();
}

class _ImageScrollViewState extends State<ImageScrollView> {
  Future<List<String>> loadImages() async {
    return List.generate(2000, (index) => 'assets/images/placeholder.png');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadImages(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Container(
              color: Colors.green,
              child: CustomScrollView(slivers: [
                SliverPadding(
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
              ]),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
