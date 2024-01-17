import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Method signature for _loadAsync decode callbacks.
typedef _SimpleDecoderCallback = Future<ui.Codec> Function(ui.ImmutableBuffer buffer);

/// Decoces the given [String] path as text and converts it to an image, associating
/// it with the given scale.
@immutable
class TextImage extends ImageProvider<TextImage> {
  /// Creates an object that decodes a [String] path to a text as an image.
  const TextImage(this.path, this.size, {this.scale = 1.0});

  /// The path to read as a text file.
  ///
  /// The bytes represent encoded image bytes and can be encoded in any of the
  /// following supported image formats: {@macro dart.ui.imageFormats}
  final String path;

  /// The screen size to use when drawing the text.
  final Size size;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  @override
  Future<TextImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<TextImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(TextImage key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode: decode),
      scale: key.scale,
      debugLabel: key.path,
    );
  }

  Future<ui.Codec> _loadAsync(
    TextImage key, {
    required _SimpleDecoderCallback decode,
  }) async {
    assert(key == this);
    final file = File(path);
    final int lengthInBytes = await file.length();
    if (lengthInBytes == 0) {
      // The file may become available later.
      PaintingBinding.instance.imageCache.evict(key);
      throw StateError('$file is empty and cannot be loaded as an image.');
    }

    // Read the entire file as a string.
    final text = await File(path).readAsString();

    // Setup the canvas recorder
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Draw the text to a canvas
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontSize: 12,
      textDirection: TextDirection.ltr,
    ));
    builder.addText(text);
    final paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: size.width));
    // Offset.zero is the top left corner of the canvas
    canvas.drawParagraph(paragraph, const Offset(8, 8));

    // Convert the canvas to an image
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) {
      throw StateError('Error converting $path text bytes to image.');
    }
    return decode(await ui.ImmutableBuffer.fromUint8List(Uint8List.view(bytes.buffer)));
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is TextImage && other.path == path && other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(path, scale);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'TextImage')}("$path", scale: ${scale.toStringAsFixed(1)})';
}
