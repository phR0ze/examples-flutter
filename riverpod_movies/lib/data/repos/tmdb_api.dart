import 'package:dio/dio.dart';
import 'dart:convert';
import '../dtos/tmdb_movies.dart';
import '../../providers/services.dart';

enum HttpMethod { get, post, delete, put }

enum PosterSize {
  w92,
  w154,
  w185,
  w342,
  w500,
  w780,
  original,
}

Map<PosterSize, String> _posterSizes = {
  PosterSize.w92: "w92",
  PosterSize.w154: "w154",
  PosterSize.w185: "w185",
  PosterSize.w342: "w342",
  PosterSize.w500: "w500",
  PosterSize.w780: "w780",
  PosterSize.original: "original",
};

/// The Movie Database (TMDB) API client
class TMDB {
  final Dio dio;
  TMDB({dio}) : dio = dio ?? Dio();

  // Constants
  static const String _baseUrl = "api.themoviedb.org";
  static const String _apiVer = "3";
  static const String tmdbBaseImageUrl = "http://image.tmdb.org/t/p/";

  static String imageUrl(String path, PosterSize size) {
    return tmdbBaseImageUrl + _posterSizes[size]! + path;
  }

  /// Core reusable query function to drive all the API calls
  Future<Map<String, dynamic>> _query(
    String endPoint, {
    List<String>? optionalQueries,
  }) async {
    // Construct the query params including any optional queries
    var query = 'api_key=${locate<Vars>().tmdbKey}';
    if (optionalQueries != null && optionalQueries.isNotEmpty) {
      query += '&${optionalQueries.join('&')}';
    }

    // Construct the URI to user for the full query
    final url = Uri(
      scheme: 'https',
      host: _baseUrl,
      path: '$_apiVer/$endPoint',
      query: query,
    );

    // Execute the query
    var response = await dio.getUri<Map<String, dynamic>>(url);
    return response.data!;
  }

  /// Get a list of movies that are currently playing in theatres.
  ///
  /// ### Parameters
  /// * `page`: specifies which page to get
  /// * https://developer.themoviedb.org/reference/movie-now-playing-list
  ///
  /// ### Example
  /// ```dart
  /// await tmdb.nowPlayingMovies(page: 1);
  /// ```
  Future<TMDBMovies> getNowPlayingMovies({required int page}) async {
    if (page < 1 || page > 1000) throw Exception('Invalid page number');

    final response = await _query('movie/now_playing', optionalQueries: [
      'include_adult=false',
      'page=$page',
    ]);

    // Pretty print JSON
    //var encoder = const JsonEncoder.withIndent('  ');
    //print(encoder.convert(response));

    return TMDBMovies.fromJson(response);
  }
}
