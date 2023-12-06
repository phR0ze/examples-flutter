import 'package:flutter/material.dart';
import '../widgets/comms.dart';
import '../widgets/swipe_detector.dart';

import '../const.dart';

class ImageScreen extends StatefulWidget {
  String id;
  int index;
  String image;
  final List<String> images;
  ImageScreen(this.id, this.index, this.image, this.images, {super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
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
              child: Text(widget.id, style: const TextStyle(color: Colors.black, fontSize: 36.0)),
            ),
            child: Image.asset(
              Const.assetImagePlaceholder,
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
