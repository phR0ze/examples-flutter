import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/exports.dart' as model;
import 'todo.dart';
import 'todo_filter.dart';

final filteredTodos = FutureProvider((ref) async {
  final todos = ref.watch(todoProvider);
  final filter = ref.watch(todoFilterProvider);

  return todos.when(
    data: (todos) {
      switch (filter.state) {
        case model.TodoFilter.completed:
          return todos.where((todo) => todo.completed).toList();
        case FilterState.active:
          return todos.where((todo) => !todo.completed).toList();
        default:
          return todos;
      }
    },
  });
});

class TodoRepo {}
