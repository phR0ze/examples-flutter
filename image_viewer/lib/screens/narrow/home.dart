import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const.dart';
import '../../state.dart';
import '../../widgets/image_tile.dart';
import '../../widgets/navigation.dart';

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
          Navigation(constraints),
        ],
      ),
    );
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
            SliverAppBar(
              title: const Text('Narrow layout example'),
              backgroundColor: Colors.blue,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  Const.assetImagePlaceholder,
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                // Zoom in the thumbnail images
                IconButton(
                  onPressed: () {
                    state.zoomInImage();
                  },
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
                    child: Transform.scale(
                      scale: 1.3,
                      child: const Icon(Icons.zoom_in),
                    ),
                  ),
                ),

                // Zoom out the thumbnail images
                IconButton(
                  onPressed: () {
                    state.zoomOutImage();
                  },
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
                    child: Transform.scale(
                      scale: 1.3,
                      child: const Icon(Icons.zoom_out),
                    ),
                  ),
                ),

                // View as folders instead of images
                IconButton(
                  onPressed: () {
                    state.toggleFolderView();
                  },
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
                    child: Transform.scale(
                      scale: 1.1,
                      child: Icon(state.folderView ? Icons.perm_media : Icons.photo_library),
                    ),
                  ),
                ),

                // Pick a new folder to include
                IconButton(
                  onPressed: () {
                    // _pickFolder();
                  },
                  // Scale a little to match the grid size
                  icon: Transform.scale(
                    scale: 1.1,
                    child: const Icon(Icons.add_box),
                  ),
                ),

                // Launch the camera or screen capture tool
                IconButton(
                  onPressed: () {
                    //
                  },

                  // Push the icon down a bit to make it not look retarded
                  // Scale a little to match the grid size
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                    child: Transform.scale(
                      scale: 1.1,
                      child: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ),
              ],
            ),
            snapshot.data == null || snapshot.data!.isEmpty
                ? const SliverFillRemaining(
                    child: Center(
                      child: Text('No images found'),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(Const.imageGridSpacing),
                    sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: state.imageSize,
                          mainAxisSpacing: Const.imageGridSpacing,
                          crossAxisSpacing: Const.imageGridSpacing,
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
