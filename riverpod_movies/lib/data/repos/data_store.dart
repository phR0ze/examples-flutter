import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import '../models/exports.dart';

/// Setup data store paths for easy access
class StorePath {
  static const config = 'config';
  static const profiles = 'profiles';
}

/// Data store implementation using Sembast (local NoSQL database)
class DataStore {
  final Database _db;
  DataStore._(this._db);

  // Define the data stores
  final _configStore = StoreRef<String, Map<String, Object?>>.main();
  final _profileStore = stringMapStoreFactory.store(StorePath.profiles);

  // Initialize the data store reading into memory
  // Needs the type of factory to use (IO or memory) for the database.
  // - Support directory: /home/<user>/.local/share/<project name>
  static Future<DataStore> init(DatabaseFactory factory) async {
    var dbFilePath = 'default.db';
    if (factory.hasStorage) {
      final appDocDir = await getApplicationSupportDirectory();
      await appDocDir.create(recursive: true);
      dbFilePath = p.join(appDocDir.path, dbFilePath);
    }
    return DataStore._(await factory.openDatabase(dbFilePath));
  }

  /// Get global config from the data store
  Future<Config> getConfig() async {
    final record = await _configStore.record(StorePath.config).get(_db);
    return record != null ? Config.fromJson(record) : Config.defaults();
  }

  /// Save global configs to the data store
  Future<void> saveConfig(Config config) async {
    await _configStore.record(StorePath.config).put(_db, config.toJson());
  }

  /// Stores a profile's changes or creates it if needed using the profile's id
  Future<void> putProfile(Profile profile) async {
    await _profileStore.record(profile.id).put(_db, profile.toJson());
  }

  /// Get the profile by id from the data store
  Future<Profile> getProfile(String id) async {
    final record = await _profileStore.record(id).get(_db);
    if (record != null) {
      return Profile.fromJson(record);
    }
    throw StateError('Profile $id does not exist');
  }

  /// Get all profiles from the data store sorted by profile name
  Future<List<Profile>> getProfiles() async {
    // Nested sorting also works e.g. 'name.first' or 'name.last' for nested fields
    var finder = Finder(sortOrders: [SortOrder('name')]);
    final records = await _profileStore.find(_db, finder: finder);
    var profiles = records.map((x) => Profile.fromJson(x.value)).toList();
    return profiles;
  }

  /// Close the database
  Future<void> close() async {
    await _db.close();
  }
}
