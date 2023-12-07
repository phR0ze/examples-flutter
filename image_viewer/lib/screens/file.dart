import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import '../utils/log.dart';
import '../widgets/comms.dart';
import '../widgets/swipe_detector.dart';
import '../const.dart';
import '../model.dart' as model;

/// [FileScreen] has ephemeral or local state to track which entry is being viewed
/// and which entries can be viewed next and previous.
class FileScreen extends StatefulWidget {
  final int index;
  final List<model.Entry> entries;
  const FileScreen(this.index, this.entries, {super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  // Only need to recreate the varibles as state here if they will change.
  // Use late to indicate that we will initialize the variables before use.
  late int _index;
  late model.File _entry;

  // Initialize the state from the FileScreen widget then update the state when the
  // widget changes. This methods is only ever called once.
  @override
  void initState() {
    super.initState();
    setState(() {
      _index = widget.index;
      _entry = widget.entries[widget.index] as model.File;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Make reusable actions for responsive design
    prev() => {
          if (_index > 0)
            {
              setState(() {
                _index--;
                // Need to check for folders and videos and docs and handle them differently
                _entry = widget.entries[_index] as model.File;
              })
            }
        };
    next() => {
          if (_index + 1 < widget.entries.length - 1)
            {
              setState(() {
                _index++;
                // Need to check for folders and videos and docs and handle them differently
                _entry = widget.entries[_index] as model.File;
              })
            }
        };

    return Scaffold(
      appBar: AppBar(
        title: Text('${_entry.title} - ${path.basename(_entry.path)}'),
        backgroundColor: Colors.grey,
      ),
      body: SwipeDetector(
        child: Center(
            child: GridTile(
          header: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                IconButton(onPressed: () => prev(), icon: const Icon(Icons.arrow_back)),
                Text(_entry.title, style: const TextStyle(color: Colors.black, fontSize: 36.0)),
                IconButton(onPressed: () => next(), icon: const Icon(Icons.arrow_forward)),
              ],
            ),
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
        onSwipeLeft: () => showSnackBar(context, 'Swipe left!'),
        onSwipeRight: () => showSnackBar(context, 'Swipe right!'),
        // onSwipeLeft: () => {
        //       if (index + 1 < widget.entries.length - 1)
        //         {
        //           setState(() {
        //             index++;
        //             // Need to check for folders and videos and docs and handle them differently
        //             entry = widget.entries[widget.index] as model.File;
        //           })
        //         }
        //     },
        // onSwipeRight: () => {
        //       if (index > 0)
        //         {
        //           setState(() {
        //             index--;
        //             // Need to check for folders and videos and docs and handle them differently
        //             entry = widget.entries[widget.index] as model.File;
        //           })
        //         }
      ),
    );
  }
}
