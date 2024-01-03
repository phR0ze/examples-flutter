import 'package:flutter/material.dart';
import 'common/comms.dart';
import 'common/swipe_detector.dart';

import '../const.dart';

class ImagePage extends StatefulWidget {
  String id;
  int index;
  String image;
  final List<String> images;
  ImagePage(this.id, this.index, this.image, this.images, {super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image view'),
        backgroundColor: Colors.grey,
      ),
      body: SwipeDetector(
          child: Center(
              child: GridTile(
            header: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.id, style: Theme.of(context).textTheme.displayMedium),
            ),
            child: Image.asset(
              Const.imagePlaceholder,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          )),
          onSwipeUp: () => showSnackBar(context, 'Show image details!'),
          onSwipeDown: () => Navigator.pop(context),
          onSwipeLeft: () => {
                if (widget.index + 1 < widget.images.length - 1)
                  {
                    setState(() {
                      widget.index++;
                      widget.id = '1.${widget.index}';
                      widget.image = widget.images[widget.index];
                    })
                  }
              },
          onSwipeRight: () => {
                if (widget.index > 0)
                  {
                    setState(() {
                      widget.index--;
                      widget.id = '1.${widget.index}';
                      widget.image = widget.images[widget.index];
                    })
                  }
              }),
    );
  }
}
