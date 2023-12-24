import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/config.dart' as models;
import 'services.dart';

// Generated riverpod code
part 'config.g.dart';

// Defines an async `configProvider` Notifier for mutable state
// KeepAlive means that the provider will not be disposed when we switch pages
@Riverpod(keepAlive: true)
class Config extends _$Config {
  // Initial state
  @override
  Future<models.Config> build() async {
    // One time read from db to prime the provider cache
    return await ref.read(dataStoreProvider).getConfig();
  }

  /// Save the media image size to the database
  Future<void> updateMediaImageSize(double size) async {
    // Immediately update the state to reflect the change
    state = AsyncData(state.value!.copyWith(mediaImageSize: size));

    // Aysyncronously save the change to the database
    return ref.read(dataStoreProvider).saveConfig(state.value!);
  }

  /// Save the current profile selection to the database
  Future<void> updateCurrentProfileId(String profileId) async {
    // Immediately update the state to reflect the change
    state = AsyncData(state.value!.copyWith(currentProfileId: profileId));

    // Aysyncronously save the change to the database
    return ref.read(dataStoreProvider).saveConfig(state.value!);
  }
}
