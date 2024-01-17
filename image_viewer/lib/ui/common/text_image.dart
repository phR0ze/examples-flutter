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
  const TextImage(this.path, {this.scale = 1.0});

  /// The path to read as a text file.
  ///
  /// The bytes represent encoded image bytes and can be encoded in any of the
  /// following supported image formats: {@macro dart.ui.imageFormats}
  final String path;

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
    return decode(await ui.ImmutableBuffer.fromFilePath(file.path));
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
