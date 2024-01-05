import 'package:path/path.dart';

class Entry {
  const Entry(this.path);

  final String path;
  String get name => basename(path);
}
