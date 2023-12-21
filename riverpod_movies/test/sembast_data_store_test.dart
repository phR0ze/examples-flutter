import 'package:riverpod_movies/data/models/profile.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

void main() {
  disableSembastCooperator();

  test('Test profiles read/write', () async {
    // In memory factory for unit test
    var factory = newDatabaseFactoryMemory();
    var db = await factory.openDatabase('test.db');

    // Define the profiles data store
    var profileStore = stringMapStoreFactory.store('profiles');

    // Write some records
    var profile1 = const Profile(id: 'id1', name: 'profile1');
    var record1 = profileStore.record(profile1.name);
    await record1.put(db, profile1.toJson());
    expect(await record1.get(db), profile1.toJson());

    var profile2 = const Profile(id: 'id2', name: 'profile2');
    var record2 = profileStore.record(profile2.name);
    await record2.put(db, profile2.toJson());
    expect(await record2.get(db), profile2.toJson());

    // Read all records
    profileStore.find(db).then((records) {
      expect(records.length, 2);
      records.sort((a, b) => a.key.compareTo(b.key));
      expect(records[0].key, 'profile1');
      expect(records[0].value, profile1.toJson());
      expect(records[1].key, 'profile2');
      expect(records[1].value, profile2.toJson());
    });

    // Close the database
    await db.close();
  });
}
