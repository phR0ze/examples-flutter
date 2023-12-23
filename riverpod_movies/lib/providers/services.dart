import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../data/repos/tmdb_api.dart';
import '../data/repos/data_store.dart';

// Only making use of Riverpod here for global access and making this available
// in other providers via the ref parameter not for its caching capabilities.
final dataStoreProvider = Provider<DataStore>((ref) => throw UnimplementedError());

/// Initialize services and configure the service locator
final locate = GetIt.instance;
initServices() {
  // Register the enviornment variables
  locate.registerLazySingleton<Vars>(() => Env());
  locate.registerLazySingleton<TMDB>(() => TMDB());
}

// Abstract class to allow for alternate implementations
abstract class Vars {
  get tmdbKey;
}

// Pull the TMDB API key from the environment and cache it as a provider
class Env implements Vars {
  static final Map<String, String> vars = Platform.environment;

  @override
  get tmdbKey => vars['TMDB_KEY']!;
}
