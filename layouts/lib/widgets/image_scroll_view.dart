import 'package:flutter/material.dart';
import 'image_tile.dart';

class ImageScrollView extends StatelessWidget {
  const ImageScrollView({
    super.key,
  });

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
                          return buildImage(snapshot.data![index]);
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
