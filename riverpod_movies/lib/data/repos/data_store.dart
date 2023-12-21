import '../models/exports.dart';

abstract class DataStore {
  /// Profiles
  Future<bool> profileExists(String name);
  Future<void> createProfile(Profile profile);
  Future<void> setSelectedProfile(Profile profile);

  // Stream<Profiles> watchProfiles();
  // Future<Profiles> profiles();

  // /// Movies
  // Future<void> setFavouriteMovie(
  //     {required String profileId, required TMDBMovieBasic movie, required bool isFavourite});
  // Stream<bool> favouriteMovie({required String profileId, required TMDBMovieBasic movie});
  // Stream<List<Movie>> allSavedMovies();
  // Stream<List<int>> favouriteMovieIDs({required String profileId});
  // Stream<List<TMDBMovieBasic>> favouriteMovies({required String profileId});
}
