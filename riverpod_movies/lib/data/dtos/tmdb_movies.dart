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
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
    @Default([]) List<String> errors,
  }) = _TMDBMovies;

  factory TMDBMovies.fromJson(Map<String, dynamic> json) => _$TMDBMoviesFromJson(json);
}
