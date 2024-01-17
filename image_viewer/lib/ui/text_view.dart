import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../model/exports.dart' as model;

class TextView extends StatefulWidget {
  final model.TextEntry entry;
  const TextView(this.entry, {super.key});

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Uint8List>(
        future: _textToImage(widget.entry.path),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            return Image.memory(Uint8List.view(snapshot.data!.buffer));
          }

          if (snapshot.hasError) {
            return const Text('There is something wrong!');
          }

          return const SizedBox();
        },
      ),
    );
  }
}

/// Convert the text file into an image
Future<Uint8List> _textToImage(String path) async {
  // Create the text with styling
  final text = await File(path).readAsString();
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
  );

  // Convert the paragraph into an image
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  print('before');
  textPainter.paint(canvas, const Offset(12.0, 36.0));
  print('after');
  final recording = recorder.endRecording();
  final pix = await recording.toImage(500, 500);
  final bytes = await pix.toByteData(format: ImageByteFormat.png);
  if (bytes == null) {
    print('foo');
  }
  return bytes!.buffer.asUint8List();
}
