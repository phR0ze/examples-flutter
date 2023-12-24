import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/exports.dart' as models;
import 'services.dart';

// Generated riverpod code
part 'now_playing.g.dart';

// Defines an async `nowPlayingProvider` Notifier for mutable state
// KeepAlive means that the provider will not be disposed when we switch pages
@Riverpod(keepAlive: true)
class NowPlaying extends _$NowPlaying {
  // Initial state
  @override
  Future<models.Movie> build() async {
    // One time read from db to prime the provider cache
    // final dataStore = ref.read(dataStoreProvider);
    // state = const AsyncLoading();
    // return await dataStore.getConfig();
    throw UnimplementedError();
  }
}
