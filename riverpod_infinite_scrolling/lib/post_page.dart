import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/post.dart';
import '../post_item.dart';
import 'async_value.dart';
import 'providers/posts.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Infinite Scrolling Example",
          style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
        ),
        centerTitle: true,
      ),
      body: AsyncValueWidget<List<Post>>(
        asyncValue: posts,
        builder: (posts) {
          return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                // Trigger in advance to avoid havint to wait for content to load
                if (index == posts.length - 3) {
                  // Works but is apparently not the best way to do this
                  Future(() {
                    ref.read(postsProvider.notifier).fetchNextPage();
                  });
                }

                // If we get to the end before there is new data loaded then show
                // a loading indicator
                if (index == posts.length) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ));
                }

                // Otherwise show the post
                final post = posts[index];
                return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: PostItem(post.title, post.body, index));
              });
        },
      ),
    );
  }
}
