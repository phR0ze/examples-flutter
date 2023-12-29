import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/model/profile.dart' as model;
import 'services.dart';

// Generated riverpod code
part 'profiles.g.dart';

// Defines an async `profilesProvider` Notifier for mutable state
// KeepAlive means that the provider will not be disposed when we switch pages
@Riverpod(keepAlive: true)
class Profiles extends _$Profiles {
  // Initial state that Riverpod will create the cache from
  @override
  Future<List<model.Profile>> build() async {
    return await _reload();
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

  /// Add or update a profile
  Future<void> putProfile(model.Profile profile) async {
    final dataStore = ref.read(dataStoreProvider);
    await dataStore.putProfile(profile);
    state = AsyncData(await _reload());
  }

  // Internal refresh once we have updated the profiles
  Future<List<model.Profile>> _reload() async {
    final dataStore = ref.read(dataStoreProvider);
    state = const AsyncLoading();
    var profiles = await dataStore.getProfiles();
    return profiles;
  }
}
