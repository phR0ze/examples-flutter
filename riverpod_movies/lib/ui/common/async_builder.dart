import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generic widget that handles the three states of an AsyncValue. This allows for
/// a single place to define our error styling and loading indicator.
class SliverAsyncBuilder<T> extends StatelessWidget {
  final AsyncValue<T> data;
  final Widget Function(T) builder;

  const SliverAsyncBuilder({super.key, required this.data, required this.builder});

  @override
  Widget build(BuildContext context) {
    return data.when(
      skipError: true,
      data: builder,
      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: Text(
            error.toString(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
