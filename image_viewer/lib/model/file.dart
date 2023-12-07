import 'entry.dart';
import '../utils/mime.dart' as mime;

class File extends Entry {
  const File(path) : super(path);

  /// Determine if this file is an image
  bool isImage() {
    return mime.isImage(path);
  }

  /// Determine if this file is an video
  bool isVideo() {
    return mime.isVideo(path);
  }
}
