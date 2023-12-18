import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo.dart';
import 'todo_filter.dart';
import '../model/exports.dart' as model;

final filteredTodos = Provider<List<model.Todo>>((ref) {
  final todos = ref.watch(todoProvider);
  final filter = ref.watch(todoFilterProvider);

  switch (filter.state) {
    case model.TodoFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case model.TodoFilter.pending:
      return todos.where((todo) => !todo.completed).toList();
    case model.TodoFilter.all:
      return todos;
  }
});
