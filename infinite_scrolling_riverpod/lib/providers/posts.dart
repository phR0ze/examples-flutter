import 'dart:convert';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/post.dart' as model;

// Generated riverpod code
part 'posts.g.dart';

@Riverpod(keepAlive: true)
class Posts extends _$Posts {
  int _page = 0;
  bool _retry = false;
  bool _isLastPage = false;

  @override
  Future<List<model.Post>> build() async {
    _page = 0;
    _retry = false;
    _isLastPage = false;

    await fetchNextPage();
    return state.value!;
  }

  Future<void> fetchNextPage({int postsPerPage = 10}) async {
    if (_isLastPage) {
      print('last page hit');
      return;
    }

    // Simulate an error on the first page
    if (!_retry && _page == 1) {
      _retry = true;
      print('Simulating page error');
      state = AsyncValue.error('error', StackTrace.current);
      return;
    }

    // Simulate page loading on the second page
    if (_page == 2) {
      state = const AsyncValue.loading();
      print('Simulating page loading');
      await Future.delayed(const Duration(seconds: 10));
    }

    state = await AsyncValue.guard(() async {
      // Post increment to get the next page next time
      print('Fetching page $_page');
      final response = await get(Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=${_page++}&_limit=$postsPerPage"));
      List responseList = json.decode(response.body);
      List<model.Post> posts =
          responseList.map((data) => model.Post(data['title'], data['body'])).toList();

      // Check for last page
      if (posts.length < postsPerPage) {
        _isLastPage = true;
      }

      // Add the newly retrieved posts to the existing posts list
      if (state.value != null) {
        return [...state.value!, ...posts];
      } else {
        return posts;
      }
    });
  }
}
