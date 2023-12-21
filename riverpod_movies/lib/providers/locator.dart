import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast_io.dart';
import '../data/repos/data_store.dart';

final locate = GetIt.instance;

initServicesAndRegisterWithServiceLocator() {
  // Register the enviornment variables
  locate.registerLazySingleton<Vars>(() => Env());

  // Initialize the data store once at app startup and keeping it open throughout the app's
  // lifetime as this is an expensive operation; recommended by the Sembast author.
  locate.registerSingletonAsync<DataStore>(() async {
    return await DataStore.init(databaseFactoryIo);
  });
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
