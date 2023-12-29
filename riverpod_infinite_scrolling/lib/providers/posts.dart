import 'dart:convert';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/post.dart' as model;

// Generated riverpod code
part 'posts.g.dart';

@Riverpod(keepAlive: true)
class Posts extends _$Posts {
  int page = 0;

  @override
  Future<List<model.Post>> build() async {
    await fetchNextPage();
    return state.value!;
  }

  Future<void> fetchNextPage({int postsPerPage = 10}) async {
    // By not changing the state to a loading we can skip rebuilding the UI in a default
    // state in between pages being loaded. Originally I was emitting this state which
    // caused the UI to rebuild and show a loading indicator between pages but was so fast
    // effectively was just resetting the scroll position to the top of the list.
    // state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Post increment to get the next page next time
      print('Fetching page $page');
      final response = await get(Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=${page++}&_limit=$postsPerPage"));
      List responseList = json.decode(response.body);
      List<model.Post> posts =
          responseList.map((data) => model.Post(data['title'], data['body'])).toList();

      // Add the newly retrieved posts to the existing posts list
      if (state.value != null) {
        return [...state.value!, ...posts];
      } else {
        return posts;
      }
    });
  }
}
