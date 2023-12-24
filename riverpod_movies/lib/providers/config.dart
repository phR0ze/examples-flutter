import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../const.dart';
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

  /// Zoom in on the media image and save it to the database
  Future<void> zoomInMediaImage() async {
    if (state.value != null) {
      var size = state.value!.mediaImageSize + Const.imageSizeInc;
      state = AsyncData(state.value!.copyWith(mediaImageSize: size));
      ref.read(dataStoreProvider).saveConfig(state.value!);
    }
  }

  /// Zoom out on the media image and save it to the database
  Future<void> zoomOutMediaImage() async {
    if (state.value != null) {
      var size = state.value!.mediaImageSize;
      if (size - Const.imageSizeInc > Const.imageSizeMin) {
        size = size - Const.imageSizeInc;
        state = AsyncData(state.value!.copyWith(mediaImageSize: size));
        ref.read(dataStoreProvider).saveConfig(state.value!);
      }
    }
  }

  /// Save the current profile selection to the database
  Future<void> updateCurrentProfileId(String profileId) async {
    // Immediately update the state to reflect the change
    state = AsyncData(state.value!.copyWith(currentProfileId: profileId));

    // Aysyncronously save the change to the database
    return ref.read(dataStoreProvider).saveConfig(state.value!);
  }
}
