import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/exports.dart' as model;

// Generated riverpod code
part 'todo_filter.g.dart';

// Defines a sync `todoFilterProvider` Notifier to manage the filter state
//@Riverpod(keepAlive: true)
@riverpod
class TodoFilter extends _$TodoFilter {
  // Initial state
  @override
  model.TodoFilter build() => model.TodoFilter.all;

  // Update state
  set(model.TodoFilter filter) => state = filter;
}
