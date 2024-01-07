import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scrolling_riverpod/ui/common/loading.dart';

import 'error.dart';

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
class AsyncBuilder<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(AsyncValue<T>, T) builder;

  const AsyncBuilder({required this.asyncValue, required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    if (asyncValue.hasValue) {
      return builder(asyncValue, asyncValue.value as T);
    } else if (asyncValue.isLoading) {
      return const LoadingIndicator();
    } else {
      return const ErrorRetry();
    }
  }
}
