import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scrolling_riverpod/ui/common/error.dart';
import 'package:infinite_scrolling_riverpod/ui/common/loading.dart';
import 'common/async_value.dart';
import 'common/end.dart';
import 'post_item.dart';
import '../providers/posts.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Infinite scrolling Riverpod"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: AsyncValueWidget(
        asyncValue: posts,
        builder: (posts) {
          return ListView.builder(
              // By allowing for an extra item in the list we can show a loading indicator
              // if we hit the bottom before more content is loaded.
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                // Trigger in advance to avoid having to wait for content to load
                if (index == posts.length - 3) {
                  // Works but is apparently not the best way to do this
                  Future(() {
                    ref.read(postsProvider.notifier).fetchNextPage();
                  });
                }

                // If we get to the end before there is new data we must have an error
                // or a loading issue or are out of data.
                if (index == posts.length) {
                  if (posts.length == 110) {
                    return const End();
                  } else if (posts.length == 10) {
                    return ErrorRetry(
                      onRetry: () {
                        print('retrying');
                        ref.read(postsProvider.notifier).fetchNextPage();
                      },
                    );
                  }
                  return const LoadingIndicator();
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
