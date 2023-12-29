import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/model/exports.dart' as model;
import '../data/repos/tmdb_api.dart';
import 'services.dart';

// Generated riverpod code
part 'now_playing.g.dart';

// Defines an async `nowPlayingProvider` Notifier for mutable state
// KeepAlive means that the provider will not be disposed when we switch pages
@Riverpod(keepAlive: true)
class NowPlaying extends _$NowPlaying {
  int _currentPage = 0;
  int _totalPages = -1;

  // Initial state
  @override
  Future<List<model.Movie>> build() async {
    _currentPage = 0;
    _totalPages = -1;

    await fetchNextPage();
    return state.value!;
  }

  /// Get the next page of movies for the current endpoint
  Future<void> fetchNextPage() async {
    // If we've reached the page limit then were done
    if (_totalPages != -1 && _currentPage >= _totalPages) {
      return;
    }

    // Fetch the next page
    state = const AsyncLoading();
    var dto = await locate<TMDB>().getNowPlayingMovies(page: ++_currentPage);

    // Update the page and result counts if reset
    if (_totalPages == -1) {
      _totalPages = dto.totalPages;
    }

    // Convert to movies and set the state
    var movies = state.value ?? [];
    movies = movies + dto.results.map((x) => model.Movie.fromJson(x.toJson())).toList();
    state = AsyncData(movies);
  }
}