import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../const.dart';
import '../../providers/exports.dart';
import '../common/async_value.dart';
import '../media/media_tile.dart';

/// Build out media pages to reduce code duplication.
///
/// ### Supports
/// * zooming in and out on the tile size
/// * async content handling with loading and error states
/// * retrieving additional pages of content upon request
class ScrollablePageBuilder<T extends List> extends ConsumerStatefulWidget {
  const ScrollablePageBuilder(
      {super.key,
      required this.title,
      required this.asyncValue,
      required this.onNextPageRequested});
  final String title;
  final AsyncValue<T> asyncValue;
  final VoidCallback? onNextPageRequested;

  @override
  ConsumerState<ScrollablePageBuilder<T>> createState() => _PageBuilderState<T>();
}

class _PageBuilderState<T extends List> extends ConsumerState<ScrollablePageBuilder<T>> {
  // Create a scroll controller for the GridView
  late final ScrollController _scrollController;

  // Set a threshold for when to request the next page of content
  final _scrollThreshold = 200.0;

  // Track the current page and reset back to that when the user leaves the page
  var _currentScrollOffset = 0.0;

  @override
  void initState() {
    // Initialize the scroll controller with listeners for attaching and detaching
    _scrollController = ScrollController(
      onAttach: _onAttach,
      onDetach: _onDetach,
    );

    // Add a listener to the scroll controller to detect when the user has
    // scrolled to the bottom of the list
    _scrollController.addListener(_onScroll);

    // Schedule jumping to the last scroll offset after the frame has been rendered
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   // Only attempt to scroll if the view is attached
    //   if (_scrollController.hasClients) {
    //     print('TEST1');
    //     _scrollController.jumpTo(_currentScrollOffset);
    //   }
    // });
    super.initState();
  }

  void _onAttach(ScrollPosition position) {
    print('attach');
    //_scrollController.jumpTo(_currentScrollOffset);
  }

  void _onDetach(ScrollPosition position) {
    print('Detach');
  }

  // Trigger a page request when the user has scrolled to the bottom of the list
  void _onScroll() {
    final maxOffset = _scrollController.position.maxScrollExtent;
    print('Max: $maxOffset');
    print('Off: ${_scrollController.offset}');
    //if (_scrollController.offset >= maxOffset && !_scrollController.position.outOfRange) {
    // Trigger the next page request before we reach the bottom of the list
    if (_scrollController.offset >= maxOffset && !_scrollController.position.outOfRange) {
      setState(() {
        _currentScrollOffset = _scrollController.offset;
      });
      // widget.onNextPageRequested?.call();
    }
  }

  @override
  void dispose() {
    // Dispose of the scroll controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configs = ref.watch(configProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          // Zoom in on the tile
          IconButton(
            onPressed: () {
              ref.read(configProvider.notifier).zoomInTile();
            },
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
              child: Transform.scale(
                scale: 1.3,
                child: const Icon(Icons.zoom_in, color: Colors.white70),
              ),
            ),
          ),

          // Zoom out on the tile
          IconButton(
            onPressed: () {
              ref.read(configProvider.notifier).zoomOutTile();
            },
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 2.0, 5, 0),
              child: Transform.scale(
                scale: 1.3,
                child: const Icon(
                  Icons.zoom_out,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
      body: AsyncValueWidget<T>(
        asyncValue: widget.asyncValue,
        builder: (T media) {
          return Padding(
            padding: const EdgeInsets.all(Const.spacingDefault),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        configs.value != null ? configs.value!.tileSize : Const.tileSizeDefault,
                    mainAxisSpacing: Const.spacingDefault,
                    crossAxisSpacing: Const.spacingDefault,
                    // Make the standard poster image aspect ratio 3:4
                    childAspectRatio: Const.imageAspectRatioDefault),
                itemCount: media.length,
                itemBuilder: (context, index) {
                  return MediaTile(movie: media[index]);
                },
                // Set the custom scroll controller to use
                controller: _scrollController),
          );
        },
      ),
    );
  }
}
