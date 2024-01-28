import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_close/pull_close.dart';
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
/// ### Features
/// - Pull to close
/// - Swipe to scroll
/// - Page gap separation
/// - Bouncing scroll physics to indicate end of pages
/// - Correct PageView default to support scrolling on Desktop
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
  bool _disabled = true;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    // In order to have a nice page separation between pages we need to allow for more space
    // by increasing the viewport fraction, but then then adjust the page size to fit within
    // the original viewable area. Since the the viewport is larger than the page size there
    // will be a gap between pages.
    _pageController = PageController(initialPage: widget.initialIndex, viewportFraction: 1.05);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PullClose(
      disabled: _disabled,
      onClosed: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            // Allows image to take the full screen
            SizedBox.expand(
              child: PageView.builder(
                  controller: _pageController,
                  scrollBehavior: MouseEnabledScrollBehavior(),
                  itemCount: widget.imageProviders.length,
                  physics: _disabled
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FractionallySizedBox(
                      // Used in conjunction with an oversided viewport to show a gap between pages
                      widthFactor: 1 / _pageController.viewportFraction,
                      child: Stack(
                        children: <Widget>[
                          SizedBox.expand(
                            child: ImageView(widget.imageProviders[index], onScaleEnd: (scale) {
                              setState(() {
                                // Disable page view swiping when the image is scaled
                                _disabled = scale != 1.0;
                              });
                            }),
                          ),
                          Positioned(
                            top: 15,
                            left: 15,
                            child: Text(index.toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 20)),
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
