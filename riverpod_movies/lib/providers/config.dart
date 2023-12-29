import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../const.dart';
import '../data/model/config.dart' as model;
import 'services.dart';

// Generated riverpod code
part 'config.g.dart';

// Defines an async `configProvider` Notifier for mutable state
// KeepAlive means that the provider will not be disposed when we switch pages
@Riverpod(keepAlive: true)
class Config extends _$Config {
  // Initial state
  @override
  Future<model.Config> build() async {
    // One time read from db to prime the provider cache
    return await ref.read(dataStoreProvider).getConfig();
  }

  /// Zoom in on the tile size and save it to the database
  Future<void> zoomInTile() async {
    if (state.value != null) {
      var size = state.value!.tileSize + Const.tileSizeInc;
      state = AsyncData(state.value!.copyWith(tileSize: size));
      ref.read(dataStoreProvider).saveConfig(state.value!);
    }
  }

  /// Zoom out on the tile size and save it to the database
  Future<void> zoomOutTile() async {
    if (state.value != null) {
      var size = state.value!.tileSize;
      if (size - Const.tileSizeInc > Const.tileSizeMin) {
        size = size - Const.tileSizeInc;
        state = AsyncData(state.value!.copyWith(tileSize: size));
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
