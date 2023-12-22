import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/configs.dart' as models;
import 'services.dart';

// Generated riverpod code
part 'configs.g.dart';

// Defines a sync `configsProvider` Notifier for mutable state
@riverpod
class Configs extends _$Configs {
  // Initial state
  @override
  Future<models.Configs> build() async {
    // One time read from db to primte the provider cache
    // final dataStore = ref.read(dataStoreProvider);
    // state = const AsyncLoading();
    // return await dataStore.getConfigs();
    return models.Configs.defaults();
  }

  /// Save the current profile selection to the database
  Future<void> saveCurrentProfile(String profileId) async {
    // Immediately update the state to reflect the change
    state = AsyncData(state.value!.copyWith(currentProfileId: profileId));

    // Aysyncronously save the change to the database
    final dataStore = ref.read(dataStoreProvider);
    await dataStore.saveConfigs(state.value!);
  }
}
