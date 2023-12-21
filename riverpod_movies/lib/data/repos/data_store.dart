import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import '../models/exports.dart';

/// Setup data store paths for easy access
class StorePath {
  static const configs = 'configs';
  static const profiles = 'profiles';
}

/// Data store implementation using Sembast (local NoSQL database)
class DataStore {
  final Database db;
  DataStore._(this.db);

  // Define the data stores
  final configStore = StoreRef<String, Map<String, Object?>>.main();
  final profileStore = stringMapStoreFactory.store(StorePath.profiles);

  // Initialize the data store reading into memory
  // Needs the type of factory to use (IO or memory) for the database.
  static Future<DataStore> init(DatabaseFactory factory) async {
    var dbFilePath = 'default.db';
    if (factory.hasStorage) {
      final appDocDir = await getApplicationDocumentsDirectory();
      await appDocDir.create(recursive: true);
      dbFilePath = p.join(appDocDir.path, dbFilePath);
    }
    return DataStore._(await factory.openDatabase(dbFilePath));
  }

  /// Get global configs from the data store
  Future<Configs> getConfigs() async {
    final record = await configStore.record(StorePath.configs).get(db);
    return record != null ? Configs.fromJson(record) : Configs.defaults();
  }

  /// Save global configs to the data store
  Future<void> saveConfigs(Configs configs) async {
    await configStore.record(StorePath.configs).put(db, configs.toJson());
  }

  /// Stores a profile's changes or creates it if needed using the profile's id
  Future<void> putProfile(Profile profile) async {
    await profileStore.record(profile.id).put(db, profile.toJson());
  }

  /// Get the profile by id from the data store
  Future<Profile> getProfile(String id) async {
    final record = await profileStore.record(id).get(db);
    if (record != null) {
      return Profile.fromJson(record);
    }
    throw StateError('Profile $id does not exist');
  }

  /// Get all profiles from the data store
  Future<List<Profile>> getProfiles() async {
    var finder = Finder(sortOrders: [SortOrder(Field.key, true)]);
    final records = await profileStore.find(db, finder: finder);
    return records.map((x) => Profile.fromJson(x.value)).toList();
  }

  /// Close the database
  Future<void> close() async {
    await db.close();
  }
}
