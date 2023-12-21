import 'package:riverpod_movies/data/models/exports.dart';
import 'package:riverpod_movies/data/repos/data_store.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

void main() {
  disableSembastCooperator();

  test('Test configs read/write', () async {
    var db = await DataStore.init(newDatabaseFactoryMemory());

    var configs = const Configs(currentProfileId: 'profile1');
    await db.saveConfigs(configs);

    // Read back and check
    expect(await db.getConfigs(), configs);

    // Close the database
    await db.close();
  });

  test('Test profiles read/write', () async {
    var db = await DataStore.init(newDatabaseFactoryMemory());

    // Write some profiles
    var profile1 = const Profile(id: 'id1', name: 'profile1');
    await db.putProfile(profile1);
    expect(await db.getProfile(profile1.id), profile1);

    var profile2 = const Profile(id: 'id2', name: 'profile2');
    await db.putProfile(profile2);
    expect(await db.getProfile(profile2.id), profile2);

    // Read all records
    db.getProfiles().then((profiles) {
      expect(profiles.length, 2);
      expect(profiles[0], profile1);
      expect(profiles[1], profile2);
    });

    // Close the database
    await db.close();
  });
}
