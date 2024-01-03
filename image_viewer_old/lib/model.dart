class Entry {
  final String path;
  final String title;

  const Entry(this.path, {this.title = ''});
}

class Folder extends Entry {
  int children = 0;
  final List<Folder> folders = [];
  final List<Entry> files = [];

  Folder(path) : super(path);

  // Add a file
  addFile(Entry entry) {
    children++;
    files.add(entry);
  }

  // Add a folder
  addFolder(Folder folder) {
    children++;
    folders.add(folder);
  }
}

class File extends Entry {
  const File(path, {title = ''}) : super(path, title: title);
}

class Image extends File {
  const Image(path, {title = ''}) : super(path, title: title);
}
