import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Wraps the Riverpod AsyncValue such that we can reference the original
/// and have the unwrapped value available to the builder. This allows the builder
/// to display the cached values while also showing the loading indicator or error
/// as an additional item in the list rather than replacing the entire list with
/// the loading indicator or error.
///
/// Riverpos always caches the old value even when you call `state = AsyncValue.loading()`
/// or `state = AsyncValue.error()` so we can use this to our advantage to set the proper
/// states in the provider business logic throughout but then only show the loading indicator
/// or error as desired rather than replacing the entire list and loosing our displayed
/// content. Its a better user experience
class SliverAsyncBuilder<T> extends StatelessWidget {
  final AsyncValue<T> res;
  final Widget Function(AsyncValue<T>, T) builder;

  const SliverAsyncBuilder(this.res, this.builder, {super.key});

  @override
  Widget build(BuildContext context) {
    if (res.hasValue) {
      // Pass in the original AsyncValue and the unwrapped value so the builder
      // can decide if it wants to show a loading indicator or an error message
      // inline without wiping out the existing data.
      return builder(res, res.value as T);
    } else if (res.isLoading) {
      // Loading indicator for the full parent widget
      return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
    } else {
      // Error to load for the full parent widget
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            res.error.toString(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.red),
          ),
        ),
      );
    }
  }
}
