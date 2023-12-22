import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generic widget that handles the three states of an AsyncValue. This allows for
/// a single place to define our error styling and loading indicator.
class AsyncValueSliverWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T) builder;

  const AsyncValueSliverWidget({super.key, required this.asyncValue, required this.builder});

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: builder,
      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: Text(
            error.toString(),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
