import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/exports.dart' as model;
import 'todo_filter.dart';

// Generated riverpod code
part 'todos.g.dart';

// Defines an async `todosProvider` Notifier to manage the state of our todos
@Riverpod(keepAlive: true)
class Todos extends _$Todos {
  @override
  List<model.Todo> build() => const [
        model.Todo(
          id: '1',
          title: 'Example Todo 1',
          description: 'Description 1',
        ),
        model.Todo(
          id: '2',
          title: 'Example Todo 2',
          description: 'Description 2',
        ),
        model.Todo(
          id: '3',
          title: 'Example Todo 3',
          description: 'Description 3',
        ),
      ];

  // Add a new todo to our internal state
  void add(model.Todo todo) {
    state = [...state, todo];
  }

  // Mark the todo completed in our internal state
  void complete(model.Todo todo) {
    state = state.map((x) => x.id == todo.id ? todo.copyWith(completed: true) : x).toList();
  }

  // Replace the todo in our internal state with the new todo
  void replace(model.Todo todo) {
    state = state.map((x) => x.id == todo.id ? todo : x).toList();
  }

  // Delete the todo from our internal state
  void delete(model.Todo todo) {
    state = state.where((x) => x.id != todo.id).toList();
  }
}

// Helper provider to filter todos based on the current filter.
// Filter will be cached until the filter is changed or the todos list
// is changed at which point it will be re-evaluted.
final filteredTodosProvider = Provider<List<model.Todo>>((ref) {
  final todos = ref.watch(todosProvider);
  final filter = ref.watch(todoFilterProvider);

  // switch (filter) {
  //   case model.TodoFilter.completed:
  //     return todos.where((todo) => todo.completed).toList();
  //   case model.TodoFilter.pending:
  //     return todos.where((todo) => todo.pending).toList();
  //   case model.TodoFilter.all:
  //     return todos;
  // }
  return todos;
});
