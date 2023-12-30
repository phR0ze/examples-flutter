import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generic widget that handles the three states of an AsyncValue. This allows for
/// a single place to define our error styling and loading indicator.
class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T) builder;

  const AsyncValueWidget({super.key, required this.asyncValue, required this.builder});

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      skipError: true,
      data: builder,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
