import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'image_view.dart';

// Enable mouse draging and scrolling for the page view which is excluded by default.
// https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag
class MouseEnabledScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}

/// A closable paging system wrapping the ImageView to provide swipe to scroll
/// capabilities around a collection of ImageView widgets.
///
/// ### Parameters
/// - `imageProviderBuilder` - An ImageProviderBuilder for retrieving images.
class ImagePager extends StatefulWidget {
  const ImagePager(this.initialIndex, this.imageProviders, {Key? key}) : super(key: key);

  /// The index of the image to display first.
  final int initialIndex;

  /// The image provider to get the image from to display.
  final List<ImageProvider> imageProviders;

  @override
  State<ImagePager> createState() => _ImagePagerState();
}

class _ImagePagerState extends State<ImagePager> {
  bool _dismissible = true;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);

    // Make the experience immersive
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    // Restore the system UI mode back to normal
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          // Allows image to take the full screen
          SizedBox.expand(
            child: PageView.builder(
                scrollBehavior: MouseEnabledScrollBehavior(),
                itemCount: widget.imageProviders.length,
                controller: _pageController,
                physics:
                    _dismissible ? const PageScrollPhysics() : const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Stack(
                    children: <Widget>[
                      SizedBox.expand(
                        child: ImageView(widget.imageProviders[index], onScaleEnd: (scale) {
                          // setState(() {
                          //   // Disable page view swiping when the image is scaled
                          //   _dismissible = scale <= 1.0;
                          // });
                        }),
                      ),
                      Positioned(
                        top: 15,
                        left: 15,
                        child: Text(index.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ],
                  );
                }),
          ),

          // Draw the close button outside the page view to avoid the
          // eye catching UI change when the page view is swiped.
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
  }
}
