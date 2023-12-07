import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import '../widgets/comms.dart';
import '../widgets/swipe_detector.dart';
import '../const.dart';
import '../model.dart' as model;

class FileScreen extends StatefulWidget {
  int index;
  model.File file;
  final List<model.Entry> entries;
  FileScreen(this.index, this.file, this.entries, {super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.file.title} - ${path.basename(widget.file.path)}'),
        backgroundColor: Colors.grey,
      ),
      body: SwipeDetector(
          child: Center(
              child: GridTile(
            header: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.file.title,
                  style: const TextStyle(color: Colors.black, fontSize: 36.0)),
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
                if (widget.index + 1 < widget.entries.length - 1)
                  {
                    setState(() {
                      widget.index++;
                      // Need to check for folders and videos and docs and handle them differently
                      widget.file = widget.entries[widget.index] as model.File;
                    })
                  }
              },
          onSwipeRight: () => {
                if (widget.index > 0)
                  {
                    setState(() {
                      widget.index--;
                      // Need to check for folders and videos and docs and handle them differently
                      widget.file = widget.entries[widget.index] as model.File;
                    })
                  }
              }),
    );
  }
}
