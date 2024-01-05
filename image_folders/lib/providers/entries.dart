import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/entry.dart';

part 'entries.g.dart';

@Riverpod(keepAlive: true)
class Entries extends _$Entries {
  @override
  Future<List<Entry>> build() async {
    return [];
  }
}
