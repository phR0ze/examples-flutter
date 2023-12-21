import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../models/exports.dart';
import 'data_store.dart';

/// Setup data store paths for easy access
class StorePath {
  static const configs = 'configs';
  static const profiles = 'profiles';

  // static const movies = 'movies';
  // static String favoriteMovie(String profileId, int movieId) =>
  //     'favorites/$profileId/movie/$movieId';
  // static String favoriteMovies(String profileId) => 'favorites/$profileId';
}

/// Data store implementation using Sembast (local NoSQL database)
class SembastDataStore implements DataStore {
  static DatabaseFactory factory = databaseFactoryIo;
  SembastDataStore(this.db);
  final Database db;

  final profiles = stringMapStoreFactory.store(StorePath.profiles);

  // Open the data store, creating if necessary
  static Future<SembastDataStore> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await appDocDir.create(recursive: true);
    return SembastDataStore(
      await factory.openDatabase(p.join(appDocDir.path, 'default.db')),
    );
  }

  /// Stores a profile's changes or creates it if needed using the profile's id
  @override
  Future<void> putProfile(Profile profile) async {
    await profiles.record(profile.id).put(db, profile.toJson());
  }

  /// Get the profile by id from the data store
  @override
  Future<Profile> getProfile(String id) async {
    final record = await profiles.record(id).get(db);
    if (record != null) {
      return Profile.fromJson(record);
    }
    throw StateError('Profile $id does not exist');
  }

  /// Get all profiles from the data store
  @override
  Future<List<Profile>> getProfiles() async {
    final records = await profiles.find(db);
    return records.map((x) => Profile.fromJson(x.value)).toList();
  }

  @override
  Future<bool> profileExists(String name) async {
    // final profiles = await getProfilesData();
    // final allNames = profiles.profiles.values.map((profile) => profile.name).toList();
    // return allNames.contains(name);
    throw UnimplementedError();
  }

  @override
  Future<void> setSelectedProfile(Profile profile) async {
    // final recordName = StorePath.profiles;
    // final profilesJson = await store.record(recordName).get(db) as String?;
    // if (profilesJson != null) {
    //   final profilesData = ProfilesData.fromJson(profilesJson);
    //   if (profilesData.profiles[profile.id] != null) {
    //     final newProfiles = profilesData.copyWith(selectedId: profile.id);
    //     await store.record(recordName).put(db, newProfiles.toJson());
    //     return;
    //   }
    // }
    // throw StateError('Profile $profile does not exist and can\'t be selected');
  }

  // Stream<ProfilesData> profilesData() {
  //   final record = store.record(StorePath.profiles);
  //   return record.onSnapshot(db).map((snapshot) => ProfilesData.fromJson(snapshot?.value));
  // }

  // Future<ProfilesData> getProfilesData() async {
  //   final profilesJson = await store.record(StorePath.profiles).get(db) as String?;
  //   return profilesJson != null ? ProfilesData.fromJson(profilesJson) : ProfilesData();
  // }

  // /// Movies methods

  // Future<void> setFavouriteMovie(
  //     {required String profileId, required TMDBMovieBasic movie, required bool isFavourite}) async {
  //   // record used to show favourite flag (per-movie)
  //   await store.record(StorePath.favouriteMovie(profileId, movie.id)).put(db, isFavourite);
  //   // save movie to storage
  //   await _storeMovie(movie);
  //   // record used to show all favourites (all movies)
  //   final recordName = StorePath.favouriteMovies(profileId);
  //   final favouritesJson = await store.record(recordName).get(db) as String?;
  //   if (favouritesJson != null) {
  //     final favouriteMovies = FavouriteMovies.fromJson(favouritesJson);
  //     if (isFavourite) {
  //       if (!favouriteMovies.favouriteIDs.contains(movie.id)) {
  //         favouriteMovies.favouriteIDs.add(movie.id);
  //         await store.record(recordName).put(db, favouriteMovies.toJson());
  //       }
  //     } else {
  //       if (favouriteMovies.favouriteIDs.contains(movie.id)) {
  //         favouriteMovies.favouriteIDs.remove(movie.id);
  //         await store.record(recordName).put(db, favouriteMovies.toJson());
  //       }
  //     }
  //   } else {
  //     if (isFavourite) {
  //       final favouriteMovies = FavouriteMovies(favouriteIDs: {movie.id});
  //       await store.record(recordName).put(db, favouriteMovies.toJson());
  //     }
  //   }
  // }

  // Future<void> _storeMovie(TMDBMovieBasic movie) async {
  //   final recordName = StorePath.movies;
  //   final moviesJson = await store.record(recordName).get(db) as String?;
  //   if (moviesJson != null) {
  //     final moviesData = MoviesData.fromJson(moviesJson);
  //     // only save movie to store if it hasn't been saved before
  //     if (moviesData.movies[movie.id] == null) {
  //       moviesData.movies[movie.id] = movie;
  //       await store.record(recordName).put(db, moviesData.toJson());
  //     }
  //   } else {
  //     final moviesData = MoviesData(movies: {movie.id: movie});
  //     await store.record(recordName).put(db, moviesData.toJson());
  //   }
  // }

  // Stream<bool> favouriteMovie({required String profileId, required TMDBMovieBasic movie}) {
  //   final record = store.record(StorePath.favouriteMovie(profileId, movie.id));
  //   return record.onSnapshot(db).map((snapshot) => snapshot?.value ?? false);
  // }

  // Stream<List<TMDBMovieBasic>> allSavedMovies() {
  //   final moviesRecord = store.record(StorePath.movies);
  //   return moviesRecord.onSnapshot(db).map((snapshot) {
  //     final value = snapshot?.value;
  //     if (value != null) {
  //       final moviesData = MoviesData.fromJson(value);
  //       return moviesData.movies.values.toList();
  //     } else {
  //       return [];
  //     }
  //   });
  // }

  // Stream<List<int>> favouriteMovieIDs({required String profileId}) {
  //   final record = store.record(StorePath.favouriteMovies(profileId));
  //   return record.onSnapshot(db).map((snapshot) {
  //     final value = snapshot?.value;
  //     return value != null ? FavouriteMovies.fromJson(value).favouriteIDs.toList() : [];
  //   });
  // }

  // // Technically this should not belong to this class as it only combines streams
  // // and introduces an extra dependency (RxDart). But it's better than copy-pasting
  // // this code in all the apps.
  // Stream<List<TMDBMovieBasic>> favouriteMovies({required String profileId}) {
  //   return Rx.combineLatest2(allSavedMovies(), favouriteMovieIDs(profileId: profileId),
  //       (List<TMDBMovieBasic> movies, List<int> favourites) {
  //     return movies.where((movie) => favourites.contains(movie.id)).toList();
  //   });
  // }
}
