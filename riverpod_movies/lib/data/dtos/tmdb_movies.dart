// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'tmdb_movie.dart';

part 'tmdb_movies.freezed.dart';
part 'tmdb_movies.g.dart';

@freezed
class TMDBMovies with _$TMDBMovies {
  factory TMDBMovies({
    required int page,
    required List<TMDBMovie> results,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'total_pages') required int totalPages,
    @Default([]) List<String> errors,
  }) = _TMDBMovies;

  factory TMDBMovies.fromJson(Map<String, dynamic> json) => _$TMDBMoviesFromJson(json);
}

// extension TMDBMoviesResponseX on TMDBMoviesResponse {
//   //@late
//   bool get isEmpty => !hasResults();

//   bool hasResults() {
//     return results.length > 0;
//   }

//   bool hasErrors() {
//     return errors.length > 0;
//   }
// }
