import 'package:dio/dio.dart';
import '../dtos/tmdb_movies.dart';
import 'locator.dart';

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

class TMDB {
  static const String tmdbBaseImageUrl = "http://image.tmdb.org/t/p/";

  static Uri moviesNowPlaying(int page) {
    return Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/now_playing',
      queryParameters: {
        'api_key': locate<Vars>().tmdbKey,
        'include_adult': 'false',
        'page': '$page',
      },
    );
  }

  static String imageUrl(String path, PosterSize size) {
    return tmdbBaseImageUrl + _posterSizes[size]! + path;
  }
}

class TMDBClient {
  TMDBClient({required this.dio});
  factory TMDBClient.makeDefault() => TMDBClient(dio: Dio());
  final Dio dio;

  // Get a specific page of now playing movies
  Future<TMDBMovies> nowPlayingMovies({required int page}) async {
    final response = await dio.get(TMDB.moviesNowPlaying(page).toString());
    return TMDBMovies.fromJson(response.data);
  }
}
