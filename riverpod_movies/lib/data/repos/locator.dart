import 'dart:io';
import 'package:get_it/get_it.dart';

final locate = GetIt.instance;

/// Initialize the service locator
initLocator() {
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
