import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../const.dart';

// Generated riverpod code
part 'images.g.dart';

@Riverpod(keepAlive: true)
class Images extends _$Images {
  // Initial state
  @override
  Future<List<String>> build() async {
    return Future.delayed(Duration.zero, () {
      return List.generate(2000, (index) => Const.imagePlaceholder);
    });
  }
}
