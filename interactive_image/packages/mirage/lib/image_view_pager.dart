import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'image_view.dart';

/// A dismissible paging system wrapping an interactive view to an image to provide
/// pan and zoom capablities.
///
/// ### Parameters
/// - `imageProvider` - The image provider to get the image from to display.
class ImageViewPager extends StatefulWidget {
  const ImageViewPager(this.imageProviders, {Key? key}) : super(key: key);

  /// The image provider to get the image from to display.
  final List<ImageProvider> imageProviders;

  @override
  State<ImageViewPager> createState() => _ImageViewPagerState();
}

class _ImageViewPagerState extends State<ImageViewPager> {
  bool _dismissible = true;
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
      direction: _dismissible ? DismissDirection.down : DismissDirection.none,
      resizeDuration: null,
      onDismissed: (_) {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.black,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            // Allows image to take the full screen
            SizedBox.expand(
              child: PageView.builder(
                  itemCount: widget.imageProviders.length,
                  controller: _pageController,
                  physics: _dismissible
                      ? const PageScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ImageView(widget.imageProviders[index], onScale: (scale) {
                      setState(() {
                        // Disable page view swiping when the image is scaled
                        _dismissible = scale <= 1.0;
                      });
                    });
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
