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
    final dataStore = ref.read(dataStoreProvider);
    state = const AsyncLoading();
    return await dataStore.getConfig();
  }

  /// Save the current profile selection to the database
  Future<void> updateCurrentProfileId(String profileId) async {
    // Immediately update the state to reflect the change
    state = AsyncData(state.value!.copyWith(currentProfileId: profileId));

    // Aysyncronously save the change to the database
    final dataStore = ref.read(dataStoreProvider);
    await dataStore.saveConfig(state.value!);
  }
}
