import 'package:mime/mime.dart';

/// Determine if given file [path] is an image
bool isImage(String path) {
  var result = false;

  final mimeType = lookupMimeType(path);
  if (mimeType != null) {
    result = mimeType.startsWith('image/');
  }

  return result;
}

/// Determine if given file [path] is a video
bool isVideo(String path) {
  var result = false;

  final mimeType = lookupMimeType(path);
  if (mimeType != null) {
    result = mimeType.startsWith('video/');
  }

  return result;
}
// Get type from header bytes
//final mimeType = lookupMimeType('image_without_extension', headerBytes: [0xFF, 0xD8]); // jpeg