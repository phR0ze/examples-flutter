import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_movies/data/models/exports.dart';
import '../data/repos/data_store.dart';

// Only making use of Riverpod here for global access and making this available
// in other providers via the ref parameter not for its caching capabilities.
final dataStoreProvider = Provider<DataStore>((ref) => throw UnimplementedError());

// Wrap the configs in a Riverpod provider in order to provide caching to avoid
// reading and writing to the DB unless the value has changed.

/// Initialize services and configure the service locator
final locate = GetIt.instance;
initServices() {
  // Register the enviornment variables
  locate.registerLazySingleton<Vars>(() => Env());
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
