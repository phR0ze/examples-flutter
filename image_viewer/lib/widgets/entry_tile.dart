import 'package:flutter/material.dart';
import '../const.dart';
import '../model.dart' as model;
import '../screens/file.dart';

/// Entry tile widget
class EntryTile extends StatelessWidget {
  final int index;
  final model.Entry entry;
  final List<model.Entry> entries;

  const EntryTile(
    this.index,
    this.entry,
    this.entries, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(entry.title),
        ),
        child: GestureDetector(
            child: Image.asset(entry.path, fit: BoxFit.cover, cacheWidth: Const.imageCacheQuality),
            onTap: () {
              if (entry is model.File) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FileScreen(index, entries)));
              }
            }));
  }
}
