import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/profile.dart' as models;
import 'services.dart';

// Generated riverpod code
part 'profiles.g.dart';

// Defines an async `profilesProvider` Notifier for mutable state
// KeepAlive means that the provider will not be disposed when we switch pages
@Riverpod(keepAlive: true)
class Profiles extends _$Profiles {
  // Initial state
  @override
  Future<List<models.Profile>> build() async {
    // One time read from db to prime the provider cache
    final dataStore = ref.read(dataStoreProvider);
    state = const AsyncLoading();
    return await dataStore.getProfiles();
  }

  /// Check if the profile with the given name already exists.
  /// Assumes that profiles will always be loaded at this point in time as the consumer
  /// would have used an AsyncValueWidget to wait for the profiles to load.
  bool profileExists(String name) {
    if (state.value != null) {
      return state.value!.any((profile) => profile.name.toLowerCase() == name.toLowerCase());
    }
    return false;
  }

  /// Save the current profile selection to the database
  // Future<void> updateCurrentProfileId(String profileId) async {
  //   // Immediately update the state to reflect the change
  //   state = AsyncData(state.value!.copyWith(currentProfileId: profileId));

  //   // Aysyncronously save the change to the database
  //   final dataStore = ref.read(dataStoreProvider);
  //   await dataStore.saveConfig(state.value!);
  // }
}
