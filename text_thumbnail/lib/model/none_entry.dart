import 'entry.dart';

class NoneEntry extends Entry {
  NoneEntry() : super('');

  @override
  bool get isNone => true;

  @override
  String toString() {
    return 'NoneEntry()';
  }
}
