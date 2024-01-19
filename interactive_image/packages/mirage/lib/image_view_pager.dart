import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A dismissible paging system wrapping an interactive view to an image to provide
/// pan and zoom capablities.
///
/// ### Parameters
/// - `imageProvider` - The image provider to get the image from to display.
class ImageViewPager extends StatefulWidget {
  const ImageViewPager(this.imageProvider, {Key? key}) : super(key: key);

  /// The image provider to get the image from to display.
  final ImageProvider imageProvider;

  @override
  State<ImageViewPager> createState() => _ImageViewPagerState();
}

class _ImageViewPagerState extends State<ImageViewPager> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Make the experience immersive
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    // Restore the system UI mode back to normal
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('ImageViewPager'),
      direction: DismissDirection.down,
      resizeDuration: null,
      onDismissed: (_) {
        Navigator.of(context).pop();
      },
      child: PageView.builder(
          itemCount: 1,
          controller: _pageController,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.black,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  // Allows image to take the full screen
                  SizedBox.expand(
                    child: InteractiveViewer(
                      // Default of 0.8 and 2.5 are odd and restrictive
                      minScale: 1.0,
                      maxScale: 10.0,
                      child: Image(image: widget.imageProvider),
                    ),
                  ),
                  // Close button
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ))
                ],
              ),
            );
          }),
    );
  }
}
